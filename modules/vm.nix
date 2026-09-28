{
  den,
  inputs,
  lib,
  ...
}:
let
  hosts = builtins.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts)
  );

  mkRunner =
    pkgs: name: cfgName:
    pkgs.writeShellApplication {
      inherit name;
      text =
        let
          host = inputs.self.nixosConfigurations.${cfgName}.config;
        in
        ''RUST_LOG=error ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"'';
    };
in
{
  den = {
    aspects =
      lib.listToAttrs (
        map (name: {
          name = "vm-${name}";
          value = {
            includes = [
              den.aspects.${name}
              den.aspects.vm
            ];
            excludes = [ den.aspects.hardware ];
          };
        }) hosts
      )
      // {
        vm-grub.includes = [
          den.aspects.hardware.boot
          den.aspects.theme
          den.aspects.vm-grub
        ];

      };

    hosts.x86_64-linux =
      lib.listToAttrs (
        map (name: {
          name = "vm-${name}";
          value = {
            hostName = name;
            users = lib.mapAttrs (_: _: { }) (den.hosts.x86_64-linux.${name}.users or { });
          };
        }) hosts
      )
      // {
        vm-grub = {
          theme.colorscheme = ./aspects/theme/tokyo-night-neon.yaml;
          users.tester = {
            classes = [ "user" ];
            aspect = { };
          };
        };
      };
  };

  perSystem = { pkgs, ... }: {
    packages =
      lib.listToAttrs (
        map (name: {
          name = "vm-${name}";
          value = mkRunner pkgs "vm-${name}" "vm-${name}";
        }) hosts
      )
      // {
        vm-grub-run = mkRunner pkgs "vm-grub-run" "vm-grub";
      };
  };
}

{
  inputs,
  den,
  lib,
  ...
}:
let
  vmHosts = builtins.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ./hosts)
  );

  mkVm =
    hostName: pkgs:
    pkgs.writeShellApplication {
      name = "vm-${hostName}";
      text =
        let
          host = inputs.self.nixosConfigurations."${hostName}-vm".config;
        in
        ''
          ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
        '';
    };
in
{
  den = {
    aspects = lib.listToAttrs (
      map (name: {
        name = "${name}-vm";
        value.includes = [
          den.aspects.${name}
          den.aspects.vm
        ];
      }) vmHosts
    );
    hosts.x86_64-linux = lib.listToAttrs (
      map (name: {
        name = "${name}-vm";
        value = {
          hostName = name;
          hardware = den.hosts.x86_64-linux.${name}.hardware or { };
          users.andrec = { };
        };
      }) vmHosts
    );
  };

  perSystem = { pkgs, ... }: {
    packages = lib.listToAttrs (
      map (name: {
        name = "vm-${name}";
        value = mkVm name pkgs;
      }) vmHosts
    );
  };
}

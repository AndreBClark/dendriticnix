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
in
{
  den.aspects = lib.listToAttrs (
    map (name: {
      name = "${name}-vm";
      value = {
        includes = [
          den.aspects.${name}
          den.aspects.vm
        ];
        excludes = [ den.aspects.hardware ];
      };
    }) hosts
  );

  den.hosts.x86_64-linux = lib.listToAttrs (
    map (name: {
      name = "${name}-vm";
      value = {
        hostName = name;
        # mirror the real host's users so user aspects (andrec → home-manager, etc.) resolve identically
        users = lib.mapAttrs (_: _: { }) (den.hosts.x86_64-linux.${name}.users or { });
        # or if you need the full user config: users = den.hosts.x86_64-linux.${name}.users;
      };
    }) hosts
  );

  perSystem = { pkgs, ... }: {
    packages = lib.listToAttrs (
      map (name: {
        name = "vm-${name}";
        value = pkgs.writeShellApplication {
          name = "vm-${name}";
          text =
            let
              host = inputs.self.nixosConfigurations."${name}-vm".config;
            in
            ''RUST_LOG=error ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"'';
        };
      }) hosts
    );
  };
}

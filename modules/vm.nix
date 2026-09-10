{ inputs, ... }:
{
  perSystem = { pkgs, ... }: {
    packages =
      let
        mkVm =
          hostName:
          pkgs.writeShellApplication {
            name = "vm-${hostName}";
            text =
              let
                host = inputs.self.nixosConfigurations.${hostName}.config;
              in
              ''
                ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
              '';
          };
      in
      {
        vm-seadragon = mkVm "seadragon";
        vm-dragonfly = mkVm "dragonfly";
      };
  };
}

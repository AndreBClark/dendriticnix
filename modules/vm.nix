{ inputs, den, host, ... }:
{
  perSystem = { pkgs, ... }: {
    packages.vm = pkgs.writeShellApplication {
      name = "vm";
      text =
        let
          host = inputs.self.nixosConfigurations.seadragon.config;
        in
        ''
          ${host.system.build.vm}/bin/run-${host.networking.hostName}-vm "$@"
        '';
    };
  };
  den.aspects.vm = {
    includes = [ (den.batteries.tty-autologin "andrec") ];
    nixos = { pkgs, ... }: {
      services.qemuGuest.enable = true;
      virtualisation.vmVariant = {
        virtualisation = {
          cores = 4;
          memorySize = 4096;
          qemu.options = [ "-device virtio-vga-gl" "-display gtk,gl=on" ];
        };
        users.users.andrec.extraGroups = [ "video" "render" ];
      };
    };
  };
}

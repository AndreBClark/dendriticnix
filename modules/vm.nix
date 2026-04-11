{
  inputs,
  pkgs,
  ...
}:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.vm = pkgs.writeShellApplication {
        name = "vm";
        text = ''
          ${inputs.self.nixosConfigurations.seadragon.config.system.build.vm}/bin/run-seadragon-vm
        '';
      };
    };
  den.aspects.vm = {
    nixos = {

      virtualisation.vmVariant = {
        services.displayManager.gdm.enable = true;
        services.desktopManager.gnome.enable = true;
        virtualisation.vmware.guest.enable = pkgs.stdenv.isx86_64;
        virtualisation.qemu.options = [
          "-device virtio-vga"
        ];
        users.users.andrec.extraGroups = [
          "video"
          "render"
        ];
      };

    };
  };
}

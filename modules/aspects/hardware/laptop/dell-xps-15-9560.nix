{ den, inputs, ... }:
{
  den.aspects.hardware.laptop = {
    dell-xps-15-9560-hybrid = {
      nixos.imports = [ inputs.hardware.nixosModules.dell-xps-15-9560 ];
    };

    dell-xps-15-9560-nvidia = {
      nixos.imports = [ inputs.hardware.nixosModules.dell-xps-15-9560-nvidia ];
    };

    dell-xps-15-9560-intel = {
      nixos.imports = [ inputs.hardware.nixosModules.dell-xps-15-9560-intel ];
    };
    dell-xps-15-9560 = { host, ... }: {
      includes = [
        den.aspects.hardware.laptop
        den.aspects.hardware.laptop."dell-xps-15-9560-${host.hardware.gpuMode or "hybrid"}"
      ];
      user.keyboard.model = "pc105";
    };
  };
}

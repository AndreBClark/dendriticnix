{ den, inputs, ... }:
{
  den.aspects.hardware.cpu.intel = {
    nixos =
      { ... }:
      {
        imports = builtins.attrValues {
          inherit (inputs.hardware.nixosModules)
            common-cpu-intel
            ;
        };
      };
  };
}

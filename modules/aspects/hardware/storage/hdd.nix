{ inputs, ... }:
{
  den.aspects.hardware.storage.hdd = {
    nixos =
      { ... }:
      {
        imports = builtins.attrValues {
          inherit (inputs.hardware.nixosModules)
            common-pc-hdd
            ;
        };
      };
  };
}

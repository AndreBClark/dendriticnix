{ inputs, ... }:
{
  den.aspects.hardware.storage.ssd = {
    nixos =
      { ... }:
      {
        imports = builtins.attrValues {
          inherit (inputs.hardware.nixosModules)
            common-pc-ssd
            ;
        };
      };
  };
}

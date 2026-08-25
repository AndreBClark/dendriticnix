{ den, lib, ... }:
{
  flake-file.inputs.hardware.url = "github:NixOS/nixos-hardware/master";

  den.aspects.hardware = {
    includes = [
      den.aspects.hardware.network
      den.aspects.hardware.audio
      den.aspects.hardware.keyboard
      (
        { host, ... }:
        lib.optionals (host.hardware.formFactor == "desktop") [
          den.aspects.hardware.cpu
          den.aspects.hardware.storage
        ]
        ++ lib.optional (host.hardware.gpu != null) den.aspects.hardware.gpu
      )
    ];
  };
}

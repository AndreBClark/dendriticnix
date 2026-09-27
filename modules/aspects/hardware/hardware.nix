{ den, lib, ... }:
{
  flake-file.inputs.hardware.url = "github:NixOS/nixos-hardware/master";

  den.aspects.hardware =
    { host, ... }:
    {
      includes =
        builtins.attrValues {
          inherit (den.aspects.hardware)
            boot
            network
            audio
            keyboard
            ;
        }
        ++ lib.optionals (host.hardware.formFactor == "desktop") [
          den.aspects.hardware.cpu
          den.aspects.hardware.storage
        ]
        ++ lib.optional (host.hardware.gpu != null) den.aspects.hardware.gpu
        ++
          lib.optional (host.hardware.formFactor == "laptop")
            den.aspects.hardware.laptop.${host.hardware.model or "generic"}
        ++ [
          (den.aspects.hardware.hosts.${host.hostName} or { })
        ];
    };
}

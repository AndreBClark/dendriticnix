{ den, ... }:
{
  den.aspects.base-host = { host, ... }: {
    includes = [
      den.provides.hostname
      den.aspects.fs.${host.name}
      (if host.hardware.formFactor == "desktop" then den.aspects.hardware.cpu else { })
      (if host.hardware.formFactor == "desktop" then den.aspects.hardware.storage else { })
      (if host.hardware.gpu != null then den.aspects.hardware.gpu else { })
      den.aspects.network
      den.aspects.audio
      den.aspects.keyboard
    ];
    nixos = { };
  };
}

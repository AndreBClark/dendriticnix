{ den, __findFile, ... }:
{
  den.aspects.base-host = { host, ... }: {
    includes = [
      <den/hostname>
      den.aspects.fs.${host.name}
      (if host.hardware.formFactor == "desktop" then <hardware/cpu> else { })
      (if host.hardware.formFactor == "desktop" then <hardware/storage> else { })
      (if host.hardware.gpu != null then <hardware/gpu> else { })
      <network>
      <audio>
      <keyboard>
    ];
    nixos = { };
  };
}

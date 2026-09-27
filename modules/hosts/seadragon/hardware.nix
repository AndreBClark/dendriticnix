{
  den.aspects.hardware.hosts.seadragon.nixos = {
    boot.kernelParams = [
      "edac_core.ecc_mask=0" # silence ECC ram false positive warning
    ];
  };
}

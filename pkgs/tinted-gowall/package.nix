{
  lib,
  stdenvNoCC,
  installShellFiles,
  makeWrapper,
  writableTmpDirAsHomeHook,
  writeShellApplication,
  writeShellScriptBin,
  python3,
  gowall,
  base16-schemes,
  nix-update-script,
  yq,
}:
let
  wallpaper-batch = writeShellApplication {
    name = "wallpaper-batch";
    runtimeInputs = [
      gowall
      yq
    ];
    text = builtins.readFile ./wallpaper-batch.sh;
  };

  gowall-wrap = writeShellScriptBin "gowall-wrap" ''
    : ''${XDG_CONFIG_HOME:=$HOME/.config}
    mkdir -p "$XDG_CONFIG_HOME/gowall"

    if [ -L "$XDG_CONFIG_HOME/gowall/config.yml" ]; then
      rm "$XDG_CONFIG_HOME/gowall/config.yml"
    fi

    if [ ! -e "$XDG_CONFIG_HOME/gowall/config.yml" ]; then
      ln -s @config@ "$XDG_CONFIG_HOME/gowall/config.yml"
    fi

    if [ "''${1:-}" = "-sb" ] || [ "''${1:-}" = "--smart-batch" ]; then
      shift
      exec ${wallpaper-batch}/bin/wallpaper-batch "$@"
    else
      exec @gowall@ "$@"
    fi
  '';
in
stdenvNoCC.mkDerivation {
  pname = "tinted-gowall";
  inherit (gowall) version;
  dontUnpack = true;
  passthru = {
    updateScript = nix-update-script { };
  };
  nativeBuildInputs = [
    makeWrapper
    installShellFiles
    writableTmpDirAsHomeHook
    (python3.withPackages (ps: [ ps.pyyaml ]))
  ];

  installPhase = ''
    mkdir -p $out/bin $out/share/gowall

    python3 ${./convert-base16.py} ${base16-schemes}/share/themes $out/share/gowall/config.yml

    substitute ${gowall-wrap}/bin/gowall-wrap $out/bin/tinted-gowall \
      --subst-var-by config $out/share/gowall/config.yml \
      --subst-var-by gowall ${gowall}/bin/gowall
    chmod +x $out/bin/tinted-gowall

    ln -s $out/bin/tinted-gowall $out/bin/gowall
    ln -s ${wallpaper-batch}/bin/wallpaper-batch $out/bin/wallpaper-batch

    mkdir -p $out/share/fish/vendor_completions.d
    ln -s ${gowall}/share/fish/vendor_completions.d/gowall.fish \
          $out/share/fish/vendor_completions.d/tinted-gowall.fish
    ln -s ${gowall}/share/fish/vendor_completions.d/gowall.fish \
          $out/share/fish/vendor_completions.d/gowall.fish

    install -Dm644 ${./wallpaper-batch.fish} $out/share/fish/vendor_completions.d/wallpaper-batch.fish
  '';

  meta = {
    inherit (gowall.meta) license;
    description = "Wrapper for gowall with base16-schemes support and simpler commands for bulk processing";
    homepage = gowall.meta.homepage;
    changelog = "https://github.com/Achno/gowall/releases/tag/v${gowall.version}";
    mainProgram = "tinted-gowall";
    maintainers = gowall.meta.maintainers;
    platforms = lib.platforms.unix;
  };
}

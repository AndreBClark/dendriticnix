{ den, inputs, ... }:
{
  flake-file.inputs = {
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  den.aspects.apps.spotify = {
    includes = [
      (den.batteries.unfree [
        "spotify"
      ])
    ];
    homeManager =
      { pkgs, config, ... }:
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
        sources = import ../../../npins;
        inherit (config.lib.stylix) colors;
        stylixColorScheme = {
          text = colors.base05;
          subtext = colors.base05;
          main = colors.base00;
          main-elevated = colors.base02;
          highlight = colors.base02;
          highlight-elevated = colors.base03;
          sidebar = colors.base01;
          player = colors.base04;
          card = colors.base03;
          shadow = colors.base00;
          selected-row = colors.base04;
          button = colors.base04;
          button-active = colors.base04;
          button-disabled = colors.base03;
          tab-active = colors.base02;
          notification = colors.base02;
          notification-error = colors.base08;
          equalizer = colors.base0B;
          misc = colors.base02;
        };
      in
      {
        imports = [
          inputs.spicetify-nix.homeManagerModules.spicetify
        ];
        stylix.targets.spicetify.enable = false;
        programs.spicetify = {
          enable = true;
          wayland = true;
          windowManagerPatch = true;
          colorScheme = "custom";
          customColorScheme = stylixColorScheme;

          # https://gerg-l.github.io/spicetify-nix/custom-apps.html
          enabledCustomApps = builtins.attrValues {
            inherit (spicePkgs.apps)
              newReleases
              marketplace
              ;
          };
          # https://gerg-l.github.io/spicetify-nix/extensions.html
          enabledExtensions =
            builtins.attrValues {
              inherit (spicePkgs.extensions)
                allOfArtist
                keyboardShortcut
                shuffle
                hidePodcasts
                goToSong
                listPlaylistsWithSong
                skipStats
                songStats
                aiBandBlocker
                history
                playNext
                sectionMarker
                autoSkip
                playingSource
                sortPlay
                extendedCopy
                ;
            }
            ++ [
              {
                src = "${sources.spicetify-extensions}/playback-bar-waveform/dist";
                name = "playback-bar-waveform.js";
              }
            ];
          # View all snippets: https://github.com/spicetify/marketplace/blob/main/resources/snippets.json
          enabledSnippets = [
            /* css */ ''
              * {
                font-family: ${config.stylix.fonts.monospace.name}, Noto Sans !important;
              }
            ''
            "Remove Popular sections from homepage"
            "Remove Unused Space in Topbar"
            "Remove top spacing"
            "Pointers"
            "Modern ScrollBar"
            "Fix 'DJ' Icon"
            "Fix 'Episodes' Icon"
            "Queue Top Side Panel"
            # big NPV when song has canvas
            /* css */ ''
              .main-nowPlayingView-container {
                  width: 50dvw !important;
              }

              .main-nowPlayingView-nowPlayingGrid:has(.canvasVideoContainerNPV) .main-nowPlayingView-contextItemInfo {
                  margin-top: 30vh;
              }
            ''
          ];
        };
      };
  };
}

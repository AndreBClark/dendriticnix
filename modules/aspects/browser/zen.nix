{ inputs, ... }:
{
  flake-file.inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  den.aspects.browser.zen.homeManager =
    { pkgs, ... }:
    {
      imports = [
        inputs.zen-browser.homeModules.twilight
      ];

      programs.zen-browser =
        let
          firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
        in
        {
          enable = true;
          setAsDefaultBrowser = true;
          policies = {
            AutofillAddressEnabled = true;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };
          };
          profiles = {
            default = {
              presets.betterfox.enable = true;
              settings = {
                "zen.workspaces.continue-where-left-off" = true;
                "zen.view.compact.hide-tabbar" = true;
                "zen.urlbar.behavior" = "float";
                "zen.welcome-screen.seen" = true;
              };
              search = {
                force = true;
                default = "ddg";
                engines =
                  let
                    params = [
                      {
                        name = "query";
                        value = "searchTerms";
                      }
                    ];
                  in
                  {
                    nixp = {
                      name = "NixOS Package Search";
                      urls = [
                        {
                          template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
                          inherit params;
                        }
                      ];

                      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                      definedAliases = [ "@nx" ];
                    };

                    nixopts = {
                      name = "NixOS Package Search";
                      urls = [
                        {
                          template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
                          inherit params;
                        }
                      ];

                      icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                      definedAliases = [ "@nxo" ];
                    };
                    githubRepos = {
                      name = "GitHub Repo Search";
                      urls = [
                        {
                          template = "https://github.com/search?q={searchTerms}&type=repositories";
                          inherit params;
                        }
                      ];
                      definedAliases = [
                        "@gh"
                        "@ghr"
                      ];
                    };
                    githubCode = {
                      name = "GitHub Code Search";
                      urls = [
                        {
                          template = "https://github.com/search?q={searchTerms}&type=code";
                          inherit params;
                        }
                      ];
                      definedAliases = [
                        "@ghc"
                      ];
                    };
                    githubCodeNix = {
                      name = "GitHub Nix Code Search";
                      urls = [
                        {
                          template = "https://github.com/search?q=language%3Anix+{searchTerms}&type=code";
                          inherit params;
                        }
                      ];
                      definedAliases = [
                        "@ghn"
                      ];
                    };
                    MDN = {
                      name = "MDN Web documentation";
                      urls = [
                        {
                          template = "https://developer.mozilla.org/en-US/search?q={searchTerms}";
                          inherit params;
                        }
                      ];
                      definedAliases = [ "@mdn" ];
                    };
                    youtube = {
                      name = "YouTube";
                      urls = [
                        {
                          template = "https://www.youtube.com/results?search_query={searchTerms}";
                          inherit params;
                        }
                      ];
                      definedAliases = [ "@yt" ];
                    };
                    stylix = {
                      name = "Stylix docs search";
                      urls = [
                        {
                          template = "https://nix-community.github.io/stylix/?search={searchTerms}";
                          inherit params;
                        }
                      ];
                      definedAliases = [ "@sty" ];
                    };
                    nixvim = {
                      name = "Nixvim docs Search";
                      urls = [
                        {
                          template = "https://nix-community.github.io/nixvim/?search={searchTerms}";
                          inherit params;
                        }
                      ];
                      definedAliases = [ "@xvim" ];
                    };
                  };
              };
              extensions = {
                packages = builtins.attrValues {
                  inherit (firefox-addons)
                    ublock-origin
                    bitwarden
                    consent-o-matic
                    steam-database
                    dark-mode-webextension
                    clearurls
                    dearrow
                    darkreader
                    decentraleyes
                    disconnect
                    i-dont-care-about-cookies
                    sponsorblock
                    protondb-for-steam
                    youtube-alternative-switch
                    blocktube
                    d004c62a8aed4f3b8ddd
                    ;
                };
                settings = {
                  # uBlock Origin also accepts managed storage, see 04-extensions.nix.
                  "uBlock0@raymondhill.net" = {
                    force = true;
                    settings.selectedFilterLists = [
                      "user-filters"
                      "ublock-filters"
                      "ublock-badware"
                      "ublock-privacy"
                      "ublock-unbreak"
                    ];
                  };
                };
              };
              mods = [
                "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
                "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
                "4ab93b88-151c-451b-a1b7-a1e0e28fa7f8" # No Sidebar Scrollbar
                "7190e4e9-bead-4b40-8f57-95d852ddc941" # Tab title fixes
                "803c7895-b39b-458e-84f8-a521f4d7a064" # Hide Inactive Workspaces
                "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
              ];
            };
          };
        };
      stylix.targets.zen-browser = {
        enable = true;
        profileNames = [
          "default"
        ];
      };
    };
}

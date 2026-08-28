{ den, ... }:
{
  den.aspects.cli.fzf = {
    includes = [
      (den.batteries.shell-integrations [
        "eza"
        "fzf"
        "zoxide"
      ])
    ];

    homeManager =
      { lib, pkgs, ... }:
      let
        excludesList = [
          ".git"
          ".direnv"
          ".cache"
          ".pki"
          ".dotnet"
          "pfx"
          "dosdevices"
          "*.lock"
          # Dependencies and build outputs
          "dist"
          "node_modules"
          "target"
          "build"
          "dist"
          "out"
          "result"
          # IDE and editor files
          ".vscode"
          ".idea"
          "*.swp"
          "*.swo"
          "*~"
          # OS-specific
          ".DS_Store"
          "Thumbs.db"
          # Cache and temporary
          "tmp"
          "temp"
          "*.tmp"
        ];

        excludesStr = lib.pipe excludesList [
          (map (p: "--exclude ${lib.escapeShellArg p}"))
          (lib.concatStringsSep " ")
        ];

        excludesCSV = lib.concatStringsSep "," excludesList;

        fdFlags = "--hidden --color=always " + excludesStr;
        batTheme = "base16-stylix";
        previewWindow = "--preview-window='<60(down,50%),60,border-rounded'";

        batWrapped = pkgs.writeShellScript "bat-wrapper" ''
          bat --color=always --style=numbers --theme=${batTheme} "$@"
        '';

        fdWrapped = pkgs.writeShellScript "fd-wrapper" ''
          fd "$@" ${fdFlags}
        '';

        ezaWrapped = pkgs.writeShellScript "eza-wrapper" ''
          eza --color=always "$@"
        '';

        fdCommand = "${fdWrapped} --type f";

        zoxideDirWrapped = pkgs.writeShellScript "zoxide-dir-wrapper" ''
          zoxide query -l | while read -r dir; do
            printf '%s\t%s\n' "$(sed "s|^$HOME|~|" <<< "$dir")" "$dir"
          done
        '';

        customPreviewScript = pkgs.writeShellScript "kitty-preview.sh" ''
          file=$1
          if [[ -d "$file" ]]; then
            exit 0
          fi
          type=$(file --brief --dereference --mime -- "$file")

          if [[ $type =~ image/ ]]; then
            dim=''${FZF_PREVIEW_COLUMNS}x''${FZF_PREVIEW_LINES}
            kitten icat --clear --transfer-mode=stream --unicode-placeholder --stdin=no --place="$dim@0x0" "$file"
          elif [[ $type =~ =binary ]]; then
            file "$file"
          else
            ${batWrapped} "$file"
          fi
        '';

      in
      {
        programs = {
          fzf = {
            enable = true;
            defaultCommand = fdCommand;

            changeDirWidget = {
              command = "${zoxideDirWrapped}";
              options = [
                "-1"
                "-0"
                "--delimiter '\t'"
                "--with-nth=1"
                "--accept-nth=2"
                "--preview '${ezaWrapped} --tree {2}'"
              ];
            };

            historyWidget = {
              options = [
                "--color=header:italic"
                "--preview-window=hidden"
                "--scheme=history"
                "--wrap"
                "--wrap-sign=$'\\t↳ '"
                "--bind=enter:accept-or-print-query"
              ];
            };

            defaultOptions = [
              "--ansi"
              "--style=full"
              "--filepath-word"
              "--cycle"
              "--scroll-off=3"
              "--color=border:blue"
              "--color=prompt:green"
              "--color=info:bright-black"
              previewWindow
              "--preview '${customPreviewScript} {}'"
              "--walker-skip=${excludesCSV}"
            ];

          };

          kitty.enable = lib.mkDefault true;
          eza.enable = lib.mkDefault true;
          zoxide.enable = lib.mkDefault true;

          bat = {
            enable = true;
            config = {
              map-syntax = [ "*.astro:TypeScriptReact" ];
            };
          };

          fd = {
            enable = true;
            hidden = true;
            extraOptions = [
              "--color=always"
            ];
            ignores = excludesList;
          };
        };

        home = {
          packages = builtins.attrValues {
            inherit (pkgs) file;
          };
          shellAliases = {
            find = "fd";
          };
        };

      };
  };
}

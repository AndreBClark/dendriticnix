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
      {
        lib,
        pkgs,
        config,
        ...
      }:
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

        colors = config.lib.stylix.colors.withHashtag;

        excludesStr = lib.pipe excludesList [
          (map (p: "--exclude ${lib.escapeShellArg p}"))
          (lib.concatStringsSep " ")
        ];

        excludesCSV = lib.concatStringsSep "," excludesList;
        batTheme = "base16-stylix";
        previewWindow = "--preview-window='right,border-rounded,wrap,60%,<60(down,50%)'";

        batWrapped = pkgs.writeShellScript "bat-wrapper" ''
          bat --color=always --style=numbers --theme=${batTheme} "$@"
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

        fzf = {
          defaultOptions = [
            "--height=40%"
            "--min-height=20+"
            "--bind=ctrl-z:ignore"
            "--reverse"
            "--walker=file,dir,follow,hidden"
            "--scheme=path"
            "--ansi"
            "--style=full"
            "--filepath-word"
            "--cycle"
            "--scroll-off=3"
            previewWindow
            "--walker-skip=${excludesCSV}"
            "-1"
            "-0"
          ];

          colors = with colors; {
            "bg" = base00;
            "bg+" = base01;
            "fg" = base04;
            "fg+" = base06;
            "header" = base0C;
            "hl" = base0D;
            "hl+" = base0D;
            "info" = base0A;
            "marker" = base0E;
            "pointer" = base0E;
            "prompt" = base0D;
            "spinner" = base0E;
            "border" = base0D;
          };
        };

        fzfColorsStr =
          "--color="
          + lib.concatStringsSep "," (lib.mapAttrsToList (name: value: "${name}:${value}") fzf.colors);

        fzfDefaultOptionsPiped = lib.concatStringsSep " " fzf.defaultOptions;

        fzfWrapped = pkgs.writeShellScript "fzf-wrapper" ''
          FZF_DEFAULT_OPTS="${"$"}{FZF_DEFAULT_OPTS:-} ${fzfDefaultOptionsPiped} ${fzfColorsStr}" \
            ${pkgs.fzf}/bin/fzf "$@"
        '';

        fdFlags = "--hidden --color=always " + excludesStr;

        fdWrapped = pkgs.writeShellScript "fd-wrapper" ''
          fd "$@" ${fdFlags}
        '';

        ezaWrapped = pkgs.writeShellScript "eza-wrapper" ''
          eza --color=always --follow-symlinks --short-nix "$@"
        '';

        fdCommand = "${fdWrapped} --type f";

        zoxideDirWrapped = pkgs.writeShellScript "zoxide-dir-wrapper" ''
          zoxide query -l | while read -r dir; do
            printf '%s\t%s\n' "$(sed "s|^$HOME|~|" <<< "$dir")" "$dir"
          done
        '';

        zoxideDirWidget = ''
          set -l fzf_query (commandline -b)
          set -l dir (${zoxideDirWrapped} | ${fzfWrapped} \
            --query "$fzf_query" \
            --delimiter '\t' --with-nth=1 --accept-nth=2 \
            --preview '${ezaWrapped} --tree {2}')
          if test -n "$dir"
            cd "$dir"
          end
        '';

      in
      {
        stylix.targets.fzf.enable = false;
        programs = {
          fzf = {
            inherit (fzf) defaultOptions colors;
            enable = true;
            defaultCommand = fdCommand;
            fileWidget = {
              command = fdCommand;
              options = [
                "--preview '${customPreviewScript} {}'"
              ];
            };
            changeDirWidget = {
              command = "${fdWrapped} --type d";
              options = [
                "--preview '${ezaWrapped} --tree {1}'"
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

          fish.binds = {
            "ctrl-o" = {
              command = "fg 2>/dev/null || ${fzfWrapped} | xargs -r nvim";
              repaint = true;
              silent = true;
            };

            "alt-z" = {
              command = [
                zoxideDirWidget
              ];
              repaint = true;
              silent = true;
            };
          };
        };

        home = {
          packages = builtins.attrValues {
            inherit (pkgs) file;
          };
          shellAliases.fzf = "${fzfWrapped}";
        };

      };
  };
}

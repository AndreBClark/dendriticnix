{ den, ... }:
{
  den.aspects.cli.fzf = {
    includes = [
      (den.batteries.shell-integrations [
        "fzf"
      ])
    ]
    ++ builtins.attrValues {
      inherit (den.aspects.cli)
        bat
        fd
        eza
        zoxide
        ;
    };

    homeManager =
      {
        lib,
        pkgs,
        config,
        ...
      }:
      let
        colors = config.lib.stylix.colors.withHashtag;

        excludesList = config.programs.fd.ignores;

        excludesCSV = lib.concatStringsSep "," excludesList;
        previewWindow = "--preview-window='right,border-rounded,wrap,60%,<60(down,50%)'";

        fdArgs = lib.optional config.programs.fd.hidden "--hidden" ++ config.programs.fd.extraOptions;

        fdWrapped = pkgs.writeShellScript "fd-wrapper" ''
          fd "$@" ${lib.escapeShellArgs fdArgs}
        '';

        ezaArgs =
          lib.optionals (config.programs.eza.icons != null) [
            "--icons"
            config.programs.eza.icons
          ]
          ++ lib.optionals (config.programs.eza.colors != null) [
            "--color"
            config.programs.eza.colors
          ]
          ++ lib.optional config.programs.eza.git "--git"
          ++ config.programs.eza.extraOptions;

        ezaWrapped = pkgs.writeShellScript "eza-wrapper" ''
          eza ${lib.escapeShellArgs ezaArgs} "$@"
        '';

        customPreviewScript = pkgs.writeShellScript "kitty-preview" ''
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
            bat "$file"
          fi
        '';

        fileWidgetOptions = lib.concatStringsSep " " config.programs.fzf.fileWidget.options;

        fzfColorsStr =
          "--color="
          + lib.concatStringsSep "," (
            lib.mapAttrsToList (name: value: "${name}:${value}") config.programs.fzf.colors
          );

        fzfDefaultOptionsPiped = lib.concatStringsSep " " config.programs.fzf.defaultOptions;

        fzfWrapped = pkgs.writeShellScript "fzf-wrapper" ''
          FZF_DEFAULT_OPTS="${"$"}{FZF_DEFAULT_OPTS:-} ${fzfDefaultOptionsPiped} ${fzfColorsStr}" \
            ${pkgs.fzf}/bin/fzf "$@"
        '';

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
            enable = true;
            defaultCommand = "${fdWrapped} --type f";
            defaultOptions = [
              "--height=-1"
              "--min-height=20+"
              "--bind=ctrl-z:ignore"
              "--reverse"
              "--walker=file,dir,follow"
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

            fileWidget = {
              command = "${fdWrapped} --type f";
              options = [
                "--scheme=path"
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

          fish.binds = {
            "ctrl-o" = {
              command = "fg 2>/dev/null || ${fzfWrapped} ${fileWidgetOptions} | xargs -r nvim";
              repaint = true;
              silent = true;
            };

            "alt-z" = {
              command = zoxideDirWidget;
              repaint = true;
              silent = true;
            };

            "alt-n" = {
              command = ''
                manix "" | rg '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' \
                  | ${fzfWrapped} --preview="manix '{}' | bat --language=md --plain" \
                  | xargs manix
              '';
              repaint = true;
              silent = true;
            };
          };
        };

        manual.json.enable = true;
        home = {
          packages = builtins.attrValues {
            inherit (pkgs) file manix ripgrep;
          };
        };
      };
  };
}

{ den, lib, ... }:

let
  starship = {
    enable = true;
    settings =
      let
        separator = {
          left = "";
          right = "";
        };
      in
      {
        add_newline = false;
        format = lib.concatStrings [
          "$os"
          "[${separator.right}](fg:prev_bg bg:blue)"
          "[${separator.right}](fg:prev_bg bg:purple)"
          "[${separator.right}](fg:prev_bg bg:cyan)"
          "$directory"
          "[${separator.right}](fg:prev_bg bg:base02)"
          "$git_branch"
          "$git_status"
          "$status"
        ];

        right_format = lib.concatStrings [
          "$nix_shell"
          "$php"
          "$nodejs"
          "$deno"
          "$rust"
          "$sudo"
          "$shell"
          "$git_commit"
          "$git_metrics"
        ];

        os = {
          disabled = false;
          style = "bg:base01 fg:cyan bold";
          symbols.NixOS = " ";
          format = lib.concatStrings [
            "[${separator.left}](fg:base01 bg:none)"
            "[ $symbol ]($style)"
            "[${separator.right}](fg:prev_bg bg:prev_fg)"
          ];
        };

        directory =
          let
            style = "bold black bg:cyan";
          in
          {
            inherit style;
            repo_root_style = style;
            format = lib.concatStrings [
              "[ $path]($style)"
            ];
            fish_style_pwd_dir_length = 0;
            truncation_length = 0;
            before_repo_root_style = "bg:blue black dimmed";
            repo_root_format = lib.concatStrings [
              "[  $repo_root]($repo_root_style)"
              "[$path]($style)"
            ];
            substitutions = [
              {
                from = "^~/repos";
                to = " repos";
                regex = true;
              }
              {
                from = "^~/Downloads";
                to = "󰉍 Downloads";
                regex = true;
              }
              {
                from = "^~/Pictures";
                to = "󰉏 Pictures";
                regex = true;
              }
              {
                from = "^~/Documents";
                to = "󰲂 Docs";
                regex = true;
              }
              {
                from = "^~/vaults";
                to = " vaults";
                regex = true;
              }
              {
                from = "^~/?";
                to = "󱂵 ";
                regex = true;
              }
              {
                from = "^([^󱂵󰉍󰉏󰲂])";
                to = " $1";
                regex = true;
              }
            ];
          };

        git_branch = {
          style = "bg:base02 fg:blue";
          format = lib.concatStrings [
            "[ $symbol$branch]($style)"
          ];
        };

        git_status = {
          style = "bg:base02 fg:blue";
          format = lib.concatStrings [
            "[$all_status$ahead_behind ]($style)"
          ];
        };

        status = {
          disabled = false;
          format = lib.concatStrings [
            "[${separator.right}]($style fg:prev_bg)"
            "[$symbol$common_meaning$signal_name$maybe_int]($style)"
            "[${separator.right} ](bg:none fg:prev_bg)"
          ];
          success_symbol = "    ";
          symbol = " ";
          failure_style = "bg:red bold black";
          success_style = "bg:green bold black";
        };

        # right side
        git_commit.disabled = false;

        shell = {
          format = "[$indicator]($style)";
          fish_indicator = "";
          disabled = false;
        };

        nix_shell = {
          disabled = false;
          style = "bg:blue fg:bright-black bold";
          symbol = " ";
          format = lib.concatStrings [
            "[ ]()"
            "[${separator.left}](fg:bright-black)"
            "[$symbol](fg:blue bg:bright-black)"
            "[${separator.right}](fg:bright-black bg:blue)"
            "[ $name]($style)"
            "[${separator.right}](fg:blue)"
          ];
        };

        python = {
          symbol = " ";
          format = "[$symbol $version]($style)";
        };

        nodejs = {
          symbol = "󰎙 ";
          style = "bg:green bold fg:bright-black";
          detect_files = [
            "package.json"
            ".node-version"
            ".nvmrc"
          ];
          format = lib.concatStrings [
            "[ ]()"
            "[${separator.left}](bg:none fg:bright-black)"
            "[$symbol](bg:prev_fg fg:green)"
            "[${separator.right}](bg:green fg:bright-black)"
            "[ $version]($style)"
            "[${separator.right}](bg:none fg:green)"
          ];
        };

        deno = {
          symbol = " ";
          style = "bg:green bold fg:bright-black";
          format = lib.concatStrings [
            "[ ]()"
            "[${separator.left}](bg:none fg:bright-black)"
            "[$symbol](bg:prev_fg fg:green)"
            "[${separator.right}](bg:green fg:bright-black)"
            "[ $version]($style)"
            "[${separator.right}](bg:none fg:green)"
          ];
        };

        git_metrics = {
          disabled = false;
          added_style = "bg:green bold bright-black";
          deleted_style = "bg:red bold bright-black";
          format = lib.concatStrings [
            "("
            "[ ]()"
            "[${separator.left}](fg:green)"
            "[+$added]($added_style)"
            "[${separator.right}](fg:prev_bg)"
            ")("
            "[ ${separator.left}](fg:red)"
            "[-$deleted]($deleted_style)"
            "[${separator.right}](fg:prev_bg)"
            ")"
          ];
        };
        character =
          let
            symbol = ">";
          in
          {
            error_symbol = "[${symbol}](bold red)";
            success_symbol = "[${symbol}](bold green)";
          };

      };
  };
in
{
  den.aspects.shell.starship = {
    includes = [
      (den.batteries.shell-integrations [ "starship" ])
      den.aspects.shell.starship.palette_tester
    ];

    nixos.programs.starship = starship // {
      transientPrompt = {
        enable = true;
        left = "starship module character $argv";
      };
    };
    homeManager.programs.starship = starship // {
      enableTransience = true;
    };
  };
}

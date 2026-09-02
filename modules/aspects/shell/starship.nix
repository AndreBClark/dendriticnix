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
          "$directory"
          "$git_branch"
          "$git_status"
          "$status"
        ];

        right_format = lib.concatStrings [
          "$cmd_duration"
          "$nix_shell"
          "$php"
          "$nodejs"
          "$rust"
          "$sudo"
          "$shell"
          "$git_commit"
          "$git_metrics"
        ];

        os = {
          disabled = false;
          style = "bg:base02 fg:cyan bold";
          symbols.NixOS = " ";
          format = lib.concatStrings [
            "[${separator.left}](fg:base02 bg:none)"
            "[$symbol]($style)"
            "[${separator.right}](fg:prev_bg bg:purple)"
            "[${separator.right}](fg:prev_bg bg:blue)"
            "[${separator.right}](fg:blue bg:cyan)"
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

              "[ $path ]($style)"
            ];
            before_repo_root_style = "bg:blue black dimmed";
            repo_root_format = lib.concatStrings [
              "[  $repo_root ]($repo_root_style)"
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
            "[${separator.right}](fg:prev_bg bg:base02)"
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

        character = {
          disabled = false;
          format = lib.concatStrings [
            "$symbol"
            "[ ](bg:none fg:none)"
          ];
          success_symbol = lib.concatStrings [
            "[${separator.left}](fg:green bg:none)"
            "[ ](bg:green fg:black bold)"
            "[${separator.right}](bg:none fg:green)"
          ];
          error_symbol = lib.concatStrings [
            "[${separator.left}](fg:red bg:none)"
            "[ ](bg:red fg:black bold)"
            "[${separator.right}](bg:none fg:red)"
          ];
        };

        # right side
        git_commit.disabled = false;

        shell = {
          fish_indicator = "";
          disabled = false;
        };

        nix_shell = {
          disabled = false;
          style = "bg:blue fg:black bold";
          symbol = " ";
          format = lib.concatStrings [
            "[${separator.left}](fg:blue)"
            "[ $symbol$name ]($style)"
            "[${separator.right}](fg:blue)"
          ];
        };

        python = {
          symbol = " ";
          format = "[$symbol $version]($style)";
        };

        nodejs.format = "[$symbol$version]($style)";

        git_metrics = {
          disabled = false;
          added_style = "bg:green bold black";
          deleted_style = "bg:red bold black";
          format = lib.concatStrings [
            "("
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

        cmd_duration.disabled = true;

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

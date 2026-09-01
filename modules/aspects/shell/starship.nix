{ den, lib, ... }:

let
  separator = {
    left = "";
    right = "";
  };

  starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$os"
        "$directory"
        "$git_branch"
        "$git_status"
        "$status"
        "$character"
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
        style = "bg:prev_fg fg:base15";
        symbols.NixOS = " ";
        format = lib.concatStrings [
          "[${separator.left}](fg:base01 bg:none)"
          "[$symbol]($style)"
          "[${separator.right}](fg:prev_bg bg:prev_fg)"
        ];
      };

      directory = {
        style = "bold base02 bg:prev_bg";
        format = lib.concatStrings [
          "[ $path]($style)"
          "[${separator.right}](fg:prev_bg bg:prev_fg)"
        ];
        substitutions = {
          "GitHub" = " ";
          "repos" = " ";
          "Downloads" = " ";
          "Pictures" = " ";
          "Documents" = "󰈙 ";
          "Music" = " ";
        };
      };

      git_branch = {
        style = "bold base08 bg:prev_bg";
        format = lib.concatStrings [
          "[ $symbol$branch]($style)"
        ];
      };

      git_status = {
        style = "fg:prev_fg bg:prev_bg";
        format = lib.concatStrings [
          "[$all_status$ahead_behind]($style)"
        ];
      };

      status = {
        disabled = false;
        format = lib.concatStrings [
          "[${separator.right}]($style fg:prev_bg)"
          "[ $common_meaning$signal_name$maybe_int](bold $style)"
        ];
        failure_style = "black bg:base0f";
        success_style = "black bg:green";
      };

      character = {
        disabled = false;
        format = lib.concatStrings [
          "$symbol"
          "[${separator.right} ](fg:prev_bg bg:none)"
        ];
        success_symbol = lib.concatStrings [
          "[${separator.right}  ](fg:prev_bg bg:green)"
        ];
        error_symbol = lib.concatStrings [
          "[](fg:prev_bg bg:base0f)"
        ];
      };

      # right side
      git_commit.disabled = false;

      git_metrics = {
        disabled = false;
        format = " ([+$added]($added_style) )([-$deleted]($deleted_style) )";
      };

      shell = {
        fish_indicator = "";
        disabled = false;
      };

      nix_shell = {
        disabled = false;
        symbol = " ";
        format = "[ $symbol$name ](bold $style)";
      };

      python = {
        symbol = "";
        style = "bold yellow";
        format = "[$symbol $version]($style)";
      };

      nodejs.format = "[$symbol$version]($style)";

      cmd_duration.disabled = true;

    };
  };
in
{
  den.aspects.shell.starship = {
    includes = [
      (den.batteries.shell-integrations [ "starship" ])
    ];

    nixos.programs.starship = starship;
    homeManager.programs.starship = starship;
  };
}

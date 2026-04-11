{ lib, ... }:

let
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
        # "$status"
        "$direnv"
        "$nix_shell"
        "$php"
        #         "$python"
        "$nodejs"
        "$rust"
        "$sudo"
        "$shell"
        "$git_commit"
        "$git_metrics"
      ];

      os = {
        disabled = false;
        style = "bg:base10 fg:base15";
        format = lib.concatStrings [
          "[ $symbol]($style)"
          "[ ](fg:base10 bg:base15)"
        ];
      };

      directory = {
        style = "bold base10 bg:prev_bg";
        format = lib.concatStrings [
          "[$path ]($style)"
          "[ ](fg:prev_bg bg:base00)"
        ];
        repo_root_style = "bold base10 bg:prev_bg";
        repo_root_format = lib.concatStrings [
          "[ $repo_root]($repo_root_style)[$path]($style)"
          "[ ](fg:prev_bg bg:base00)"
        ];
        substitutions = {
          "GitHub" = " ";
          "repos" = " ";
          "Downloads" = " ";
          "Pictures" = " ";
        };
      };
      git_branch = {
        style = "bg:prev_bg";
        format = lib.concatStrings [
          "[$symbol$branch ]($style)"
        ];
      };
      git_status = {
        style = "bg:prev_bg";
        format = lib.concatStrings [
          "[$all_status$ahead_behind]($style)"
        ];
      };
      character = {
        disabled = false;
        format = lib.concatStrings [
          "$symbol"
          "[ ](fg:prev_bg bg:none)"
        ];
        success_symbol = lib.concatStrings [
          "[            ](fg:prev_bg bg:green)"
        ];
        error_symbol = lib.concatStrings [
          "[](fg:prev_bg bg:red)"
        ];
      };
      status = {
        disabled = false;
        format = lib.concatStrings [
          "[]($style fg:prev_bg)"
          "[  $common_meaning $signal_name]($style)"
        ];
        failure_style = "prev_fg bg:red";
        success_style = "prev_fg bg:green";
      };

      #     right side
      git_commit.disabled = false;
      git_metrics.disabled = false;
      shell = {
        format = " with $indicator ";
        fish_indicator = "󰈺 fsh";
        disabled = false;
      };
      nix_shell = {
        disabled = false;
        format = "[$symbol(\($name\))]($style) ";
      };
      python = {
        symbol = "";
        style = "bold yellow";
        format = "[$symbol $version]($style)";
      };
      nodejs.format = "[$symbol$version]($style)";
      cmd_duration = {
        format = "took $duration ";
        disabled = false;
        min_time_to_notify = 45000;
      };
    };
  };
in
{
  den.aspects.prompts.starship = {
    nixos.programs.starship = starship;
    homeManager.programs.starship = starship;
  };
}

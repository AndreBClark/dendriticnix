{ lib, ... }:
{
  den.aspects.shell.starship.palette_tester = {
    homeManager = {
      programs.starship.settings = {
        custom.palette_test = {
          when = true;
          format = lib.concatStrings [
            "\n"
            # First row: index with white text
            (lib.concatStrings (
              map (
                i:
                "[ ${lib.toUpper (lib.fixedWidthString 2 "0" (lib.toHexString i))} ](fg:white bg:base${
                  lib.fixedWidthString 2 "0" (lib.toHexString i)
                })"
              ) (lib.range 0 23)
            ))
            "\n"
            # Second row: variable name with black text
            (lib.concatStrings (
              map (
                i:
                "[ ${lib.fixedWidthString 2 "0" (lib.toHexString i)} ](fg:black bg:base${
                  lib.fixedWidthString 2 "0" (lib.toHexString i)
                })"
              ) (lib.range 0 23)
            ))
            "\n"
            # Named colors with 3 repetitions each
            (lib.concatStringsSep "\n" (
              map
                (
                  color:
                  let
                    padded = lib.fixedWidthString 14 " " color;
                  in
                  "[ ${padded} ](fg:white bg:${color})[ ${padded} ](fg:black bg:${color})"
                )
                [
                  "black"
                  "blue"
                  "brown"
                  "cyan"
                  "green"
                  "magenta"
                  "orange"
                  "purple"
                  "red"
                  "white"
                  "yellow"
                  "bright-black"
                  "bright-blue"
                  "bright-cyan"
                  "bright-green"
                  "bright-magenta"
                  "bright-purple"
                  "bright-red"
                  "bright-white"
                  "bright-yellow"
                ]
            ))
          ];
        };
      };
    };
  };
}

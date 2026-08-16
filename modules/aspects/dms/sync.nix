{
  den.aspects.dms = {
    homeManager =
      { pkgs, config, ... }:
      let
        nixConfigRepo =
          if config.programs.nh.flake != null then
            config.programs.nh.flake
          else
            "${config.home.homeDirectory}/nixconfig";
        dmsSync = pkgs.writeShellApplication {
          name = "dms-sync";
          runtimeInputs = [
            pkgs.jq
            pkgs.dms-shell
          ];
          text = ''
            TARGET_FILE="${nixConfigRepo}/modules/aspects/dms/settings.json"


            CLIPBOARD_DATA=$(dms cl paste)

            if ! echo "$CLIPBOARD_DATA" | jq empty 2>/dev/null; then
              echo "Error: Clipboard data is not valid JSON" >&2
              exit 1
            fi

            if ! echo "$CLIPBOARD_DATA" | jq -e 'has("configVersion") and has("currentThemeName")' >/dev/null 2>&1; then
              echo "Error: Clipboard data does not appear to be DMS settings (missing required keys)" >&2
              exit 1
            fi

            if echo "$CLIPBOARD_DATA" > "$TARGET_FILE"; then
              echo "Successfully replaced settings.json with validated clipboard data"

              cd "${nixConfigRepo}" || {
                echo "Warning: Failed to change to repository directory" >&2
                exit 1
              }

              if git add "$TARGET_FILE"; then
                echo "File staged in git"
              else
                echo "Warning: Failed to stage file in git" >&2
              fi
            else
              echo "Failed to write to file" >&2
              exit 1
            fi
          '';
        };
      in
      {
        home.packages = [
          dmsSync
        ];
      };
  };
}

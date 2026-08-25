{
  den.aspects.dms.syncCmd = {
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
            pkgs.coreutils
          ];
          text = ''
            TARGET_DIR="${nixConfigRepo}/modules/aspects/dms"
            DMS="${pkgs.dms-shell}/bin/dms"

            sync_from_clipboard() {
              local name="$1" required_expr="$2"
              local target_file="$TARGET_DIR/$name.json"

              HISTORY=$("$DMS" cl history --json 2>/dev/null)
              IDS=$(echo "$HISTORY" | jq -r '.[].id' | head -n 20)

              for id in $IDS; do
                ENTRY_JSON=$("$DMS" cl get "$id" --json 2>/dev/null)
                DATA_B64=$(echo "$ENTRY_JSON" | jq -r '.data // empty')
                [ -z "$DATA_B64" ] && continue

                DECODED=$(echo "$DATA_B64" | base64 -d 2>/dev/null) || continue

                echo "$DECODED" | jq empty 2>/dev/null || continue

                if [ -n "$required_expr" ] && ! echo "$DECODED" | jq -e "$required_expr" >/dev/null 2>&1; then
                  continue
                fi

                echo "$DECODED" > "$target_file"
                echo "Successfully replaced $name.json using clipboard entry $id"
                git add "$target_file"
                return 0
              done

              echo "No $name.json entry found in clipboard history, skipping" >&2
              return 1
            }

            cd "${nixConfigRepo}" || { echo "Failed to cd to repo" >&2; exit 1; }

            sync_from_clipboard "settings"        'has("configVersion") and has("currentThemeName")'
            sync_from_clipboard "session"         'has("configVersion") and has("pinnedApps")'
            sync_from_clipboard "plugin_settings" 'has("airQuality") or has("dmsThemeSync")'

            echo "Files staged in git"
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

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
          runtimeInputs = [ pkgs.jq ];
          text = ''
            DMS_CONFIG="${config.home.homeDirectory}/.config/DankMaterialShell"
            DMS_STATE="${config.home.homeDirectory}/.local/state/DankMaterialShell"
            TARGET_DIR="${nixConfigRepo}/modules/aspects/dms"

            sync_file() {
              local src="$1" dest="$2" required_key="$3"
              if [ ! -f "$src" ]; then
                echo "Warning: $src not found, skipping" >&2
                return
              fi
              if ! jq empty "$src" 2>/dev/null; then
                echo "Error: $src is not valid JSON" >&2
                return 1
              fi
              if [ -n "$required_key" ] && ! jq -e "has(\"$required_key\")" "$src" >/dev/null 2>&1; then
                echo "Error: $src missing expected key $required_key" >&2
                return 1
              fi
              cp "$src" "$dest"
              echo "Synced $(basename "$dest")"
            }

            sync_file "$DMS_CONFIG/settings.json"        "$TARGET_DIR/settings.json"        "configVersion"
            sync_file "$DMS_STATE/session.json"          "$TARGET_DIR/session.json"         "configVersion"
            sync_file "$DMS_CONFIG/plugin_settings.json" "$TARGET_DIR/plugin_settings.json" ""

            cd "${nixConfigRepo}" || exit 1
            git add "$TARGET_DIR/settings.json" "$TARGET_DIR/session.json" 2>/dev/null || true
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

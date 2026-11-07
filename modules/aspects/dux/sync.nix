{
  den.aspects.dux.syncCmd = {
    homeManager =
      { pkgs, config, ... }:
      let
        nixConfigRepo =
          if config.programs.nh.flake != null then
            config.programs.nh.flake
          else
            "${config.home.homeDirectory}/nixconfig";
        duxSync = pkgs.writeShellApplication {
          name = "dux-sync";
          runtimeInputs = [
            pkgs.jq
            pkgs.coreutils
          ];
          text = ''
            TARGET_DIR="${nixConfigRepo}/modules/aspects/dux"

            dms ipc call settings dump > "$TARGET_DIR/settings.json"

            dms ipc call settings dumpSession \
              | jq 'del(.activeDisplayProfile, .activeDisplayProfileModes,
                        .launcherLastQuery, .launcherQueryHistory)' \
              > "$TARGET_DIR/session.json"

            cd "${nixConfigRepo}" || exit 1
            git add "$TARGET_DIR/settings.json" "$TARGET_DIR/session.json"
          '';
        };
      in
      {
        home.packages = [
          duxSync
        ];
      };
  };
}

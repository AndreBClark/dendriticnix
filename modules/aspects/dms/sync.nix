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

            dms ipc call settings dump > $TARGET_DIR/settings.json
            dms ipc call settings dumpSession > $TARGET_DIR/session.json

            cd "${nixConfigRepo}" || { echo "Failed to cd to repo" >&2; exit 1; }
            git add $TARGET_DIR/settings.json
            git add $TARGET_DIR/session.json

            echo "settings.json and session.json updated in repo"
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

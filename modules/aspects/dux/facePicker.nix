{
  den.aspects.dux.facePicker = {
    homeManager =
      { pkgs, config, ... }:
      let
        faceFile = "${config.home.homeDirectory}/.face";
        duxPickFace = pkgs.writeShellApplication {
          name = "dux-face-picker";
          runtimeInputs = [
            pkgs.dms-shell
            pkgs.imagemagick
          ];
          text = ''
            dms ipc call file browse profile
            sleep 1
            PICKED=$(dms ipc call profile getImage)
            if [ -z "$PICKED" ] || [ "$PICKED" = "" ]; then
              echo "No image selected" >&2
              exit 1
            fi
            magick convert "$PICKED" "${faceFile}"
            dms ipc call profile setImage "${faceFile}"
            echo "Saved profile image to ${faceFile}"
          '';
        };
      in
      {
        home.packages = [ duxPickFace ];

        systemd.user.services.dms.Service.ExecStartPost =

          "-"
          + toString (
            pkgs.writeShellScript "dux-set-profile-image" ''
              FACE="${faceFile}"
              [ -f "$FACE" ] || exit 0

              for i in $(seq 1 20); do
                RESULT=$(${pkgs.dms-shell}/bin/dms ipc call profile setImage "$FACE" 2>/dev/null || true)
                if echo "$RESULT" | grep -q "^SUCCESS"; then
                  # Re-apply once more after a short delay in case accountsServiceAvailable
                  # flips true right after this call succeeded against the in-memory-only path
                  sleep 2
                  ${pkgs.dms-shell}/bin/dms ipc call profile setImage "$FACE" 2>/dev/null || true
                  exit 0
                fi
                sleep 2
              done
            ''
          );
      };
  };
}

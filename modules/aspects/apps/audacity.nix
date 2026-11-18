{
  den.aspects.apps.audacity = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [
          (pkgs.symlinkJoin {
            name = "audacity-jack";
            paths = [ pkgs.audacity_3 ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/audacity \
                --prefix LD_LIBRARY_PATH : ${pkgs.pipewire.jack}/lib
            '';
          })
        ];
      };
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          (pkgs.symlinkJoin {
            name = "audacity-jack";
            paths = [ pkgs.audacity_3 ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/audacity \
                --prefix LD_LIBRARY_PATH : ${pkgs.pipewire.jack}/lib
            '';
          })
        ];
      };
  };
}

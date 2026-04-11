{
  xdg.configFile."niri/binds.kdl".text = /* kdl */ ''
    binds {
       Mod+T hotkey-overlay-title="Open Terminal" { spawn-sh "$TERMINAL"; }
    }
  '';
}

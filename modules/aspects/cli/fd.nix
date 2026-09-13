{
  den.aspects.cli.fd = {
    homeManager = {
      programs.fd = {
        enable = true;
        hidden = false;
        extraOptions = [
          "--color=always"
        ];
        ignores = [
          "Music/*"
          ".git"
          ".direnv"
          ".cache"
          ".pki"
          ".dotnet"
          "pfx"
          "dosdevices"
          "*.lock"
          # Dependencies and build outputs
          "dist"
          "node_modules"
          "target"
          "build"
          "dist"
          "out"
          "result"
          # IDE and editor files
          ".vscode"
          ".idea"
          "*.swp"
          "*.swo"
          "*~"
          # OS-specific
          ".DS_Store"
          "Thumbs.db"
          # Cache and temporary
          "tmp"
          "temp"
          "*.tmp"
        ];
      };
    };
  };
}

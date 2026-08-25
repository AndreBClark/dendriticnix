- [x] [snacks].nvim and [mini].[nvim] nix files
- [ ] Picture in Picture overlay shell layer [niri] [dms]
    - [ ] set icon for pip
- [x] fix `mod+T` not opening terminal [dms] [niri]
- [x] passthrough home config for standalone home-manager config `nh home switch`
- [x] add keybind for wallpaper wallpaperCarousel
- [x] add keybind for FG


### Neovim
- [x] fix bufferline inconsistent background
- [ ] style bufferline [nvim] [bufferline]
    - [ ] find fun bufferline styles
    - [ ] find alternatives?

### Design
- [ ] wallpaper colorscheme theme key
    - [ ] convert wallpaper directory as symbolic link to Wallpaper-${wallpaper-theme} folder
    - [ ] rename wallpaper directory as wallpaper-raw
    - [ ] set dms wallpaper to `Wallpaper-${wallpaper-theme}`
    - [ ] create dms plugin for this
- [x] declarative-ish set user icon
    - [x] grab first image in dir
    - [x] symbolic link image to .face
    - [x] use .face as user icon
    - [x] run script to sync those 2


### Blocked by upstream

- ~sync user icon with greeter~
- ~Picture in Picture [niri] [dms]~
    - ~pin above all~
    - ~overlay shell layer~
    - ~set icon for pip~
- [ ] more gitsigns keymaps
- [ ] disable more of noice and just keep nui/cmdline
    - [ ] find if theres more locations
- [ ] nixvim standalone package

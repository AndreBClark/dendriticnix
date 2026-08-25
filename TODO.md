- [x] fix `mod+T` not opening terminal [dms] [niri]
- [x] passthrough home config for standalone home-manager config `nh home switch`
- [x] add keybind for wallpaper wallpaperCarousel
- [x] add keybind for FG


### Neovim
- [x] style bufferline [nvim] [bufferline]
    - [x] find fun bufferline styles
    - [x] find alternatives?
- [x] fix bufferline inconsistent background
- [x] [snacks].nvim and [mini].[nvim] nix files
- [x] more gitsigns keymaps
    - [ ] have deepwiki teach me the keymaps
- [ ] nixvim standalone package
- [x] disable more of noice and just keep nui/cmdline
    - [x] find if theres more locations

### Design
- [ ] figure out why fonts on my terminal are not bold
- [x] less distracting background, more blur
- [ ] convert niri config back to kdl for portability and use a toKdl readfile on settings
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

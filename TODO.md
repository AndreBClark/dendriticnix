### [ ] declarative Vivaldi config
  - [ ] theme
  - [ ] search
  - [ ] tab layout
  - [ ] workspaces
  - [ ] start page
### [ ] grub
  - [ ] encode logo for grub
  - [ ] copy output theme to new theme to replace stylix script
  - [ ] ensure caching reusability of different theme
  - [ ] reduce build time for vm-grub vm
### [ ] Audacity 3
  - [ ] save macro txt
  - [ ] other settings

- [ ] global whichkey?
    - [ ] as a dank OSD?
    - [ ] [wlr-which-key nixos options](https://search.nixos.org/options?channel=unstable&query=wlr-which-key&source=home_manager&type=options)
    - [ ] [wlr-which-key](https://github.com/MaxVerevkin/wlr-which-key)
- [x] fix `mod+T` not opening terminal [dms] [niri]
- [x] passthrough home config for standalone home-manager config `nh home switch`
- [x] add keybind for wallpaper wallpaperCarousel
- [x] add keybind for FG


### Neovim
- [x] use more contrasting palette order for tab_bar
- [x] interactive breadcrumbs
- [x] style bufferline [nvim] [bufferline]
    - [x] find fun bufferline styles
    - [x] find alternatives?
- [x] fix bufferline inconsistent background
- [x] [snacks].nvim and [mini].[nvim] nix files
- [x] more gitsigns keymaps
    - [x] have deepwiki teach me the keymaps
- [x] disable more of noice and just keep nui/cmdline
    - [x] find if theres more locations
- [x] audit keymaps
    - [x] make sure they fit which key groups
    - [x] remove redundant, overlapping, not useful keymaps

### Design
- [x] figure out why fonts on my terminal are not bold
- [x] reduce the amount of jetbrains variants installed
- [x] less distracting background, more blur
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
- [x] no tofu on spotify
    - [x] custom font: monospace or noto?
- [x] grub OS LOGO

### Yak Shaving

- [x] convert niri config back to kdl for portability and use a toKdl readfile on settings
- [x] nixvim standalone package

### Blocked by upstream

- ~sync user icon with greeter~
- ~Picture in Picture [niri] [dms]~
  - ~pin above all~
  - ~overlay shell layer~
  - ~set icon for pip~

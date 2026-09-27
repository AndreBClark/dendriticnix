complete -c wallpaper-batch -f
complete -c wallpaper-batch -n "__fish_use_subcommand" -a "(gowall list)" -d "Theme name"
complete -c gowall -f -n "__fish_seen_subcommand_from -sb --smart-batch" -a "(gowall list)" -d "Theme name"

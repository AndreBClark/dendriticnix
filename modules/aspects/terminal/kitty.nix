{
  den.aspects.terminal.kitty = {
    homeManager = {
      programs.kitty = {
        enable = true;
        settings = {
          tab_title_template = "[{index}] {tab.active_wd}{activity_symbol}";
          tab_title_max_length = 0;
          tab_bar_edge = "top";
          tab_bar_style = "powerline";
          tab_powerline_style = "round";
        };
      };
    };

  };
}

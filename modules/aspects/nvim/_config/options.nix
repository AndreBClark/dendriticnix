{ lib, ... }:
{
  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    tabstop = 2;
    laststatus = 3;
    completeopt = "menu,menuone,noselect";
    conceallevel = 2; # Hide * markup for bold and italic, but not markers with substitutions
    confirm = true; # Confirm to save changes before exiting modified buffer
    cursorline = true; # Enable highlighting of the current line
    expandtab = true; # Use spaces instead of tabs
    formatoptions = "jcroqlnt"; # tcqj
    grepformat = "%f:%l:%c:%m";
    ignorecase = true; # Ignore case
    inccommand = "nosplit"; # preview incremental substitute
    list = true; # Show some invisible characters (tabs...
    mouse = "a"; # Enable mouse mode
    pumblend = 10; # Popup blend
    pumheight = 10; # Maximum number of entries in a popup
    scrolloff = 4; # Lines of context
    sessionoptions = [
      "buffers"
      "curdir"
      "tabpages"
      "winsize"
      "help"
      "globals"
      "skiprtp"
      "folds"
    ];
    shiftround = true; # Round indent
    showmode = false; # Dont show mode since we have a statusline
    sidescrolloff = 8; # Columns of context
    signcolumn = "yes"; # Always show the signcolumn, otherwise it would shift the text each time
    smartcase = true; # Don't ignore case with capitals
    smartindent = true; # Insert indents automatically
    splitbelow = true; # Put new windows below current
    splitkeep = "screen";
    splitright = true; # Put new windows right of current
    termguicolors = true; # True color support
    spelllang = lib.mkDefault [ "en_us" ]; # Spell check languages
    showmatch = true;
    infercase = true;
    clipboard = "unnamedplus";
    foldlevel = 99; # Folds with a level higher than this number will be closed
    foldcolumn = "0";
    foldenable = true;
    foldlevelstart = 99;
    fillchars = {
      horiz = "━";
      horizup = "┻";
      horizdown = "┳";
      vert = "┃";
      vertleft = "┫";
      vertright = "┣";
      verthoriz = "╋";
      eob = " ";
      diff = "╱";
      fold = " ";
      foldopen = "";
      foldclose = "";
      msgsep = "‾";
    };
  };
}

{ lib, ... }:
{
  opts = {
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    tabstop = 2;
    laststatus = 3;
    completeopt = "menu,menuone,noselect";
    conceallevel = 2;
    confirm = true;
    cursorline = true;
    expandtab = true;
    formatoptions = "jcroqlnt";
    grepformat = "%f:%l:%c:%m";
    ignorecase = true;
    inccommand = "nosplit";
    list = true;
    mouse = "a";
    pumblend = 10;
    pumheight = 10;
    scrolloff = 4;
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
    shiftround = true;
    showmode = false;
    sidescrolloff = 8;
    signcolumn = "yes";
    smartcase = true;
    smartindent = true;
    splitbelow = true;
    splitkeep = "screen";
    splitright = true;
    termguicolors = true;
    spelllang = lib.mkDefault [ "en_us" ];
    showmatch = true;
    infercase = true;
    clipboard = "unnamedplus";
    foldlevel = 99;
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

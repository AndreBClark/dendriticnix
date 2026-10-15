{ lib, ... }:
{
  opts = {
    # ── UI ──
    number = true;
    relativenumber = true;
    cursorline = true;
    signcolumn = "no";
    laststatus = 3;
    showmode = false;
    termguicolors = true;
    pumheight = 10; # still used by ':' wildmenu
    conceallevel = 2; # obsidian/render-markdown
    winborder = "rounded"; # nvim 0.11+: rounded floats everywhere

    # ── Editing ──
    shiftwidth = 2;
    tabstop = 2;
    expandtab = true;
    shiftround = true;
    formatoptions = "jcroqlnt";
    infercase = true;

    # ── Search / grep ──
    ignorecase = true;
    smartcase = true;
    inccommand = "nosplit";
    grepprg = "rg --vimgrep --smart-case"; # pair with grepformat
    grepformat = "%f:%l:%c:%m";
    wildmode = "longest:full,full";

    # ── Splits / scrolling ──
    splitbelow = true;
    splitright = true;
    splitkeep = "screen";
    scrolloff = 24;
    sidescrolloff = 0;
    smoothscroll = true;
    jumpoptions = "view";

    # ── Mouse ──
    mouse = "a";
    mousescroll = "ver:3,hor:0";

    # ── Whitespace display ──
    list = true;
    listchars = {
      tab = "→ ";
      nbsp = "␣";
      extends = "❯";
      precedes = "❮";
    };

    # ── Undo / files ──
    undofile = true;
    undolevels = 10000;
    swapfile = false;
    confirm = true;

    spell = false;
    spelllang = lib.mkDefault [ "en_us" ];

    foldlevelstart = 8;
    foldcolumn = "0";

    # ── Timing ──
    updatetime = 200; # gitsigns blame, illuminate
    timeoutlen = 300; # which-key popup

    # ── Diff ──
    diffopt = "internal,filler,closeoff,indent-heuristic,linematch:60,algorithm:histogram";

    virtualedit = "block";
    showmatch = true;
    clipboard = "unnamedplus";
    textwidth = 80; # Hard-wrap column for formatting (gq)
    wrap = true; # Visually wrap long lines
    linebreak = true; # Wrap at word boundaries, not mid-word
  };
}

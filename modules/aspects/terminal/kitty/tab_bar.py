# pyright: reportMissingImports=false
from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, draw_attributed_string, apply_title_template, as_rgb
from kitty.rgb import to_color
from kitty.utils import color_as_int

# dark tab body
BG = as_rgb(color_as_int(to_color("@BODY_BG@")))
FG = as_rgb(color_as_int(to_color("@BODY_FG@")))

# bright index accents (rotates per tab)
PALETTE = [
    as_rgb(color_as_int(to_color("@TAB01@"))),
    as_rgb(color_as_int(to_color("@TAB02@"))),
    as_rgb(color_as_int(to_color("@TAB03@"))),
    as_rgb(color_as_int(to_color("@TAB04@"))),
    as_rgb(color_as_int(to_color("@TAB05@"))),
    as_rgb(color_as_int(to_color("@TAB06@"))),
    as_rgb(color_as_int(to_color("@TAB07@"))),
    as_rgb(color_as_int(to_color("@TAB08@"))),
]
INDEX_FG = as_rgb(color_as_int(to_color("@INDEX_FG@")))

PILL_LEFT = "@PILL_LEFT@"
PILL_RIGHT = "@PILL_RIGHT@"

def draw_tab(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data):
    orig_fg = screen.cursor.fg
    orig_bg = screen.cursor.bg
    index_bg = PALETTE[(index - 1) % len(PALETTE)]

    def draw_left_sep():
        screen.cursor.bg = as_rgb(color_as_int(draw_data.default_bg))
        screen.cursor.fg = index_bg
        screen.draw(PILL_LEFT)

    def draw_right_sep():
        screen.cursor.bg = orig_bg
        screen.cursor.fg = index_bg
        screen.draw(PILL_RIGHT)

    def draw_index():
        screen.cursor.bg = index_bg
        screen.cursor.fg = INDEX_FG
        screen.cursor.bold = True
        screen.draw(f" {index} ")
        return screen.cursor.x

    def draw_sep(which):
        screen.cursor.bg = as_rgb(color_as_int(draw_data.default_bg))
        screen.cursor.fg = orig_bg
        screen.draw(which)
        screen.cursor.bg = orig_bg
        screen.cursor.fg = orig_fg

    draw_left_sep()
    index_end = draw_index()
    draw_right_sep()
    screen.cursor.bg = orig_bg
    screen.cursor.fg = orig_fg
    screen.draw(" ")
    title = apply_title_template(draw_data, tab, index, max_title_length)
    draw_attributed_string(title, screen)
    extra = screen.cursor.x - index_end - max_title_length
    if extra >= 0:
        screen.cursor.x -= extra + 3
        screen.draw("+")
    elif extra == -1:
        screen.cursor.x -= 2
        screen.draw("+")
    screen.draw(" ")
    draw_sep(PILL_RIGHT)
    draw_sep(" ")
    return screen.cursor.x

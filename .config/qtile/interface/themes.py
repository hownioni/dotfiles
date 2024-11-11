import os

from libqtile.lazy import lazy

home = os.path.expanduser("~/")

colors = []

# Pywal
color_cache = home + ".cache/wal/colors"


def load_colors(cache):
    with open(cache, "r") as file:
        for i in range(16):
            colors.append(file.readline().strip())
    colors.append("#ffffff")
    lazy.reload()


load_colors(color_cache)

# Defaults
layout_theme = {
    "border_width": 2,
    "margin": 4,
    "border_focus": colors[12],
    "border_normal": colors[3],
}

widget_defaults = dict(
    font="M PLUS 1",
    fontsize=12,
    padding=2,
    background=colors[0],
)
extension_defaults = widget_defaults.copy()

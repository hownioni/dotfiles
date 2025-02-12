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

import os
import re
import subprocess

from libqtile.lazy import lazy

### GENERAL
mod = "mod4"

terminal = "kitty"
browser = "firefox"
school_browser = "firefox -P Escuela"

# rofi
launcher = "rofi -show drun -drun-exclude-categories Game"
game_launcher = "rofi -show drun -drun-categories Game"
rofimoji = "rofi -show emoji -emoji-mode menu -matching normal"
rofinerd = "rofi -show nerdy"
window_switch = "rofi -show window"

screenshot = "env QT_ENABLE_HIGHDPI_SCALING=0 flameshot gui"

home = os.path.expanduser("~/")
config = home + "/.config/qtile/"

platform = subprocess.run(
    ["hostnamectl", "chassis"], stdout=subprocess.PIPE
).stdout.decode("utf-8")[:-1]

backlight = subprocess.run(
    ["ls", "/sys/class/backlight/"], stdout=subprocess.PIPE
).stdout.decode("utf-8")[:-1]

### THEMES
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


### SCREEN
def get_dpi_from_xresources():
    try:
        # Use subprocess to run the 'xrdb -query' command and capture the output
        xrdb_output = subprocess.check_output(["xrdb", "-query"], text=True)

        # Use a regular expression to find the 'Xft.dpi' value
        match = re.search(r"Xft\.dpi:\s*(\d+)", xrdb_output)
        if match:
            return float(match.group(1))

        # Return None if 'Xft.dpi' is not found in the output
        return 96
    except Exception:
        return 96


dpi = get_dpi_from_xresources()

match dpi:
    case 192:
        bar_thickness = 60
        bar_fontsize = 20
        context_fontsize = 20
        context_width = 350
        bar_iconsize = 50
    case 168 | 144 | 120:
        bar_thickness = 40
        bar_fontsize = 16
        context_fontsize = 16
        context_width = 220
        bar_iconsize = 36
    case _:
        bar_thickness = 22
        bar_fontsize = 13
        context_fontsize = 13
        context_width = 200
        bar_iconsize = 20

bar_font = "sans"
bar_global_opacity = 1

import os
import re
import subprocess

from libqtile.config import Group, Match
from libqtile.lazy import lazy

### GENERAL
mod = "mod4"
terminal = "kitty"
browser = "firefox"
school_browser = "firefox -P Escuela"
launcher = "rofi -show drun"
window_switch = "rofi -show window"
home = os.path.expanduser("~/")
config = home + "/.config/qtile/"

platform = subprocess.run(
    ["hostnamectl", "chassis"], stdout=subprocess.PIPE
).stdout.decode("utf-8")[:-1]

backlight = subprocess.run(
    ["ls", "/sys/class/backlight/"], stdout=subprocess.PIPE
).stdout.decode("utf-8")[:-1]

### GROUPS
groups = []

group_names = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
]

group_labels = [
    "󰅩",
    "",
    "",
    "",
    "󰺵",
    "󰭹",
    "",
    "",
    "",
    "󰑴",
]

group_matches = [
    [],
    [],
    [],
    [],
    [],
    [Match(wm_class="vesktop"), Match(wm_class="zapzap"), Match(wm_class="nheko")],
    [Match(wm_class="Spotify")],
    [],
    [],
    [],
]

# group_labels = ["DEV", "WWW", "SYS", "DOC", "GAMR", "CHAT", "MUS", "VID", "GFX",]

# group_layouts = ["monadtall", "monadtall", "tile", "tile", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            # layout=group_layouts[i].lower(),
            label=group_labels[i],
            matches=group_matches[i],
        )
    )


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
    case 168:
        bar_thickness = 60
        bar_fontsize = 20
        context_fontsize = 20
        context_width = 350
    case 120:
        bar_thickness = 30
        bar_fontsize = 15
        context_width = 220
    case 96:
        bar_thickness = 22
        bar_fontsize = 13
        context_fontsize = 13
        context_width = 200

bar_font = "Noto Sans Medium"
bar_global_opacity = 1

import os
import subprocess

from libqtile.config import Group, Match
from libqtile.lazy import lazy

home = os.path.expanduser("~/")
config = home + "/.config/qtile/"

platform = subprocess.run(
    ["hostnamectl", "chassis"], stdout=subprocess.PIPE
).stdout.decode("utf-8")[:-1]
backlight = subprocess.run(
    ["ls", "/sys/class/backlight/"], stdout=subprocess.PIPE
).stdout.decode("utf-8")[:-1]

### Groups
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


###Themes

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

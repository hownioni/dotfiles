import os

from libqtile.config import Group, Match

home = os.path.expanduser("~/")
config = home + "/.config/qtile/"


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

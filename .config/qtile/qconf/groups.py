from libqtile.config import Group, Match

### GROUPS
group_info = [
    ("1", "󰅩"),
    ("2", ""),
    ("3", ""),
    ("4", ""),
    ("5", "󰺵"),
    ("6", "󰭹"),
    ("7", ""),
    ("8", ""),
    ("9", ""),
    ("0", "󰑴"),
]
# group_labels = ["DEV", "WWW", "SYS", "DOC", "GAMR", "CHAT", "MUS", "VID", "GFX",]


groups = [
    Group(name=group_info[idx][0], label=group_info[idx][1], **group)  # ty:ignore[invalid-argument-type]
    for idx, group in enumerate(
        [
            {},
            {},
            {},
            {},
            {},
            {
                "matches": [
                    Match(wm_class="vesktop"),
                    Match(wm_class="discord"),
                    Match(wm_class="zapzap"),
                    Match(wm_class="nheko"),
                ]
            },
            {
                "matches": [
                    Match(wm_class="Spotify"),
                ]
            },
            {},
            {},
            {},
        ],
    )
]

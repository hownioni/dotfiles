from libqtile.config import Click, Drag, Key, KeyChord
from libqtile.lazy import lazy

from .groups import groups
from .variables import (
    browser,
    config,
    game_launcher,
    launcher,
    mod,
    platform,
    rofimoji,
    rofinerd,
    school_browser,
    screenshot,
    terminal,
    window_switch,
)


# Hide/Show all windows in a group
@lazy.function
def minimize_all(qtile):
    for win in qtile.current_group.windows:
        if hasattr(win, "toggle_minimize"):
            win.toggle_minimize()


@lazy.function
def float_to_front(qtile):
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()


@lazy.function
def donothing():
    pass


keys = [
    ### Essentials
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod, "shift"], "Return", lazy.spawn(launcher), desc="Launch launcher"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "b", lazy.hide_show_bar(), desc="Toggle the bar"),
    # Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(
        [mod, "shift"],
        "c",
        lazy.widget["battery"].charge_to_full()
        if platform == "laptop"
        else donothing(),
    ),
    Key(
        [mod, "shift"],
        "x",
        lazy.widget["battery"].charge_dynamically()
        if platform == "laptop"
        else donothing(),
    ),
    # Launch apps
    KeyChord(
        [mod],
        "a",
        [
            KeyChord(
                [],
                "w",
                [
                    Key([], "w", lazy.spawn(browser), desc="Launch browser"),
                    Key([], "e", lazy.spawn(school_browser), desc="Profile for school"),
                ],
                name="Browser",
            ),
            Key([], "c", lazy.spawn("qalculate-gtk"), desc="Launch calculator"),
        ],
        name="Apps",
    ),
    Key(
        [mod, "control"],
        "c",
        lazy.spawn(f"kitty -d {config} nvim {config}"),
        desc="Edit config",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    ### Navigation & Resizing
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(["mod1"], "Tab", lazy.spawn(window_switch), desc="Change windows"),
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod, "shift"],
        "space",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left().when(layout=["bsp", "columns"]),
        lazy.layout.grow().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right().when(layout=["bsp", "columns"]),
        lazy.layout.shrink().when(layout=["monadtall", "monadwide"]),
        desc="Grow window to the right",
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    # Key([mod], "n", lazy.layout.reset(), desc="Reset window sizes to default"),
    Key(
        [mod, "shift"],
        "n",
        lazy.layout.normalize(),
        desc="Reset all window size ratios",
    ),
    # Key([mod], "m", lazy.layout.maximize(), desc="Toggle between max and min ratio"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key(
        [mod, "shift"],
        "m",
        minimize_all(),
        desc="Toggle hide/show all windows on current group",
    ),
    Key([mod], "z", float_to_front(), desc="Bring all floating windows to the front"),
    ### Dmenu/Rofi
    KeyChord(
        [mod],
        "p",
        [
            Key(
                [],
                "e",
                lazy.spawn(rofimoji),
                desc="Emoji selector",
            ),
            Key([], "n", lazy.spawn(rofinerd), desc="Nerd icon selector"),
            Key(
                [],
                "g",
                lazy.spawn(game_launcher),
                desc="Search Games installed in system",
            ),
            Key([], "y", lazy.spawn("yt-watch"), desc="Play youtube video in terminal"),
            Key([], "w", lazy.spawn("cutebg"), desc="Change wallpaper"),
            Key([], "s", lazy.spawn(f"{config}/scripts/display/change_res.sh")),
        ],
        name="Run script",
    ),
    Key(
        [mod, "shift"],
        "n",
        lazy.spawn("dunstctl context"),
        desc="Show context menu for notifications",
    ),
    ### Media keys
    Key(
        [],
        "XF86Calculator",
        lazy.spawn("qalculate-gtk"),
        desc="Launch Calculator",
    ),
    Key([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 2")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 2")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +5%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 5%-")),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "Print", lazy.spawn(screenshot)),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

### Groups
for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

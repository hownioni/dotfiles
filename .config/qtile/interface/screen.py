import subprocess

from libqtile import bar, widget
from libqtile.config import Screen

from .themes import colors, extension_defaults

# Variables
platform = subprocess.run(
    ["hostnamectl", "chassis"], stdout=subprocess.PIPE
).stdout.decode("utf-8")[:-1]
backlight = subprocess.run(
    ["ls", "/sys/class/backlight/"], stdout=subprocess.PIPE
).stdout.decode("utf-8")[:-1]


## Custom functions
def txt_remove(text):
    return ""


extension_defaults = extension_defaults

bar_thickness = 20
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(
                    active=colors[9],
                    inactive=colors[2],
                    highlight_method="line",
                    highlight_color=[f"{colors[0]}", f"{colors[2]}"],
                    font="Symbols Nerd Font Mono",
                ),
                widget.Prompt(),
                widget.WindowName(),
                # widget.TaskList(
                #    parse_text=txt_remove,
                #    background = colors[9],
                #    txt_floating="🗗 ",
                #    txt_maximized="🗖 ",
                #    txt_minimized="🗕 ",
                # ),
                widget.Chord(
                    chords_colors={
                        "Apps": (f"{colors[2]}", f"{colors[16]}"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Systray(),
                widget.Clock(format="%F %a - %r"),
                widget.PulseVolume(
                    mute_command="pamixer --toggle-mute",
                    volume_down_command="pamixer --decrease 2",
                    volume_up_command="pamixer --increase 2",
                    volume_app="pamixer",
                ),
                widget.Backlight(backlight_name=backlight),
                widget.Battery(
                    background=colors[2],
                    foreground=colors[16],
                    charge_char="󰂄",
                    discharge_char="󱟞",
                    format="{char} {percent:2.0%}",
                )
                if platform == "laptop"
                else widget.CPU(),
                widget.Sep(linewidth=0, padding=5),
            ],
            bar_thickness,
            background=f"{colors[0]}",
            opacity=0.9,
        ),
    ),
]

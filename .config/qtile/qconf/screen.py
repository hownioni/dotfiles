from libqtile import bar
from libqtile.config import Screen
from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

from .variables import (
    backlight,
    bar_font,
    bar_fontsize,
    bar_global_opacity,
    bar_iconsize,
    bar_thickness,
    colors,
    context_fontsize,
    context_width,
    platform,
)


## Custom functions
def txt_remove(text):
    return ""


class WidgetTweaker:
    def __init__(self, func):
        self.format = func


@WidgetTweaker
def volume(output):
    if output.endswith("%"):
        volume = int(output[:-1])

        icons = {
            range(0, 33): "󰕿",
            range(33, 66): "󰖀",
            range(66, 101): "󰕾",
        }

        icon = icons[next(filter(lambda r: volume in r, icons.keys()))]

        return icon
    elif output == "M":
        return "󰕿"
    else:
        return output


@WidgetTweaker
def brightness(output):
    if output.endswith("%"):
        volume = int(output[:-1])

        icons = {
            range(0, 11): "",
            range(11, 22): "",
            range(22, 33): "",
            range(33, 44): "",
            range(44, 55): "",
            range(55, 66): "",
            range(66, 77): "",
            range(77, 88): "",
            range(88, 101): "",
        }

        icon = icons[next(filter(lambda r: volume in r, icons.keys()))]

        return icon
    else:
        return output


# decorations
powerline_arl = {"decorations": [PowerLineDecoration()]}
powerline_arr = {"decorations": [PowerLineDecoration(path="arrow_right")]}
powerline_rdl = {"decorations": [PowerLineDecoration(path="rounded_left")]}
powerline_rdr = {"decorations": [PowerLineDecoration(path="rounded_right")]}
powerline_fslash = {"decorations": [PowerLineDecoration(path="forward_slash")]}
powerline_bslash = {"decorations": [PowerLineDecoration(path="back_slash")]}

widget_defaults = dict(
    font=bar_font,
    fontsize=bar_fontsize,
    padding=5,
    background=colors[0],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(
                    length=18,
                ),
                widget.GroupBox(
                    active=colors[9],
                    inactive=colors[2],
                    highlight_method="line",
                    highlight_color=[f"{colors[0]}", f"{colors[2]}"],
                    font="Symbols Nerd Font Mono",
                    disable_drag=True,
                    **powerline_bslash,
                ),
                widget.CurrentLayout(
                    padding=bar_fontsize // 2,
                    mode="both",
                    scale=0.50,
                    background=colors[2],
                ),
                widget.Spacer(
                    length=1,
                    background=colors[2],
                    **powerline_bslash,
                ),
                widget.Chord(
                    background=colors[1],
                    foreground=colors[16],
                    chords_colors={},
                    name_transform=lambda name: name.upper(),
                    **powerline_bslash,
                ),
                widget.WindowName(
                    empty_group_string="Desktop",
                    max_chars=130,
                ),
                widget.Spacer(
                    length=1,
                    **powerline_rdr,
                ),
                widget.WidgetBox(
                    widgets=[
                        widget.Spacer(
                            length=10,
                            background=colors[2],
                        ),
                        widget.StatusNotifier(
                            icon_size=bar_iconsize,
                            menu_fontsize=context_fontsize,
                            menu_width=context_width,
                            background=colors[2],
                        ),
                        widget.Systray(
                            icon_size=bar_iconsize,
                            background=colors[2],
                            **powerline_fslash,
                        ),
                    ],
                    text_closed="",
                    text_open="",
                    background=colors[2],
                ),
                widget.Spacer(
                    length=6,
                    background=colors[2],
                    **powerline_fslash,
                ),
                widget.TextBox(
                    text="",
                    fontsize=bar_iconsize,
                    background=colors[13],
                    foreground=colors[0],
                ),
                widget.Memory(
                    format="{MemUsed: .0f}{mm}",
                    background=colors[13],
                    foreground=colors[0],
                    **powerline_fslash,
                ),
                widget.Battery(
                    background=colors[2],
                    foreground=colors[16],
                    charge_char="󰂄",
                    discharge_char="󱟞",
                    full_char="󰁹",
                    empty_char="󱟥",
                    not_charging_char="󰂃",
                    unknown_char="󰂑",
                    show_short_text=False,
                    format="{char}",
                    update_interval=5,
                    fontsize=bar_iconsize,
                )
                if platform == "laptop"
                else widget.Spacer(length=0),
                widget.Battery(
                    background=colors[2],
                    foreground=colors[16],
                    format="{percent:2.0%} {hour:d}:{min:02d}",
                    update_interval=5,
                    charge_controller=lambda: (0, 80),
                    notify_below=20,
                    **powerline_fslash,
                )
                if platform == "laptop"
                else widget.Spacer(length=0),
                widget.TextBox(
                    text="",
                    tag_sensor="CPU",
                    background=colors[13],
                    foreground=colors[0],
                    fontsize=bar_iconsize,
                ),
                widget.ThermalSensor(
                    background=colors[13],
                    foreground=colors[0],
                    **powerline_fslash,
                ),
                widget.Backlight(
                    backlight_name=backlight,
                    background=colors[2],
                    foreground=colors[16],
                ),
                widget.Backlight(
                    backlight_name=backlight,
                    background=colors[2],
                    foreground=colors[16],
                    fmt=brightness,
                    **powerline_fslash,
                ),
                widget.PulseVolume(
                    fmt=volume,
                    fontsize=bar_iconsize,
                    background=colors[13],
                    foreground=colors[0],
                    padding=10,
                ),
                widget.PulseVolume(
                    mute_command="pamixer --toggle-mute",
                    volume_down_command="pamixer --decrease 2",
                    volume_up_command="pamixer --increase 2",
                    volume_app="pamixer",
                    background=colors[13],
                    foreground=colors[0],
                    **powerline_bslash,
                ),
                widget.TextBox(
                    text="",
                    fontsize=bar_iconsize,
                    background=colors[4],
                ),
                widget.Clock(
                    format="%I:%M %p",
                    background=colors[4],
                ),
                widget.Spacer(
                    length=18,
                    background=colors[4],
                ),
            ],
            bar_thickness,
            background=f"{colors[0]}",
            opacity=bar_global_opacity,
            margin=[15, 60, 6, 60],
        ),
    ),
]

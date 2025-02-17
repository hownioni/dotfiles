from libqtile import bar, layout
from libqtile.config import Match, Screen
from qtile_extras import widget

from .variables import backlight, colors, platform


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

        icons = {range(0, 33): "󰕿   ", range(33, 66): "󰖀   ", range(66, 101): "󰕾   "}

        icon = icons[next(filter(lambda r: volume in r, icons.keys()))]

        return icon + output
    elif output == "M":
        return "󰕿   Muted"
    else:
        return output


widget_defaults = dict(
    font="Noto Sans Medium",
    fontsize=13,
    background=colors[0],
)
extension_defaults = widget_defaults.copy()

bar_thickness = 22
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
                    disable_drag=True,
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
                widget.StatusNotifier(
                    icon_size=bar_thickness, icon_theme="Papirus-Light"
                ),
                widget.Clock(format="%F %a - %H:%M"),
                widget.PulseVolume(
                    mute_command="pamixer --toggle-mute",
                    volume_down_command="pamixer --decrease 2",
                    volume_up_command="pamixer --increase 2",
                    volume_app="pamixer",
                    fmt=volume,
                ),
                widget.Backlight(backlight_name=backlight),
                widget.IWD(padding=2),
                widget.Battery(
                    background=colors[2],
                    foreground=colors[16],
                    charge_char="󰂄",
                    discharge_char="󱟞",
                    format="{char} {percent:2.0%}",
                )
                if platform == "laptop"
                else widget.CPUGraph(),
                widget.Sep(linewidth=0, padding=5),
            ],
            bar_thickness,
            background=f"{colors[0]}",
            opacity=0.9,
        ),
    ),
]

layout_theme = {
    "border_width": 2,
    "margin": 4,
    "border_focus": colors[12],
    "border_normal": colors[3],
}

layouts = [
    layout.Columns(
        **layout_theme, border_focus_stack=colors[12], border_normal_stack=colors[3]
    ),
    layout.MonadTall(**layout_theme),
    layout.Max(
        border_width=0,
        margin=0,
    ),
]

floating_layout = layout.Floating(
    border_width=2,
    border_focus=colors[12],
    border_normal=colors[3],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="dialog"),  # dialog boxes
        Match(wm_class="download"),  # downloads
        Match(wm_class="error"),  # error msgs
        Match(wm_class="file_progress"),  # file progress boxes
        Match(wm_class="kdenlive"),  # kdenlive
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="zenity"),
        Match(wm_class="notification"),  # notifications
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="toolbar"),  # toolbars
        Match(wm_class="Yad"),  # yad boxes
        Match(title="branchdialog"),  # gitk
        Match(title="Confirmation"),  # tastyworks exit box
        Match(wm_class="qalculate-gtk"),  # qalculate-gtk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="tastycharts"),  # tastytrade pop-out charts
        Match(title="tastytrade"),  # tastytrade pop-out side gutter
        Match(title="tastytrade - Portfolio Report"),  # tastytrade pop-out allocation
        Match(wm_class="tasty.javafx.launcher.LauncherFxApp"),  # tastytrade settings
        Match(title="ModOrganizer"),
        Match(wm_class="sober_services"),
    ],
)

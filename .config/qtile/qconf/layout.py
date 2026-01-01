from libqtile import layout
from libqtile.config import Match

from .variables import (
    colors,
)

layout_config = {
    "border_width": 0,
    "margin": 9,
    "border_focus": colors[12],
    "border_normal": colors[3],
    "font": "FiraCode NerdFont",
}

floating_layout = layout.Floating(
    **layout_config,
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

layouts = [
    layout.Bsp(
        **layout_config,
        fair=False,
        border_on_single=True,
    ),
    layout.Columns(
        **layout_config,
        border_focus_stack=colors[12],
        border_normal_stack=colors[3],
        split=False,
        num_colums=2,
    ),
    floating_layout,
    layout.Max(
        border_width=0,
        margin=0,
    ),
]

import subprocess

from libqtile import hook

from qconf.keymaps import keys, mouse
from qconf.layout import floating_layout, layouts
from qconf.screen import screens, widget_defaults
from qconf.variables import config, groups

### Mappings
keys = keys

mouse = mouse

### Interface
groups = groups

layouts = layouts

widget_defaults = widget_defaults

screens = screens

### Options
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = "floating_only"
cursor_warp = False

# Floating
floating_layout = floating_layout
floats_kept_above = True

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None


# Hooks
@hook.subscribe.startup_once
def autostart():
    subprocess.Popen([config + "scripts/autostart.sh"])


@hook.subscribe.startup
def start_always():
    subprocess.Popen(["xsetroot", "-cursor_name", "left_ptr"])
    subprocess.Popen([config + "scripts/display/setup.sh"])


@hook.subscribe.client_new
def float_steam(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if wm_class == ("Steam", "Steam") and (
        w_name != "Steam"
        or "PMaxSize" in window.window.get_wm_normal_hints().get("flags", ())
    ):
        window.floating = True


@hook.subscribe.client_new
def float_firefox(window):
    wm_class = window.window.get_wm_class()
    w_name = window.window.get_name()
    if wm_class == ("Places", "Firefox") and w_name == "Library":
        window.floating = True


@hook.subscribe.client_new
def mo2_nosteal(window):
    w_name = window.window.get_name()
    if w_name == "ModOrganizer":
        window.can_steal_focus = False


wmname = "LG3D"

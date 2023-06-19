import os
import re
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile import layout, bar, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule
from libqtile.command import lazy
from libqtile.widget import Spacer

#mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')


@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

keys = [
# Most of the keybindings are in sxhkd file - except these
    Key([mod], "m", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "c", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "space", lazy.next_layout()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod, "control"], "l",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "h",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),
    Key([mod, "shift"], "f", lazy.layout.flip()),
    Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),
    Key([], "XF86MonBrightnessUp", lazy.spawn("/home/chetj/.config/qtile/scripts/bright.sh Up")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("/home/chetj/.config/qtile/scripts/bright.sh Down")),
    Key([mod, "shift"], "space", lazy.window.toggle_floating()),
    ]

def window_to_previous_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i != 0:
        group = qtile.screens[i - 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i - 1)

def window_to_next_screen(qtile, switch_group=False, switch_screen=False):
    i = qtile.screens.index(qtile.current_screen)
    if i + 1 != len(qtile.screens):
        group = qtile.screens[i + 1].group.name
        qtile.current_window.togroup(group, switch_group=switch_group)
        if switch_screen == True:
            qtile.cmd_to_screen(i + 1)


groups = []

# FOR QWERTY KEYBOARDS
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",]

#group_labels = ["1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "0",]
group_labels = ["", "", "", "", "", "", "", "", "", "",]
#group_labels = ["Dev", "Web", "Term", "Pac",]

group_layouts = ["monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall",]
#group_layouts = ["monadtall", "matrix", "monadtall", "bsp", "monadtall", "matrix", "monadtall", "bsp", "monadtall", "monadtall",]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend([

#CHANGE WORKSPACES
        Key([mod], i.name, lazy.group[i.name].toscreen()),
        Key([mod], "Tab", lazy.screen.next_group()),
        Key([mod, "shift" ], "Tab", lazy.screen.prev_group()),
        Key(["mod1"], "Tab", lazy.screen.next_group()),
        Key(["mod1", "shift"], "Tab", lazy.screen.prev_group()),

# MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND STAY ON WORKSPACE
        #Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
# MOVE WINDOW TO SELECTED WORKSPACE 1-10 AND FOLLOW MOVED WINDOW TO WORKSPACE
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name) , lazy.group[i.name].toscreen()),
    ])


def init_layout_theme():
    return {"margin":5,
            "border_width":2,
            "border_focus": "#5e81ac",
            "border_normal": "#4c566a"
            }

layout_theme = init_layout_theme()


layouts = [
    #layout.MonadTall(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.MonadTall(**layout_theme),
    #layout.MonadWide(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.MonadWide(**layout_theme),
    layout.Matrix(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Floating(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]

rosepine = {
        "base": "#191724",
        "surface": "#1f1d2e",
        "overlay": "#26233a",
        "muted": "#6e6a86",
        "subtle": "#908caa",
        "text": "#e0def4",
        "love": "#eb6f92",
        "gold": "#f6c177",
        "rose": "#ebbcba",
        "pine": "#31748f",
        "foam": "#9ccfd8",
        "iris": "#c4a7e7",
        }
# WIDGETS FOR THE BAR

def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize = 12,
                padding = 2,
                background=rosepine["base"])

widget_defaults = init_widgets_defaults()

def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
            widget.Spacer(
                length = 5,
                background = rosepine["base"],
                ),
            widget.TextBox(
                text = "",
                padding = 0,
                fontsize = 20,
                foreground = rosepine["overlay"],
                background = rosepine["base"],
                ),
            widget.GroupBox(
                font = "FontAwesome",
                fontsize = 14,
                margin_y = 3,
                margin_x = 0,
                borderwidth = 3,
                disable_drag = True,
                active = rosepine["text"],
                inactive = rosepine["muted"],
                rounded = True,
                spacing = None,
                highlight_method = "border",
                this_current_screen_border = rosepine["pine"],
                foreground = rosepine["text"],
                background = rosepine["overlay"]
                ),
            widget.TextBox(
                text = "",
                padding = 0,
                fontsize = 20,
                foreground = rosepine["overlay"],
                background = rosepine["base"],
                ),
            widget.Sep(
                linewidth = 0,
                padding = 5,
                background = rosepine["base"]
                ),
            widget.TextBox(
                text = "",
                padding = 0,
                fontsize = 20,
                foreground = rosepine["overlay"],
                background = rosepine["base"],
                ),
            widget.CurrentLayout(
                font = "Noto Sans Bold",
                foreground = rosepine["text"],
                background = rosepine["overlay"]
                ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    background = rosepine["base"]
                    ),
            widget.WindowName(
                    foreground = rosepine["text"],
                    background = rosepine["base"],
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.TextBox(
                    font="FontAwesome",
                    text="  ",
                    foreground = rosepine["text"],
                    background = rosepine["overlay"],
                    padding = 0,
                    fontsize = 14
                    ),
            widget.Clock(
                    foreground = rosepine["text"],
                    background = rosepine["overlay"],
                    fontsize = 12,
                    format="%m-%d-%Y %a (%I:%M %p)"
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    background = rosepine["base"]
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.TextBox(
                    text = "󱒒 ",
                    padding = 0,
                    fontsize = 16,
                    foreground = rosepine["text"],
                    background = rosepine["overlay"],
                    ),
            widget.Memory(
                    font="Noto Sans",
                    update_interval = 2,
                    fontsize = 12,
                    foreground = rosepine["text"],
                    background = rosepine["overlay"],
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    background = rosepine["base"]
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.TextBox(
                    text = " ",
                    padding = 0,
                    fontsize = 16,
                    foreground = rosepine["text"],
                    background = rosepine["overlay"],
                    ),
            widget.CPU(
                    font="Noto Sans",
                    update_interval = 2,
                    format = "CPU: {load_percent}% {freq_current}GHz",
                    fontsize = 12,
                    foreground = rosepine["text"],
                    background = rosepine["overlay"],
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    background = rosepine["base"]
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.TextBox(
                    text="󱊣 ",
                    foreground = rosepine["text"],
                    background = rosepine["overlay"],
                    padding = 0,
                    fontsize=16
                    ),
            widget.Battery(
                    font="Noto Sans",
                    update_interval = 10,
                    format = "{percent:2.0%}",
                    fontsize = 12,
                    foreground = rosepine["text"],
                    background = rosepine["overlay"],
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    background = rosepine["base"]
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.Systray(
                    background = rosepine["overlay"],
                    icon_size=20,
                    padding = 3
                    ),
            widget.TextBox(
                    text = "",
                    padding = 0,
                    fontsize = 20,
                    foreground = rosepine["overlay"],
                    background = rosepine["base"],
                    ),
            widget.Sep(
                    linewidth = 0,
                    padding = 5,
                    background = rosepine["base"]
                    ),
            ]
    return widgets_list

widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2

widgets_screen1 = init_widgets_screen1()
widgets_screen2 = init_widgets_screen2()


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26, opacity=0.8)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26, opacity=0.8))]
screens = init_screens()


# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []

main = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/scripts/autostart.sh'])

@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

floating_types = ["notification", "toolbar", "splash", "dialog"]


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='Arcolinux-welcome-app.py'),
    Match(wm_class='Arcolinux-calamares-tool.py'),
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='Arandr'),
    Match(wm_class='feh'),
    Match(wm_class='Galculator'),
    Match(wm_class='archlinux-logout'),
    Match(wm_class='xfce4-terminal'),

],  fullscreen_border_width = 0, border_width = 0)
auto_fullscreen = True

focus_on_window_activation = "focus" # or smart

wmname = "LG3D"

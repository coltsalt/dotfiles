-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--


hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar -c ~/.config/waybar/current_layout -s ~/.config/waybar/current_style")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("swaync")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("carla /home/colts/sysaudio.carxp", { workspace = "special:carla"})
  hl.exec_cmd("qpwgraph -m -a /home/colts/sysaud.qpwgraph")
  hl.exec_cmd("QT_STYLE_OVERRIDE=kvantum-dark qpwgraph -m -a")
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 19")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("spotify", { workspace = "special:magic" })
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
end)

local monitor_count = 0
local expected_monitors = 2

hl.on("monitor.added", function (mon)
    monitor_count = monitor_count + 1
    if monitor_count >= expected_monitors then
        hl.exec_cmd("nvibrant 200 400")
        hl.exec_cmd("hyprsunset -g 100 -t 6500")
    end
end)

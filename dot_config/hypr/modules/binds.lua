---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "thunar"
local menu        = "pkill rofi || rofi -show drun -theme ./.config/rofi/applauncher.rasi -show-icons "
local browser     = "firefox"
local code        = "vscodium"

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

--open apps
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(code))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(browser))

--scripts
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("bash /home/colts/.config/hypr/scripts/rice-wizard.sh"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("/home/colts/.config/waybar/waybar-layout.sh"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("/home/colts/.config/waybar/scripts/launch.sh"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("/home/colts/.config/hypr/scripts/clipboard.sh"))

hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.exec_cmd("hyprctl hyprsunset gamma -10"))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.exec_cmd("hyprctl hyprsunset gamma +10"))
hl.bind(mainMod .. " + SHIFT + Backspace", hl.dsp.exec_cmd("hyprctl hyprsunset gamma 100"))
hl.bind(mainMod .. " + CTRL + minus", hl.dsp.exec_cmd("hyprctl hyprsunset temperature -500"))
hl.bind(mainMod .. " + CTRL + equal", hl.dsp.exec_cmd("hyprctl hyprsunset temperature +500"))
hl.bind(mainMod .. " + CTRL + Backspace", hl.dsp.exec_cmd("hyprctl hyprsunset temperature 6500"))


hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle"}))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("swaync-client -t"))
hl.bind(mainMod .. " + O", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m active -m output"))
-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
-- move windows 
hl.bind(mainMod .. " + A", hl.dsp.window.move({direction = "l"}))
hl.bind(mainMod .. " + D", hl.dsp.window.move({direction = "r"}))
hl.bind(mainMod .. " + W", hl.dsp.window.move({direction = "u"}))
hl.bind(mainMod .. " + S", hl.dsp.window.move({direction = "d"}))
-- resize windows
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.resize({ x = -80, y = 0, relative=true}))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.resize({ x = 80, y = 0, relative=true}))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.resize({ x = 0, y = -40, relative=true}))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.resize({ x = 0, y = 40, relative=true}))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow=false }))
    hl.bind(mainMod .. " + CTRL + " .. key,      hl.dsp.window.move({ workspace = i,}))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + Z",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + ALT + Z ",         hl.dsp.workspace.toggle_special("carla"))
hl.bind(mainMod .. " + SHIFT + ALT + Z", hl.dsp.window.move({ workspace = "special:carla" }))


-- -- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@165.00Hz",
    position = "1920x0",
    scale    = "1",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080@60.00Hz",
    position = "0x0",
    scale    = "1",
})

for i = 1, 5 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", persistent = true, default = (i == 1)})
end
for i = 6, 10 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1", persistent = true, default = (i == 6)})
end

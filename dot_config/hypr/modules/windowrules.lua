--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful
-- Assign workspaces to monitors
hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
hl.layer_rule({
	name = "rofi-dropdown",
	match = { namespace = "rofi" },
	animation = "slide bottom",
	dim_around = false
})

hl.layer_rule({
	name = "notification-animations",
	match = { namespace = "swaync-control-center" },
	animation = "slide top"
})
hl.window_rule({
    name = "qView-float",
    match = { class = "com.interversehq.qView" },
    float = true,
    size = {1000,600},
    center = true
})
hl.window_rule({
    match = { 
        initial_class = "Spotify" 
    },
    workspace = "special:magic",
    opacity = "1 override 0.85 override"
})

hl.window_rule({
  match = {
    initial_class = "carla"
  },
  workspace = "special:carla"
})

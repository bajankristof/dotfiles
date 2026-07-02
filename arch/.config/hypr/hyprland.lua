-- Hyprland Lua config
-- Converted from hyprland.conf
-- See https://wiki.hypr.land/Configuring/Start/


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
  output        = "",
  mode          = "3840x2160@120",
  position      = "auto",
  scale         = "2",
  bitdepth      = 10,
  cm            = "hdr",
  sdr_eotf      = "srgb",
  sdrbrightness = 2,
  sdrsaturation = 0.9,
  sdr_min_luminance = 0,
  sdr_max_luminance = 120,
  min_luminance = 0,
  max_luminance = 600,
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "ghostty"
local fileManager = "nemo"
local browser     = "google-chrome-stable"
local menu        = "vicinae toggle"
local steam       = "steam"
local onePassword = "1password --disable-features=WaylandWpColorManagerV1"
local messenger   = "discord"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
  hl.exec_cmd("qs -c noctalia-shell")
  hl.exec_cmd("vicinae server")
  hl.exec_cmd(onePassword .. " --silent")
  hl.exec_cmd("steam -silent")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"')
  hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
  hl.exec_cmd('gsettings set org.gnome.desktop.wm.preferences button-layout ":"')
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDK_SCALE", "2")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in  = 4,
    gaps_out = 8,

    border_size = 2,

    col = {
      active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
      inactive_border = "rgba(363a4fff)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
    allow_tearing = true,

    layout = "dwindle",
  },

  decoration = {
    rounding       = 16,
    rounding_power = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = "rgba(1a1a1aee)",
    },

    blur = {
      enabled        = true,
      size           = 3,
      passes         = 3,
      noise          = 0.04,
      contrast       = 1.5,
      ignore_opacity = true,
    },
  },

  animations = {
    enabled = true,
  },
})

-- Default curves, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}  } })

-- Default animations
hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

-----------------
----  DEBUG  ----
-----------------

hl.config({
  debug = {
    -- NOTE: vfr causes flickering in Hyprland 0.55
    -- (https://github.com/hyprwm/Hyprland/discussions/14720).
    vfr = false,
  },
})


----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    force_default_wallpaper  = 0,
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
    vrr                      = 2,
  },
})


----------------
----  RENDER ---
----------------

hl.config({
  render = {
    cm_enabled        = true,
    cm_auto_hdr       = 1,
  },
})


------------------
---- XWAYLAND ----
------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/XWayland/
hl.config({
  xwayland = {
    force_zero_scaling = true,
  },
})


---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout  = "us",
    kb_variant = "",
    kb_model   = "",
    kb_options = "",
    kb_rules   = "",

    follow_mouse = 1,

    sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = false,
    },
  },
})

hl.gesture({
  fingers   = 3,
  direction = "horizontal",
  action    = "workspace",
})

-- Per-device config
hl.device({
  name        = "corsair-corsair-m65-rgb-elite-gaming-mouse",
  sensitivity = -1,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
hl.bind(mainMod .. " + semicolon",      hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",              hl.dsp.window.close())
hl.bind(mainMod .. " + M",              hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + E",              hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + space",          hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + space",  hl.dsp.exec_cmd(onePassword .. " --quick-access"))
hl.bind(mainMod .. " + SHIFT + X",      hl.dsp.exec_cmd(onePassword .. " --quick-access"))
hl.bind(mainMod .. " + B",              hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + G",              hl.dsp.exec_cmd(steam))
hl.bind(mainMod .. " + apostrophe",     hl.dsp.exec_cmd(messenger))
hl.bind(mainMod .. " + SHIFT + return", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + ALT + return",   hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- MacOS-like shortcuts
hl.bind("SUPER + C", hl.dsp.send_shortcut({ mods = "CTRL",  key = "Insert" }))
hl.bind("SUPER + V", hl.dsp.send_shortcut({ mods = "SHIFT", key = "Insert" }))
hl.bind("SUPER + X", hl.dsp.send_shortcut({ mods = "CTRL",  key = "X" }))
hl.bind("SUPER + F", hl.dsp.send_shortcut({ mods = "CTRL",  key = "F" }))
hl.bind("SUPER + W", hl.dsp.send_shortcut({ mods = "CTRL",  key = "W" }))
hl.bind("SUPER + T", hl.dsp.send_shortcut({ mods = "CTRL",  key = "T" }))
hl.bind("SUPER + R", hl.dsp.send_shortcut({ mods = "CTRL",  key = "R" }))
hl.bind("SUPER + S", hl.dsp.send_shortcut({ mods = "CTRL",  key = "S" }))

-- Move focus with mainMod SHIFT + vim keys
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
  -- Ignore maximize requests from all apps
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

hl.window_rule({
  name  = "focus-search-popups",
  match = {
    class = "^(1password|vicinae)$",
    float = true,
    focus = true,
  },
  stay_focused = true,
})

hl.window_rule({
  name  = "float-steam-popups",
  match = {
    class = "^(steam)$",
    title = "negative:^(Steam)$",
  },
  float = true,
})

hl.window_rule({
  name  = "isolate-games",
  match = { class = "^(gamescope|hyprgame)$" },
  workspace    = "empty",  -- Move to empty workspace
  immediate    = true,     -- Allow tearing
  idle_inhibit = "always", -- Prevent screen from going to sleep
  no_blur      = true,     -- Disable blur for performance
})

hl.window_rule({
  name  = "highlight-maximized",
  match = { fullscreen_state_client = 1 },
  border_color = {
    colors = {"rgba(df8e1dee)", "rgba(e64553ee)"},
    angle = 45,
  },
})

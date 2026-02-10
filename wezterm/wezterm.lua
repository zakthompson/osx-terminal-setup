local wezterm = require("wezterm")
local act = wezterm.action

local function is_nvim(pane)
	return pane:get_foreground_process_name():match("n?vim") ~= nil
end

return {
	font = wezterm.font("JetBrains Mono", { weight = "Bold" }),

	wezterm.on("window-config-reloaded", function(window, pane)
		window:toast_notification("wezterm", "configuration reloaded!", nil, 4000)
	end),

	freetype_load_target = "HorizontalLcd",
	font_size = 13.0,

	color_scheme = "Catppuccin Mocha",

	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	hide_tab_bar_if_only_one_tab = false,
	show_tab_index_in_tab_bar = false,
	tab_max_width = 1000,
	notification_handling = "AlwaysShow",
	window_decorations = "RESIZE",

	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		-- Pick an icon based on the command, or use a default
		local process_icons = {
			["nvim"] = "", -- Nerd Font nvim icon
			["vim"] = "",
			["zsh"] = "",
			["bash"] = "",
			["fish"] = "󰈺",
			["htop"] = "",
			["ssh"] = "",
			["git"] = "",
			["node"] = "",
		}

		local pane = tab.active_pane
		local title = pane.title
		local process_name = string.gsub(pane.foreground_process_name, "(.*[/\\])", "")
		local icon = process_icons[process_name] or "" -- default terminal icon

		-- Compose tab title
		local tab_title = string.format(" %s %s ", icon, title)

		-- Truncate if necessary
		if wezterm.column_width(tab_title) > max_width then
			tab_title = wezterm.truncate_right(tab_title, max_width - 1) .. "…"
		end

		return {
			{ Text = tab_title },
		}
	end),

	keys = {
		{
			key = "h",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if is_nvim(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "h", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action.ActivatePaneDirection("Left"), pane)
				end
			end),
		},
		{
			key = "l",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if is_nvim(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "l", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action.ActivatePaneDirection("Right"), pane)
				end
			end),
		},
		{
			key = "k",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if is_nvim(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "k", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action.ActivatePaneDirection("Up"), pane)
				end
			end),
		},
		{
			key = "j",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if is_nvim(pane) then
					window:perform_action(wezterm.action.SendKey({ key = "j", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action.ActivatePaneDirection("Down"), pane)
				end
			end),
		},
		{ key = "<", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
		{ key = ">", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
		{
			key = "LeftArrow",
			mods = "OPT",
			action = act.SendKey({
				key = "b",
				mods = "ALT",
			}),
		},
		{
			key = "RightArrow",
			mods = "OPT",
			action = act.SendKey({ key = "f", mods = "ALT" }),
		},
	},
}

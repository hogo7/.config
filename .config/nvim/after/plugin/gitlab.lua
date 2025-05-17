require("gitlab").setup({
	statusline = {
		enabled =true,
	},
	code_suggestions = {
		-- For the full list of default languages, see the 'auto_filetypes' array in
		-- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
		auto_filetypes = { "javascript" }, -- Default is { 'ruby' }
		ghost_text = {
			enabled = false, -- ghost text is an experimental feature
			toggle_enabled = "<C-h>",
			accept_suggestion = "<C-l>",
			clear_suggestions = "<C-k>",
			stream = true,
		},
	},
})

local neoscroll = require("neoscroll")

local easing = "sine"
local zz_time_ms = 100
local jump_time_ms = 200

neoscroll.setup({
	mappings = { -- Keys to be mapped to their corresponding default scrolling animation
		"<C-u>",
		"<C-d>",
		"<C-b>",
		"<C-f>",
		"<C-y>",
		"zt",
		"zz",
		"zb",
	},
	post_hook = function(info)
		if info ~= "center" then
			return
		end

		-- The `defer_fn` is a bit of a hack.
		-- We use it so that `neoscroll.init.scroll` will be false when we call `neoscroll.zz`
		-- As long as we don't input another neoscroll mapping in the timeout,
		-- we should be able to center the cursor.
		local defer_time_ms = 10
		vim.defer_fn(function()
			neoscroll.zz(zz_time_ms, easing)
		end, defer_time_ms)
	end,
})

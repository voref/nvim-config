return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Function to dinamically obtain colors from the current theme
		local function get_hl_color(group, attr)
			local ok, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
			if ok and hl[attr] then
				return string.format("#%06x", hl[attr])
			else
				return "#ffffff" -- Default color if it fails
			end
		end

		-- Obtain colors from the active theme
		local header_color = get_hl_color("Title", "foreground")
		local buttons_color = get_hl_color("Function", "foreground")
		local footer_color = get_hl_color("Comment", "foreground")

		-- Header
		dashboard.section.header.val = {
			" ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ",
			" ████╗  ██║██║   ██║██║████╗ ████║ ",
			" ██╔██╗ ██║██║   ██║██║██╔████╔██║ ",
			" ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			" ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			" ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"          Neovim Loaded! 🚀         ",
		}

		-- Apply dynamic colors from the theme
		vim.api.nvim_set_hl(0, "AlphaHeader", { fg = header_color })
		vim.api.nvim_set_hl(0, "AlphaButtons", { fg = buttons_color })
		vim.api.nvim_set_hl(0, "AlphaFooter", { fg = footer_color })

		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"

		-- Centered and aligned buttons
		dashboard.section.buttons.val = {
			dashboard.button("f", "📂  Find File", ":Telescope find_files <CR>"),
			dashboard.button("r", "🕘  Recent Files", ":Telescope oldfiles <CR>"),
			dashboard.button("s", "⚙️  Settings", ":e $MYVIMRC <CR>"),
			dashboard.button("q", "❌  Quit", ":qa<CR>"),
		}

		-- Footer
		dashboard.section.footer.val = { "✨ Neovim powered by Voref ✨" }

		-- Center the content on the screen
		dashboard.opts.layout = {
			{ type = "padding", val = 5 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		-- Apply conf
		alpha.setup(dashboard.opts)
	end,
}

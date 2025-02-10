return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Función para obtener colores del tema activo
    local function get_hl_color(group, attr)
      local ok, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)
      if ok and hl[attr] then
        return string.format("#%06x", hl[attr])
      else
        return "#ffffff" -- Color por defecto si falla
      end
    end

    -- Obtener colores del tema activo
    local header_color = get_hl_color("Title", "foreground")
    local buttons_color = get_hl_color("Function", "foreground")
    local footer_color = get_hl_color("Comment", "foreground")

    -- Configurar header con una fuente minimalista
    dashboard.section.header.val = {
      " ███╗   ██╗██╗   ██╗██╗███╗   ███╗ ",
      " ████╗  ██║██║   ██║██║████╗ ████║ ",
      " ██╔██╗ ██║██║   ██║██║██╔████╔██║ ",
      " ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      " ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      " ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "          Neovim Loaded! 🚀         ",
    }

    -- Aplicar colores dinámicos del tema
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = header_color })
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = buttons_color })
    vim.api.nvim_set_hl(0, "AlphaFooter", { fg = footer_color })

    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"

    -- Botones centrados y alineados
    dashboard.section.buttons.val = {
      dashboard.button("f", "📂  Find File", ":Telescope find_files <CR>"),
      dashboard.button("r", "🕘  Recent Files", ":Telescope oldfiles <CR>"),
      dashboard.button("s", "⚙️  Settings", ":e $MYVIMRC <CR>"),
      dashboard.button("q", "❌  Quit", ":qa<CR>"),
    }

    -- Footer personalizado
    dashboard.section.footer.val = { "✨ Neovim powered by Voref ✨" }

    -- Centrar el contenido en la pantalla
    dashboard.opts.layout = {
      { type = "padding", val = 5 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }

    -- Aplicar la configuración
    alpha.setup(dashboard.opts)
  end,
}

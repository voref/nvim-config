return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      -- Configure Telescope
      telescope.setup({
        defaults = {
          path_display = { "smart" },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      -- Load extensions
      pcall(telescope.load_extension, "ui-select")

      -- Keymaps
      local keymap = vim.keymap.set
      keymap("n", "<C-p>", builtin.find_files, { desc = "Find files" })
      keymap("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      keymap("n", "<leader>fb", builtin.buffers, { desc = "Show buffers" })
      keymap("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
}

return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
      },
    })
    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ async = true }) -- Formatea de forma asíncrona
    end, { noremap = true, silent = true })
  end,
}

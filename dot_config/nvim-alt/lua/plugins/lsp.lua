return {
  { "williamboman/mason.nvim", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = { "clangd", "pyright", "bashls", "lua_ls", "vimls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()
      local servers = { "clangd", "pyright", "bashls", "vimls" }
      for _, s in ipairs(servers) do
        vim.lsp.config(s, { capabilities = caps })
        vim.lsp.enable(s)
      end
      vim.lsp.config("lua_ls", {
        capabilities = caps,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false,
                          library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
      })
      vim.lsp.enable("lua_ls")
      local map = function(keys, fn) vim.keymap.set("n", keys, fn, {}) end
      map("K",            vim.lsp.buf.hover)
      map("gd",           vim.lsp.buf.definition)
      map("gr",           vim.lsp.buf.references)
      map("<leader>ca",   vim.lsp.buf.code_action)
      map("<leader>rn",   vim.lsp.buf.rename)
    end,
  },
}

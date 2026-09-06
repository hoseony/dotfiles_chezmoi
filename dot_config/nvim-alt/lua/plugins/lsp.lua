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
      vim.lsp.config("rust_analyzer", {
        cmd = { "/opt/homebrew/bin/rust-analyzer" },
        capabilities = caps,
      })
      vim.lsp.enable("rust_analyzer")
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
      vim.lsp.config("harper_ls", {
        capabilities = caps,
        filetypes = { "markdown" },
        settings = {
          ["harper-ls"] = {
            diagnosticSeverity = "warning",
          },
        },
        root_dir = function(bufnr, on_dir)
          local filename = vim.api.nvim_buf_get_name(bufnr)
          on_dir(vim.fs.root(filename, { ".harper-dictionary.txt", ".git" }) or vim.fs.dirname(filename) or vim.fn.getcwd())
        end,
      })
      vim.lsp.enable("harper_ls")
      local map = function(keys, fn) vim.keymap.set("n", keys, fn, {}) end
      map("K",            vim.lsp.buf.hover)
      map("gd",           vim.lsp.buf.definition)
      map("gr",           vim.lsp.buf.references)
      map("<leader>ca",   vim.lsp.buf.code_action)
      map("<leader>rn",   vim.lsp.buf.rename)
      vim.keymap.set("n", "<leader>fs", vim.lsp.buf.document_symbol, { desc = "Document symbols" })

      vim.opt.updatetime = 700
      local hover_group = vim.api.nvim_create_augroup("LspAutoHover", { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = hover_group,
        callback = function(args)
          for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
            if client:supports_method("textDocument/hover") then
              vim.lsp.buf.hover({ border = "rounded", focusable = false })
              return
            end
          end
        end,
      })
    end,
  },
}

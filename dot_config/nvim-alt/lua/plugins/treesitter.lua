return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    vim.treesitter.language.register("bash", "sh")

    require("nvim-treesitter").setup({
      ensure_installed = { "c", "lua", "python", "bash", "vim", "vimdoc" },
      auto_install = true,
    })
  end,
}

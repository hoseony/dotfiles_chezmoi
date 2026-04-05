return {
  "dgox16/oldworld.nvim",
  priority = 1000,
  config = function()
    require("oldworld").setup()
    vim.cmd.colorscheme("oldworld")
  end,
}

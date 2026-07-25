local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

vim.opt.clipboard     = "unnamedplus"
vim.opt.tabstop       = 4
vim.opt.shiftwidth    = 4
vim.opt.expandtab     = true
vim.opt.smartindent   = true
vim.opt.autoindent    = true
vim.opt.number        = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
-- vim.opt.signcolumn    = "no"
vim.opt.pumheight     = 10
vim.opt.completeopt   = "menu,menuone,noinsert"

local diagnostic_wrap = require("diagnostic_wrap")
diagnostic_wrap.anchor_virtual_lines_to_start()

vim.diagnostic.config({
  virtual_text = {
    format = function()
      return ""
    end,
    spacing = 1,
  },
  virtual_lines = {
    format = diagnostic_wrap.format,
  },
})

require("lazy").setup("plugins")  -- auto-imports everything in lua/plugins/

return {
  "echasnovski/mini.pick",
  config = function()
    require("mini.pick").setup()

    local map = function(keys, fn) vim.keymap.set("n", keys, fn, {}) end
    map("<leader>ff", MiniPick.builtin.files)       -- find files
    map("<leader>fg", MiniPick.builtin.grep_live)   -- live grep
    map("<leader>fb", MiniPick.builtin.buffers)     -- open buffers
    map("<leader>fh", MiniPick.builtin.help)        -- help tags
  end,
}

return {
  "ej-shafran/compile-mode.nvim",
  version = "^5.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.g.compile_mode = {
      default_command = {
        c = "gcc -Wall -Wextra ",
      },
      use_pseudo_terminal = true,
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "compilation",
      callback = function()
        vim.bo.modifiable = true
        vim.cmd("wincmd J")
      end,
    })

    vim.keymap.set("n", "<leader>cc", "<cmd>Compile<cr>", { desc = "Compile" })
    vim.keymap.set("n", "<leader>cr", "<cmd>Recompile<cr>", { desc = "Recompile" })
    vim.keymap.set("n", "]e", "<cmd>NextError<cr>", { desc = "Next error" })
    vim.keymap.set("n", "[e", "<cmd>PrevError<cr>", { desc = "Prev error" })
    vim.keymap.set("n", "<leader>cx", "<cmd>belowright split | terminal ./a.out <cr>", { desc = "Run program" })
  end
}

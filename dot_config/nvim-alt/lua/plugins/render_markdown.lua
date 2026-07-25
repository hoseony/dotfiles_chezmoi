return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    file_types = { "markdown" },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", {
      desc = "Toggle Markdown rendering",
    })
  end,
}

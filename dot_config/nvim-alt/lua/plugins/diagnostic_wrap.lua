return {
  "hoseony/diagnostic-wrap.nvim",
  lazy = false,
  opts = {
    enabled = true,
    marker = "■",
    marker_spacing = 1,
    anchor = "start",
    show = "all",
    min_width = 20,
  },
  config = function(_, opts)
    local diagnostic_wrap = require("diagnostic-wrap")
    local enabled = opts.enabled

    local function apply()
      diagnostic_wrap.setup(vim.tbl_deep_extend("force", {}, opts, { enabled = enabled }))
    end

    apply()

    vim.keymap.set("n", "<leader>dt", function()
      enabled = not enabled
      apply()
      vim.notify("Diagnostic messages " .. (enabled and "enabled" or "disabled"))
    end, { desc = "Toggle diagnostic messages" })
  end,
}

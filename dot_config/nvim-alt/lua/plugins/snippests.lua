return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    local luasnip = require("luasnip")
    local fmt = require("luasnip.extras.fmt").fmt
    local s = luasnip.snippet
    local i = luasnip.insert_node
    local f = luasnip.function_node

    require("luasnip.loaders.from_vscode").lazy_load()

    local function header_guard()
      local filename = vim.api.nvim_buf_get_name(0)

      if filename == "" then
        return "HEADER_H"
      end

      local relative = vim.fs.relpath(vim.uv.cwd(), filename) or vim.fs.basename(filename)
      return relative:gsub("^%./", ""):gsub("[^%w]", "_"):upper()
    end

    local function c_snippets()
      return {
        s({ trig = "guard", name = "Header guard", priority = 2000 }, fmt([[
#ifndef {}
#define {}

{}

#endif
]], {
          f(header_guard),
          f(header_guard),
          i(0),
        })),
        s({ trig = "func", name = "C function", priority = 2000 }, fmt([[
{} {}({}) {{
    {}
}}
]], {
          i(1, "int"),
          i(2, "function_name"),
          i(3, "void"),
          i(0),
        })),
      }
    end

    luasnip.add_snippets("c", c_snippets())
    luasnip.add_snippets("cpp", c_snippets())
  end,
}

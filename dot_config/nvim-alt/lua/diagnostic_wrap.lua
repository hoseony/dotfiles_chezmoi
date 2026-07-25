local M = {}

function M.anchor_virtual_lines_to_start()
  local handler = vim.diagnostic.handlers.virtual_lines

  if M.original_virtual_lines_show then
    return
  end

  M.original_virtual_lines_show = handler.show
  handler.show = function(namespace, bufnr, diagnostics, opts)
    local anchored = {}

    for _, diagnostic in ipairs(diagnostics) do
      local copy = vim.deepcopy(diagnostic, true)
      copy.end_lnum = copy.lnum
      copy.end_col = copy.col
      table.insert(anchored, copy)
    end

    M.original_virtual_lines_show(namespace, bufnr, anchored, opts)
  end
end

local function available_width()
  local win = vim.api.nvim_get_current_win()
  local info = vim.fn.getwininfo(win)[1]
  local gutter_width = info and info.textoff or 0

  -- Leave room for the diagnostic connector drawn before each virtual line.
  return math.max(20, vim.api.nvim_win_get_width(win) - gutter_width - 10)
end

local function split_word(word, width)
  local chunks = {}
  local chunk = ""

  for index = 0, vim.fn.strchars(word) - 1 do
    local character = vim.fn.strcharpart(word, index, 1)

    if chunk ~= "" and vim.fn.strdisplaywidth(chunk .. character) > width then
      table.insert(chunks, chunk)
      chunk = character
    else
      chunk = chunk .. character
    end
  end

  if chunk ~= "" then
    table.insert(chunks, chunk)
  end

  return chunks
end

local function wrap_line(text, width)
  if text == "" then
    return { "" }
  end

  local lines = {}
  local current = ""

  for word in text:gmatch("%S+") do
    for _, chunk in ipairs(split_word(word, width)) do
      local candidate = current == "" and chunk or current .. " " .. chunk

      if current ~= "" and vim.fn.strdisplaywidth(candidate) > width then
        table.insert(lines, current)
        current = chunk
      else
        current = candidate
      end

      if vim.fn.strdisplaywidth(current) >= width then
        table.insert(lines, current)
        current = ""
      end
    end
  end

  if current ~= "" then
    table.insert(lines, current)
  end

  return lines
end

function M.format(diagnostic)
  local width = available_width()
  local wrapped = {}
  local message = diagnostic.message:gsub("\r", "")

  for original_line in (message .. "\n"):gmatch("(.-)\n") do
    vim.list_extend(wrapped, wrap_line(original_line, width))
  end

  return table.concat(wrapped, "\n")
end

return M

return {
  "ej-shafran/compile-mode.nvim",
  version = "^5.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local cache_file = vim.fn.stdpath("state") .. "/compile-commands.json"

    local function current_directory()
      local cwd = vim.fn.getcwd()
      return vim.uv.fs_realpath(cwd) or cwd
    end

    local function load_commands()
      if vim.fn.filereadable(cache_file) == 0 then
        return {}
      end

      local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(cache_file), "\n"))
      if ok and type(decoded) == "table" then
        return decoded
      end

      vim.notify("Could not read saved compile commands", vim.log.levels.WARN)
      return {}
    end

    local commands = load_commands()
    local active_directory = current_directory()

    local function write_commands()
      vim.fn.mkdir(vim.fn.fnamemodify(cache_file, ":h"), "p")
      vim.fn.writefile({ vim.json.encode(commands) }, cache_file)
    end

    local function save_active_command()
      local command = vim.g.compile_command
      if type(command) == "string" and command ~= "" then
        commands[active_directory] = command
        write_commands()
      end
    end

    local function restore_command(directory)
      active_directory = directory or current_directory()
      vim.g.compile_command = commands[active_directory]
    end

    restore_command(active_directory)

    vim.g.compile_mode = {
      default_command = {
        c = "gcc -Wall -Wextra -fno-diagnostics-color ",
      },
      use_pseudo_terminal = false,
      focus_compilation_buffer = true,
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "compilation",
      callback = function()
        vim.bo.modifiable = true
        vim.cmd("wincmd J")
      end,
    })

    vim.api.nvim_create_autocmd("DirChanged", {
      callback = function()
        save_active_command()
        restore_command(current_directory())
      end,
    })

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = save_active_command,
    })

    vim.keymap.set("n", "<leader>cc", function()
      vim.cmd("Compile")
      vim.schedule(save_active_command)
    end, { desc = "Compile" })

    vim.keymap.set("n", "<leader>cC", function()
      local previous = vim.g.compile_command
      vim.g.compile_command = ""
      vim.cmd("Compile")

      if vim.g.compile_command == "" then
        vim.g.compile_command = previous
      else
        save_active_command()
      end
    end, { desc = "Compile with a new command" })

    vim.keymap.set("n", "<leader>cr", "<cmd>Recompile<cr>", { desc = "Recompile" })
    vim.keymap.set("n", "<leader>cd", function()
      commands[active_directory] = nil
      vim.g.compile_command = nil
      write_commands()
      vim.notify("Forgot compile command for " .. active_directory)
    end, { desc = "Forget compile command" })
    vim.keymap.set("n", "]e", "<cmd>NextError<cr>", { desc = "Next error" })
    vim.keymap.set("n", "[e", "<cmd>PrevError<cr>", { desc = "Prev error" })
    vim.keymap.set("n", "<leader>cx", "<cmd>belowright split | terminal ./a.out <cr>", { desc = "Run program" })
  end
}

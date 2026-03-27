return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local Worktree = require("git-worktree")
    local harpoon = require("harpoon")

    local pending_copy = nil

    local function capture_changes()
      local modified = vim.fn.systemlist("git diff --name-only 2>/dev/null")
      local untracked = vim.fn.systemlist("git ls-files --others --exclude-standard 2>/dev/null")
      local all = {}
      for _, f in ipairs(modified) do
        if f ~= "" then
          all[f] = true
        end
      end
      for _, f in ipairs(untracked) do
        if f ~= "" and not all[f] then
          all[f] = true
        end
      end
      local result = {}
      for f, _ in pairs(all) do
        table.insert(result, f)
      end
      table.sort(result)
      return result
    end

    local function copy_file_to_worktree(file, source_path, dest_path)
      local source = source_path .. file
      local dest = dest_path .. file
      local dest_dir = vim.fn.fnamemodify(dest, ":h")

      if vim.fn.isdirectory(dest_dir) == 0 then
        vim.fn.mkdir(dest_dir, "p")
      end

      local cmd = string.format("cp %s %s", vim.fn.shellescape(source), vim.fn.shellescape(dest))
      local result = vim.fn.system(cmd)

      if vim.v.shell_error == 0 then
        print("Copied: " .. file)
      else
        vim.api.nvim_err_writeln("Failed: " .. file .. " - " .. result)
      end
    end

    local function capture_changes_from_path(worktree_path)
      local modified =
        vim.fn.systemlist("git -C " .. vim.fn.shellescape(worktree_path) .. " diff --name-only 2>/dev/null")
      local untracked = vim.fn.systemlist(
        "git -C " .. vim.fn.shellescape(worktree_path) .. " ls-files --others --exclude-standard 2>/dev/null"
      )
      local all = {}
      for _, f in ipairs(modified) do
        if f ~= "" then
          all[f] = true
        end
      end
      for _, f in ipairs(untracked) do
        if f ~= "" and not all[f] then
          all[f] = true
        end
      end
      local result = {}
      for f, _ in pairs(all) do
        table.insert(result, f)
      end
      table.sort(result)
      return result
    end

    local function show_copy_picker(source_path, source_branch, dest_path, dest_branch, files)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local key_hints =
        "<Enter>: copy selected  |  <Tab>: toggle  |  <Alt-a>: copy all  |  <Alt-s>: copy selected & stay"

      require("telescope.pickers")
        .new({}, {
          prompt_title = 'Copy from "' .. source_branch .. '" → "' .. dest_branch .. '"',
          results_title = key_hints,
          finder = require("telescope.finders").new_table({
            results = files,
            entry_maker = function(entry)
              return {
                value = entry,
                display = entry,
                ordinal = entry,
              }
            end,
          }),
          sorter = require("telescope.sorters").get_generic_fuzzy_sorter(),
          attach_mappings = function(prompt_bufnr, map)
            map("i", "<Enter>", function()
              local picker = action_state.get_current_picker(prompt_bufnr)
              local selections = picker:get_multi_selection()
              if #selections > 0 then
                for _, sel in ipairs(selections) do
                  copy_file_to_worktree(sel.value, source_path, dest_path)
                end
              end
              actions.close(prompt_bufnr)
            end)

            map("i", "<Tab>", function()
              actions.toggle_selection(prompt_bufnr)
            end)

            map("i", "<a-a>", function()
              for _, file in ipairs(files) do
                copy_file_to_worktree(file, source_path, dest_path)
              end
              actions.close(prompt_bufnr)
            end)

            map("i", "<a-s>", function()
              local picker = action_state.get_current_picker(prompt_bufnr)
              local selections = picker:get_multi_selection()
              if #selections > 0 then
                for _, sel in ipairs(selections) do
                  copy_file_to_worktree(sel.value, source_path, dest_path)
                end
              end
            end)

            return true
          end,
        })
        :find()
    end

    Worktree.on_tree_change(function(op, metadata)
      if op == Worktree.Operations.Switch then
        harpoon:list():clear()
        print("Switched to " .. metadata.path)
      elseif op == Worktree.Operations.Create and pending_copy then
        local dest_path = vim.fn.fnamemodify(metadata.path, ":p")
        vim.defer_fn(function()
          if #pending_copy.files > 0 then
            show_copy_picker(
              pending_copy.source_path,
              pending_copy.source_branch,
              dest_path,
              metadata.branch,
              pending_copy.files
            )
          else
            print("No changed files to copy")
          end
          pending_copy = nil
        end, 200)
      end
    end)

    vim.keymap.set("n", "<leader>gws", function()
      require("telescope").extensions.git_worktree.git_worktrees()
    end, { desc = "[G]it [W]orktree [S]witch" })

    vim.keymap.set("n", "<leader>gwc", function()
      local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
      pending_copy = {
        source_path = cwd,
        source_branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+", ""),
        files = capture_changes(),
      }
      if #pending_copy.files > 0 then
        print("Captured " .. #pending_copy.files .. " changed files")
      else
        print("No changed files")
      end
      require("telescope").extensions.git_worktree.create_git_worktree()
    end, { desc = "[G]it [W]orktree [C]reate" })

    vim.keymap.set("n", "<leader>gwd", function()
      require("telescope").extensions.git_worktree.git_worktrees()
    end, { desc = "[G]it [W]orktree [D]elete" })

    vim.keymap.set("n", "<leader>gfc", function()
      local current_path = vim.fn.fnamemodify(vim.fn.getcwd(), ":p")
      local current_branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+", "")

      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      local all_worktrees = {}
      local cmd = "git worktree list --porcelain 2>/dev/null"
      local output = vim.fn.system(cmd)
      for line in output:gmatch("[^\r\n]+") do
        if line:match("^worktree ") then
          local path = vim.fn.fnamemodify(line:gsub("^worktree ", "", 1), ":p")
          table.insert(all_worktrees, path)
        end
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Select source worktree",
          finder = require("telescope.finders").new_table({
            results = all_worktrees,
            entry_maker = function(entry)
              local branch = vim.fn
                .system("git -C " .. vim.fn.shellescape(entry) .. " branch --show-current 2>/dev/null")
                :gsub("%s+", "")
              local display = vim.fn.fnamemodify(entry, ":t")
              if entry == current_path then
                display = display .. " (current)"
              else
                display = display .. " [" .. branch .. "]"
              end
              return {
                value = entry,
                display = display,
                ordinal = entry,
              }
            end,
          }),
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              if selection then
                local source_path = selection.value
                local source_branch = vim.fn
                  .system("git -C " .. vim.fn.shellescape(source_path) .. " branch --show-current 2>/dev/null")
                  :gsub("%s+", "")

                if source_path == current_path then
                  vim.api.nvim_err_writeln("Cannot copy to same worktree")
                  actions.close(prompt_bufnr)
                  return
                end

                local files = capture_changes_from_path(source_path)

                if #files == 0 then
                  vim.api.nvim_err_writeln("No changed files in selected worktree")
                  actions.close(prompt_bufnr)
                  return
                end

                actions.close(prompt_bufnr)
                vim.defer_fn(function()
                  show_copy_picker(source_path, source_branch, current_path, current_branch, files)
                end, 50)
              end
            end)
            return true
          end,
        })
        :find()
    end, { desc = "[G]it [F]iles [C]opy from worktree" })
  end,
}

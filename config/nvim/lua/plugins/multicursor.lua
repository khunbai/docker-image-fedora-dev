return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    -- Add cursor at current position.
    vim.keymap.set({ "n", "v" }, "<c-o>", function()
      mc.addCursor("j")
      mc.deleteCursor()
      mc.disableCursors()
    end)

    -- Add and remove cursors with control + left click.
    vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

    -- Go to the first cursor and enable all cursors.
    vim.keymap.set({ "n", "v" }, "<c-i>", function()
      mc.firstCursor()
      mc.enableCursors()
    end)

    -- Use <c-q> to clear all cursors.
    vim.keymap.set({ "n", "v" }, "<c-q>", function() mc.clearCursors() end)

    -- Exit multicursor mode and go to normal mode.
    vim.keymap.set({ "n", "v" }, "<c-u>", function()
      if mc.cursorsEnabled() then
        -- Stop other cursors from moving.
        -- This allows you to reposition the main cursor.
        mc.disableCursors()
      else
        mc.addCursor()
      end
    end)

    -- Add a cursor and jump to the next word under cursor.
    -- Like <c-d> in VSCode.
    vim.keymap.set({ "n", "v" }, "<c-n>", function() mc.addCursor("*") end)

    -- Jump to the next word under cursor but do not add a cursor.
    vim.keymap.set({ "n", "v" }, "<c-m>", function() mc.skipCursor("*") end)

    -- Delete the nearest cursor.
    vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor)

    -- -- This doesn't work as expected with Lazyvim.
    -- vim.keymap.set("n", "<esc>", function()
    --   if not mc.cursorsEnabled() then
    --     mc.enableCursors()
    --   elseif mc.hasCursors() then
    --     mc.clearCursors()
    --   else
    --     -- Default <esc> handler.
    --   end
    -- end)

    -- -- Rotate the main cursor.
    -- vim.keymap.set({"n", "v"}, "<left>", mc.nextCursor)
    -- vim.keymap.set({"n", "v"}, "<right>", mc.prevCursor)

    -- -- Align cursor columns.
    -- vim.keymap.set("n", "<leader>a", mc.alignCursors)
    --
    -- -- Split visual selections by regex.
    -- vim.keymap.set("v", "S", mc.splitCursors)
    --
    -- -- Append/insert for each line of visual selections.
    -- vim.keymap.set("v", "I", mc.insertVisual)
    -- vim.keymap.set("v", "A", mc.appendVisual)
    --
    -- -- match new cursors within visual selections by regex.
    -- vim.keymap.set("v", "M", mc.matchCursors)
    --
    -- -- Rotate visual selection contents.
    -- vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end)
    -- vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end)

    -- Customize how cursors look.
    vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
    vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
  end,
}

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- -- Delete default keymaps
-- vim.keymap.del('i', '<C-[>'); -- To be used for copilot panel
-- vim.keymap.del('i', '<C-]>'); -- To be used for copilot panel

local map = LazyVim.safe_keymap_set;

map('n', 'U', '<C-r>', { desc = "Redo" });
map('x', "p", '"_dP', { desc = "Paste without yanking" });
map('n', 'gh', '_', { desc = "Go to first non-blank character of the line" });
map('v', 'gh', '_', { desc = "Go to first non-blank character of the line" });
map('n', 'gl', '$', { desc = "Go to end of line" });
map('v', 'gl', '$', { desc = "Go to end of line" });
map({ 'i', 'v' }, '<A-i>', '<Esc>', { desc = "Exit insert mode" });
map({ 'n', 'v' }, 'x', 'xi', { desc = "Delete a character and go to insert mode" });

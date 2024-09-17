-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- -- Delete default keymaps
-- vim.keymap.del('i', '<C-[>'); -- To be used for copilot panel
-- vim.keymap.del('i', '<C-]>'); -- To be used for copilot panel

local map = vim.keymap.set;
local del = vim.keymap.del;

map('n', 'U', '<C-r>', { desc = "Redo" });
map('x', "p", '"_dP', { desc = "Paste without yanking" });
map('n', 'gh', '_', { desc = "Go to first non-blank character of the line" });
map('v', 'gh', '_', { desc = "Go to first non-blank character of the line" });
map('n', 'gl', '$', { desc = "Go to end glf line" });
map('v', 'gl', '$', { desc = "Go to end of line" });
map({ 'n', 'v' }, 'gj', '<C-d>', { desc = "Scroll down" });
map({ 'n', 'v' }, 'gk', '<C-u>', { desc = "Scroll up" });
map({ 'i', 'v' }, '<A-i>', '<Esc>', { desc = "Exit insert mode" });
map({ 'n', 'v' }, 'x', 'xi', { desc = "Delete a character and go to insert mode" });
map('n', '<leader>qh', '<CMD>q!<CR>', { desc = "Quit current file without save." });
map('n', '<leader>qw', '<CMD>wq<CR>', { desc = "Save current file and quit." });

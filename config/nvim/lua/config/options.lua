-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here


vim.opt.scrolloff = 12  -- Lines of context when scrolling

vim.opt.colorcolumn = '80'  -- Vertical column line at 80 characters

vim.opt.iskeyword:append('-')  -- Treat dash separated words as a word text object
vim.opt.iskeyword:append('_')  -- Treat underscore separated words as a word text object
vim.opt.iskeyword:append('@')  -- Treat email addresses as a word text object
vim.opt.iskeyword:append('#')  -- Treat hashtags as a word text object
vim.opt.iskeyword:append('$')  -- Treat currency symbols as a word text object
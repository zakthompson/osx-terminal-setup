-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Create blank newlines and stay in normal mode
local map = vim.keymap.set

map("n", "zj", "o<Esc>")
map("n", "zk", "O<Esc>")

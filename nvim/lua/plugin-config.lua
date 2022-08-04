-- lualine
require('lualine').setup {
  extensions = { 'nvim-tree' },
  tabline = {
    lualine_a = { 'buffers' }
  }
}

-- nvim-tree
require('nvim-tree').setup()
vim.keymap.set('n', '<Space>ff', ':NvimTreeToggle<CR>')

-- nvim-tmux-navigation
require('nvim-tmux-navigation').setup {
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>"
  }
}

-- lsp-zero
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()
vim.diagnostic.config({
  virtual_text = true
})

-- Telescope
require('telescope').load_extension('fzf')
vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<CR>')

-- Fix colors
vim.opt.termguicolors = true

-- Set standard file encoding
vim.opt.encoding = 'utf-8'

-- No special per-file vim override configs
vim.opt.modeline = false

-- Highlight current line
vim.opt.cursorline = true

-- Faster hold-cursor times
vim.opt.updatetime = 100

-- Adjust system undo levels
vim.opt.undolevels = 100

-- Better search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Use system clipboard
vim.opt.clipboard = ''

-- Set tab width and convert tabs to spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Smart indents
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Number gutter
vim.opt.number = true

-- Use search highlighting
vim.opt.hlsearch = true

-- Space above/beside cursor from screen edges
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5

-- Mouse support only in normal mode
vim.opt.mouse = 'n'

-- Always include sign column (prevents shifting on diagnostics/git)
vim.opt.signcolumn = 'yes'

-- Set diagnostics to sort by severity
vim.diagnostic.config({
  severity_sort = true
})

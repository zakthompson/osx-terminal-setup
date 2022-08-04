local function map(mode, shortcut, command)
  vim.keymap.set(mode, shortcut, command, { silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function imap(shortcut, command)
  map('i', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- More logical up/down
nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

-- Resize panes with arrow keys
nmap('<Up>', ':resize -1<CR>')
nmap('<Down>', ':resize +1<CR>')
nmap('<Left>', ':vertical resize -1<CR>')
nmap('<Right>', ':vertical resize +1<CR>')

-- Disable arrow keys completely in Insert Mode
imap('<Up>', '<nop>')
imap('<Down>', '<nop>')
imap('<Left>', '<nop>')
imap('<Right>', '<nop>')

-- Double leader to switch to previous buffer
nmap('<Leader><Leader>', '<c-^>')

-- Use tab to naturally switch between buffers
nmap('<Tab>', ':bnext!<CR>')
nmap('<S-Tab>', ':bprev!<CR>')

-- Create blank newlines and stay in normal mode
nmap('zj', 'o<Esc>')
nmap('zk', 'O<Esc>')

-- Split navigation
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

-- Misc
nmap('<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

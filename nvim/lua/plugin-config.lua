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

-- tree-sitter
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'bash',
    'css',
    'dockerfile',
    'graphql',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'prisma',
    'python',
    'regex',
    'ruby',
    'rust',
    'scss',
    'sql',
    'tsx',
    'typescript',
    'vim',
    'yaml'
  },
  auto_install = true,
  endwise = {
    enable = true
  },
  autotag = {
    enable = true
  }
}


-- lsp-zero
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.on_attach(function(client, bufnr)
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { buffer = bufnr, remap = false })
end)
lsp.setup()
vim.diagnostic.config({
  virtual_text = true
})
vim.cmd [[autocmd BufWritePre * LspZeroFormat!]]

-- telescope
local telescope = require('telescope')
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

telescope.setup {
  pickers = {
    find_files = {
      theme = 'dropdown'
    },
    live_grep = {
      theme = 'dropdown'
    },
    buffers = {
      theme = 'dropdown'
    }
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown
    }
  }
}

vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<CR>')

-- nvim-autopairs
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup {
  check_ts = true
}

npairs.add_rules {
  Rule(' ', ' ')
      :with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
      end),
  Rule('( ', ' )')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%)') ~= nil
      end)
      :use_key(')'),
  Rule('{ ', ' }')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%}') ~= nil
      end)
      :use_key('}'),
  Rule('[ ', ' ]')
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%]') ~= nil
      end)
      :use_key(']')
}

-- nvim-surround
require('nvim-surround').setup()

-- gitsigns.nvim
require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text_pos = 'right_align',
    delay = 0
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    vim.keymap.set('n', '<Leader>gb', gs.toggle_current_line_blame, { buffer = bufnr })
    vim.keymap.set('n', '<Leader>gd', gs.diffthis, { buffer = bufnr })
  end
}
vim.cmd [[ highlight link GitSignsCurrentLineBlame Visual ]]

-- Comment.nvim
require('Comment').setup()

-- === lualine ===
require('lualine').setup {
  extensions = { 'nvim-tree' },
  tabline = {
    lualine_a = { 'buffers' }
  },
  sections = {
    lualine_y = { 'overseer' }
  }
}

-- === nvim-tree ===
require('nvim-tree').setup()
vim.keymap.set('n', '<Space>ff', ':NvimTreeToggle<CR>')

-- === nvim-tmux-navigation ===
require('nvim-tmux-navigation').setup {
  keybindings = {
    left = "<C-h>",
    down = "<C-j>",
    up = "<C-k>",
    right = "<C-l>"
  }
}

-- === tree-sitter ===
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

-- === lspsaga ===
local saga = require('lspsaga')
saga.init_lsp_saga {
  code_action_icon = '',
  code_action_lightbulb = {
    enable = true,
    sign = true,
    sign_priority = 110,
    enable_in_insert = false,
    virtual_text = false
  }
}
vim.keymap.set("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "<Leader>gp", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
vim.keymap.set("n", "<Leader>go", "<cmd>LSoutlineToggle<CR>", { silent = true })

-- Hover doc scrolling
local action = require("lspsaga.action")
vim.keymap.set("n", "<C-f>", function()
  action.smart_scroll_with_saga(1)
end, { silent = true })
vim.keymap.set("n", "<C-b>", function()
  action.smart_scroll_with_saga(-1)
end, { silent = true })

-- Float terminal
local term = require("lspsaga.floaterm")
vim.keymap.set("n", "<Leader>tt", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
vim.keymap.set("t", "<Leader>tt", "<C-\\><C-n><cmd>Lspsaga close_floaterm<CR>", { silent = true })

-- === lsp-zero ===
local lsp = require('lsp-zero')

-- Use recommended preset
lsp.preset('recommended')

-- Enable completion for nvim configs
lsp.nvim_workspace()

-- Can remap keys on_attach
lsp.on_attach(function(client, bufnr)
  -- Use Telescope for listing references
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { buffer = bufnr, remap = false })

  -- Use lspsaga for hoverdoc
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, remap = false })
end)

-- LSP config overrides
lsp.configure('cssls', {
  settings = {
    css = {
      validate = false
    },
    sass = {
      validate = false
    },
    scss = {
      validate = false
    },
    less = {
      validate = false
    }
  }
})
lsp.configure('stylelint_lsp', {
  filetypes = { 'css', 'sass', 'scss', 'less' }
})

-- Finally, run setup
lsp.setup()

-- === telescope ===
local telescope = require('telescope')
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
      require('telescope.themes').get_cursor()
    }
  }
}
telescope.load_extension('fzf')
telescope.load_extension('ui-select')

vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>fg', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>fb', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>fe', '<cmd>Telescope diagnostics<CR>')

-- === nvim-autopairs ===
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

-- Check tree-sitter to sometimes get smarter pairing
npairs.setup {
  check_ts = true
}

-- Enables space after start bracket, before end bracket
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

-- === nvim-surround ===
require('nvim-surround').setup()

-- === gitsigns.nvim ===
require('gitsigns').setup {
  signcolumn = false,
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text_pos = 'right_align',
    delay = 0
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    vim.keymap.set('n', '<Leader>gs', gs.toggle_signs, { buffer = bufnr })
    vim.keymap.set('n', '<Leader>gb', gs.toggle_current_line_blame, { buffer = bufnr })
    vim.keymap.set('n', '<Leader>gd', gs.diffthis, { buffer = bufnr })
  end
}
vim.cmd [[ highlight link GitSignsCurrentLineBlame Visual ]]

-- === Comment.nvim ===
require('Comment').setup()

-- === formatter.nvim ===
-- We use the same eslint_d, prettierd combo for most web dev
local tsFormatters = {
  require('formatter.filetypes.typescript').eslint_d,
  require('formatter.filetypes.typescript').prettierd
}

-- Use stylelint for css
local cssFormatters = {
  function()
    local util = require('formatter.util')

    return {
      exe = 'stylelint',
      args = {
        '--stdin',
        '--stdin-filename',
        util.escape_path(util.get_current_buffer_file_path()),
        '--fix'
      },
      stdin = true,
      ignore_exitcode = true,
      try_node_modules = true
    }
  end
}

require('formatter').setup {
  filetype = {
    javascript = tsFormatters,
    javascriptreact = tsFormatters,
    typescript = tsFormatters,
    typescriptreact = tsFormatters,
    css = cssFormatters,
    scss = cssFormatters,
    less = cssFormatters,
    ['*'] = {
      -- Clear trailing whitespace
      function()
        return { exe = 'sed', args = { '-i', "''", "'s/[	 ]*$//'" } }
      end,
    }
  }
}

-- On write, format, first with LSP, then with Formatter
local formatGroup = vim.api.nvim_create_augroup('FormatGroup', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*',
  group = formatGroup,
  command = 'FormatWrite'
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'FormatterPre',
  group = formatGroup,
  callback = vim.lsp.buf.formatting_sync
})

-- === overseer.vim ===
require('overseer').setup {
  task_list = {
    direction = 'right'
  }
}
vim.keymap.set('n', '<Leader>oo', '<cmd>OverseerToggle<CR>')
vim.keymap.set('n', '<Leader>or', '<cmd>OverseerRun<CR>')

-- === markdown-preview.nvim ===
vim.keymap.set('n', '<C-p>', '<cmd>MarkdownPreview<CR>')

-- === hop.nvim ===
require('hop').setup()
vim.api.nvim_set_keymap('', 'f',
  "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", {})
vim.api.nvim_set_keymap('', 'F',
  "<cmd>lua require'hop'.hint_char2({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})

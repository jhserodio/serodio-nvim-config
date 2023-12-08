-- EDITOR SETTINGS --

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.termguicolors = true
vim.opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.encoding='utf-8'

-- PLUGIN CONFIG --
local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can 'comment out' the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

---
-- List of plugins
---
lazy.setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth', 
 	
  -- visual plugins --
  {'ellisonleao/gruvbox.nvim', priority = 1000 , config = true},
  {'nvim-lualine/lualine.nvim'},

  -- File tree navigation and bars
  {'nvim-tree/nvim-tree.lua'},
  {'nvim-tree/nvim-web-devicons'},
  {'mrjones2014/smart-splits.nvim'},
  {'romgrk/barbar.nvim'},
  {'gitsigns'},

  -- Frontend shits --
  {'norcalli/nvim-colorizer.lua'},
  {'tpope/vim-surround'},
  {'windwp/nvim-autopairs'},

  --   Fuzzy Search --
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  { 'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  
  -- POPUP and UTILITIES --
  {'nvim-lua/plenary.nvim'},
  
  -- CONFING LSP AUTOCOMPLETE --
  {'neovim/nvim-lspconfig'},
  {'williamboman/mason.nvim'},
  {'williamboman/mason-lspconfig.nvim'},
  {'williamboman/nvim-lsp-installer'},
  {'tamago324/nlsp-settings.nvim'},
  {'rcarriga/nvim-notify'},
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/cmp-buffer'},
  {'hrsh7th/cmp-path'},
  {'hrsh7th/cmp-cmdline'},
  {'rafamadriz/friendly-snippets'},
  {'nvim-treesitter/nvim-treesitter'},
  {'JoosepAlviste/nvim-ts-context-commentstring'},
  {'mfussenegger/nvim-dap'},
  {'simrat39/rust-tools.nvim'},
  {'mfussenegger/nvim-dap'},
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  }

})

-- GRUVBOX ADITIONAL CONFIG --
require('gruvbox').setup({
  transparent_mode = true,
})

vim.cmd('colorscheme gruvbox')


-- LUALINE ADITIONAL CONFIG --
require('lualine').setup({
  options = {
    icons_enabled = true,
    section_separators = '',
    component_separators = '|>'
  }
})

-- FILE TREE CONFIG --
require('nvim-tree').setup()

-- CONFIG INDENT BLANK  --
local highlight = {
    'RainbowRed',
    'RainbowYellow',
    'RainbowBlue',
    'RainbowOrange',
    'RainbowGreen',
    'RainbowViolet',
    'RainbowCyan',
}

local hooks = require 'ibl.hooks'
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#fb4934' })
    vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#fadb2f' })
    vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#458588' })
    vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#fe8019' })
    vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#b8bb26' })
    vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#d3869b' })
    vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#83a598' })
end)

require('ibl').setup { indent = { highlight = highlight } }


-- FRONTEND SHIT CONFIG --
require 'colorizer'.setup({
  'css';
  'javascript';
  html = { mode = 'background' };
}, { mode = 'background' })


-- CONFIG TABS --
vim.g.barbar_auto_setup = false -- disable auto-setup

require 'barbar'.setup {
  icons = {
    button = '',
    gitsigns = {
      added = {enabled = true, icon = '+'},
      changed = {enabled = true, icon = '~'},
      deleted = {enabled = true, icon = '-'},
    },
    separator = {left = '|', right = ''},
    separator_at_end = true,
    modified = {button = '●'},
    pinned = {button = '', filename = true},
    preset = 'default',
    alternate = {filetype = {enabled = false}},
    current = {buffer_index = true},
    inactive = {button = '×'},
    visible = {modified = {buffer_number = false}},
  },
  insert_at_end = false,
  insert_at_start = false,
  maximum_padding = 1,
  minimum_padding = 1,
  sidebar_filetypes = {
    NvimTree = true,
  },
}

-- KEY BINDING --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')

-- telescope config --
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- nvim tree --
vim.keymap.set('n', '<leader>tt', '<cmd>:NvimTreeFocus<cr>', {})

-- smart split --
vim.keymap.set('n', '<C-Left>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-Down>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-Up>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-Right>', require('smart-splits').move_cursor_right)

-- tabs config --
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<C-[>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<C-]>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<CA-[>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<CA-]>', '<Cmd>BufferMoveNext<CR>', opts)


-- autocomplete and diagnostic --
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>fd', vim.lsp.buf.formatting, bufopts)
end

-- rust tools --
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  },
}

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})

local signs = { Error = "", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- LSP AUTOCOMPLETE CONFIG --
local lspconfig = require('lspconfig')
local util = require "lspconfig/util"

lspconfig.clojure_lsp.setup{}
lspconfig.tsserver.setup {}
lspconfig.astro.setup{}
lspconfig.biome.setup{}
lspconfig.astro.setup{}
lspconfig.cssls.setup{}
lspconfig.cssmodules_ls.setup{}
lspconfig.denols.setup{}
lspconfig.html.setup{}
lspconfig.svelte.setup{}

lspconfig.rust_analyzer.setup {
  settings = {
    ['rust-analyzer'] = {},
  },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = util.root_pattern("package.json"),
}

lspconfig.denols.setup {
  on_attach = on_attach,
  root_dir = util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.cssls.setup {
  capabilities = capabilities,
  capabilities = capabilities,
  root_dir = util.root_pattern("package.json"),
}

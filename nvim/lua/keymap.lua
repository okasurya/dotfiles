-- keymap.lua

-- List of existing key chains
require('which-key').add {
  { "<leader>c",  group = "[C]ode" },
  { "<leader>c_", hidden = true },
  { "<leader>d",  group = "[D]ocument" },
  { "<leader>d_", hidden = true },
  { "<leader>g",  group = "[G]it" },
  { "<leader>g_", hidden = true },
  { "<leader>i",  group = "Install plugin" },
  { "<leader>i_", hidden = true },
  { "<leader>l",  group = "LaTex" },
  { "<leader>l_", hidden = true },
  { "<leader>o",  group = "[O]verseer" },
  { "<leader>o_", hidden = true },
  { "<leader>q",  group = "Diagnostic" },
  { "<leader>q_", hidden = true },
  { "<leader>r",  group = "[R]ename" },
  { "<leader>r_", hidden = true },
  { "<leader>s",  group = "[S]earch" },
  { "<leader>s_", hidden = true },
  { "<leader>t",  group = "[T]est/Terminal" },
  { "<leader>t_", hidden = true },
  { "<leader>w",  group = "[W]orkspace" },
  { "<leader>w_", hidden = true },
}

-- register which-key VISUAL mode
require('which-key').add(
-- {
--   ['<leader>']  = { name = 'VISUAL <leader>' },
--   ['<leader>h'] = { 'Git [H]unk' },
-- },
-- { mode = 'v' }
  {
    { "<leader>",  group = "VISUAL <leader>", mode = "v" },
    { "<leader>h", desc = "Git [H]unk",       mode = "v" },
  }
)

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set('i', 'jk', '<Esc>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<eader>qe', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>ql', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ New Tab ]]
vim.keymap.set({ 'n', 'i', 'v' }, '<C-t>', '<ESC>:tabnew<cr>', { desc = 'New Tab' })

-- [[ Configure File tree ]]
require('nvim-tree').setup {
  require('which-key').add {
    { "<leader>e",  group = "File [E]xplorer" },
    { "<leader>e_", hidden = true },
    { "<leader>f",  group = "[F]ind File Explorer" },
    { "<leader>f_", hidden = true },
  },

  vim.keymap.set('n', '<leader>e', '<Esc>:NvimTreeToggle<cr>', { silent = true }),
  vim.keymap.set('n', '<leader>f', '<Esc>:NvimTreeFindFile<cr>', { silent = true }),

  filters = { custom = { "^.git$" } }, -- filter out git folder
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        folder = {
          arrow_closed = "+",
          arrow_open = "-",
        },
      },
    },
  },
  view = {
    number = true,
    relativenumber = true,
    adaptive_size = true,
  },
  update_focused_file = {
    enable = true,
  },

}

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,
    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- List of parsers to ignore installing
    ignore_install = {},
    -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>cs'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>cS'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', function()
    vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
  end, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>cd', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

-- telescope keymap
-- See `:help telescope.builtin`
local telbuiltin = require('telescope.builtin')
-- local telutils = require("telescope.utils")
local telactions = require("telescope.actions")

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-w>"] = telactions.send_selected_to_qflist + telactions.open_qflist,
      },
    },
    ripgrep_arguments = {
      'rg',
      '--hidden',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
  },
}

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    telbuiltin.live_grep {
      search_dirs = { git_root },
    }
  end
end

local function telescope_live_grep_open_files()
  telbuiltin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

local function telescope_fuzzy_current_buffer()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  telbuiltin.current_buffer_fuzzy_find(
    require('telescope.themes').get_dropdown {
      -- winblend = ,
      previewer = false,
    }
  )
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

vim.keymap.set('n', '<leader>?', telbuiltin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', telbuiltin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', telescope_fuzzy_current_buffer, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', telbuiltin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>st', telbuiltin.git_files, { desc = 'Search Git Files' })
vim.keymap.set('n', '<leader>sf', telbuiltin.find_files, { desc = '[S]earch [F]les' })
vim.keymap.set('n', '<leader>sh', telbuiltin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', telbuiltin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', telbuiltin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', telbuiltin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', telbuiltin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>gg', ':GBrowse<cr>', { desc = 'Go to git repo on browser' })

vim.keymap.set('n', '<leader>im', ':Mason<cr>', { desc = 'Open Mason prompt' })
vim.keymap.set('n', '<leader>il', ':Lazy<cr>', { desc = 'Open Lazy prompt' })

vim.keymap.set('n', '<leader>lv', ':VimtexView<cr>', { desc = 'View' })
vim.keymap.set('n', '<leader>lc', ':VimtexCompile<cr>', { desc = 'Compile' })

require('diffview').setup()
vim.keymap.set('n', '<leader>gv', ':DiffviewOpen<cr>', { desc = 'Git diff view' })
vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory %<cr>', { desc = 'File history' })
vim.keymap.set('n', '<leader>gH', ':DiffviewFileHistory<cr>', { desc = 'Branch history' })
vim.keymap.set('n', '<leader>gc', ':DiffviewClose<cr>', { desc = 'Close diffview' })

vim.keymap.set('n', 'leader>tf', ':ToggleTerm direction=float<cr>', { desc = 'Float terminal' })
vim.keymap.set('n', '<leader>th', ':ToggleTerm direction=horizontal<cr>', { desc = 'Horizontal terminal' })
vim.keymap.set('n', '<leader>tv', ':ToggleTerm direction=vertical<cr>', { desc = 'Vertical terminal' })


require('telescope').load_extension('projects')
vim.keymap.set('n', '<leader>sp', ':Telescope projects<cr>', { desc = 'Search projects' })

require('overseer').setup()
vim.keymap.set('n', '<leader>or', ':OverseerRun<cr>', { desc = 'Run task' })
vim.keymap.set('n', '<leader>ot', ':OverseerToggle<cr>', { desc = 'Toggle tasks' })

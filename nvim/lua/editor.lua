-- editor.lua

-- OS specific setting
local openFn = 'xdg-open'
local clipboard = 'unnamedplus'

-- Mac OS specific settings
if vim.loop.os_uname().sysname == 'Darwin' then
  openFn = 'open'
  clipboard = 'unnamed,unnamedplus'
end

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = clipboard


-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.number = true         -- Enable line numbers
vim.o.relativenumber = true -- Enable relative line numbers

vim.o.cursorline = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smarttab = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- open browser
vim.api.nvim_create_user_command(
  'Browse',
  function(opts)
    vim.fn.system { openFn, opts.fargs[1] }
  end,
  { nargs = 1 }
)

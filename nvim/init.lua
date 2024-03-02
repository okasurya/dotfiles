-- init.lua

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazyload')
require('style')
require('editor')
require('keymap')

-- require('plugins.init')

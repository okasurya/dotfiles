return {
  {
    'vim-test/vim-test',
    config = function()
      vim.g['test#strategy'] = 'neovim'
      vim.keymap.set('n', '<leader>tn', ':TestNearest<cr>', { desc = 'Test nearest' })
      vim.keymap.set('n', '<leader>tf', ':TestFile<cr>', { desc = 'Test file' })
      vim.keymap.set('n', '<leader>ts', ':TestSuite<cr>', { desc = 'Test suite' })
      vim.keymap.set('n', '<leader>tl', ':TestLast<cr>', { desc = 'Test last' })
      vim.keymap.set('n', '<leader>tg', ':TestVisit<cr>', { desc = 'Test visit' })
    end,
  },
  {
    'tpope/vim-rails',
  },
}

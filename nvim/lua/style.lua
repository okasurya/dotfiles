-- style.lua

vim.cmd('highlight DiffAdd guifg=#3a3b3c guibg=#bada9f')
vim.cmd('highlight DiffChange guifg=#3a3b3c guibg=#e5d5ac')
vim.cmd('highlight DiffDelete guifg=#ff8080 guibg=#ffb0b0 gui=bold')
vim.cmd('highlight DiffText guifg=#3a3b3c guibg=#8cbee2')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

return {
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
        detection_methods = { 'pattern', 'lsp' },
        patterns = { '.git', 'Makefile', 'package.json', 'go.mod' },
      }
    end,
  },
  {
    'stevearc/overseer.nvim',
    config = function()
    end,
  },
}

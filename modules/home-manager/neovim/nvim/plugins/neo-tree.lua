require("neo-tree").setup({
  filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
	  ["/"] = "noop",
        },
      },
    },
})
vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal'})


vim.keymap.set('n', '<leader>gb', '<Cmd>Git blame<CR>', { desc = "Git Blame" })
vim.keymap.set('n', '<leader>gd', '<Cmd>Gdiffsplit<CR>', { desc = "Git Diff Split" })
vim.keymap.set('n', '<leader>gc', '<Cmd>Git commit<CR>', { desc = "Git Commit" })
vim.keymap.set('n', '<leader>gs', '<Cmd>tab Git<CR>', { desc = "Git Status Tab" })

require("which-key").add({
  { "<leader>g", group = "Git" },
  { "<leader>gb", "<Cmd>Git blame<CR>", desc = "Git Blame" },
  { "<leader>gd", "<Cmd>Gdiffsplit<CR>", desc = "Git Diff Split" },
  { "<leader>gc", "<Cmd>Git commit<CR>", desc = "Git Commit" },
  { "<leader>gs", "<Cmd>tab Git<CR>", desc = "Git Status (Tab)" },
}, { prefix = "<leader>" })

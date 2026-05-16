
vim.keymap.set("n", "<leader>gl", ":GetBlobLink<CR>", { desc = "Copy GitHub link to file" })
vim.keymap.set("n", "<leader>gc", ":GetCommitLink<CR>", { desc = "Copy GitHub link to commit" })
vim.keymap.set("n", "<leader>gr", ":GetRepoLink<CR>", { desc = "Copy GitHub link to repo" })

require("which-key").add({
  { "<leader>g", group = "GitHub" },
  { "<leader>gc", ":GetCommitLink<CR>", desc = "Link to commit" },
  { "<leader>gl", ":GetBlobLink<CR>", desc = "Link to file" },
  { "<leader>gr", ":GetRepoLink<CR>", desc = "Link to repo" },
  
}, { prefix = "<leader>" })


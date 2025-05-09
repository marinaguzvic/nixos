
vim.keymap.set("n", "<leader>gl", ":GetBlobLink<CR>", { desc = "Copy GitHub link to file" })
vim.keymap.set("n", "<leader>gc", ":GetCommitLink<CR>", { desc = "Copy GitHub link to commit" })
vim.keymap.set("n", "<leader>gr", ":GetRepoLink<CR>", { desc = "Copy GitHub link to repo" })

require("which-key").register({
  g = {
    name = "GitHub",
    l = { ":GetBlobLink<CR>", "Link to file" },
    c = { ":GetCommitLink<CR>", "Link to commit" },
    r = { ":GetRepoLink<CR>", "Link to repo" },
  },
}, { prefix = "<leader>" })


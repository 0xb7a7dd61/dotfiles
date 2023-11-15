vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    callback = function()
        if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
            vim.api.nvim_command("silent update")
        end
    end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.tmux.conf", "*.tmux.local.conf" },
    callback = function()
        local filepath = vim.fn.expand("%")

        vim.api.nvim_command("!tmux source-file %")
        vim.notify("Configuration reloaded \n" .. filepath, nil)
    end,
    desc = "Reload tmux config on save",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "json", "jsonc", "markdown" },
    callback = function()
        vim.wo.conceallevel = 0
    end,
})

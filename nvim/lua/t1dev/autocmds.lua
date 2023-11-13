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

-- autocmd bufwritepost .tmux.conf execute ':!tmux source-file %'
-- autocmd bufwritepost .tmux.local.conf execute ':!tmux source-file %'

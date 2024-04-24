return {
    "stevearc/conform.nvim",
    ops = function(_, opts)
        vim.tbl_extend("force", opts.formatters_by_ft or {}, {
            formatters_by_ft = {
                typescript = {},
                javascript = {},
            },
        })
    end,
}

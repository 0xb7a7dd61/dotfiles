return {
    {
        "folke/which-key.nvim",
        opts = {
            defaults = {
                -- add helpful names to the command tree. without this they show as "+prefix"
                ["<leader>r"] = { name = "+regex" },
            },
        },
    },
}

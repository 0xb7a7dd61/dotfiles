return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = function(_, opts)
            opts.transparent_background = true
        end,
    },
    {
        "rcarriga/nvim-notify",
        opts = function(_, opts)
            opts.background_colour = "#000000"
        end,
    },
}

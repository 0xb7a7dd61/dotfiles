return {
    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            opts.extensions = {
                project = {
                    -- detect and inject projects from these dev directories
                    base_dirs = {
                        "~/development/personal",
                        "~/development/treasure",
                        "~/development/hytopia",
                    },
                },
            }
        end,
    },
    -- project management. telescope-project allows us to hook the project selection to manage sessions
    {
        "nvim-telescope/telescope-project.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = {},
        event = "BufWinEnter",
        config = function()
            require("telescope").load_extension("project")
        end,
        keys = {
            {
                "<leader>fp",
                ":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>",
                desc = "Projects",
            },
        },
    },
    -- add the project extension to dashboard
    {
        -- "goolord/alpha-nvim",
        "nvimdev/dashboard-nvim",
        optional = true,
        opts = function(_, opts)
            local projects = {
                action = [[lua require("telescope").extensions.project.project({ display_type = 'full' })]],
                desc = " Projects",
                icon = " ",
                key = "p",
                key_format = "  %s",
            }
            table.insert(opts.config.center, 3, projects)
        end,
    },
}

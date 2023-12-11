return {
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    },
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

            local ts_select_dir_for_grep = function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local fb = require("telescope").extensions.file_browser
                local live_grep = require("telescope.builtin").live_grep
                local current_line = action_state.get_current_line()

                fb.file_browser({
                    files = false,
                    depth = false,
                    attach_mappings = function(prompt_bufnr2)
                        require("telescope.actions").select_default:replace(function()
                            local entry_path = action_state.get_selected_entry().Path
                            local dir = entry_path:is_dir() and entry_path or entry_path:parent()
                            local relative = dir:make_relative(vim.fn.getcwd())
                            local absolute = dir:absolute()

                            live_grep({
                                results_title = relative .. "/",
                                cwd = absolute,
                                default_text = current_line,
                            })
                        end)

                        return true
                    end,
                })
            end

            opts.pickers = vim.tbl_extend("force", opts.pickers or {}, {
                live_grep = {
                    mappings = {
                        i = {
                            ["<C-l>"] = ts_select_dir_for_grep,
                        },
                        n = {
                            ["<C-l>"] = ts_select_dir_for_grep,
                        },
                    },
                },
            })
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

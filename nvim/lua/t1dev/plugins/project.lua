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
                    -- when selecting a project, inject their last session instead of picking a file.
                    -- if there is no last session, open telescope file picker
                    -- on_project_selected = function(prompt_bufnr)
                    --     local telescope_project_actions = require("telescope._extensions.project.actions")
                    --
                    --     -- cache info before changing cwd
                    --     local old_cwd = vim.fn.getcwd()
                    --
                    --     -- change cwd to the picked project and close the picker
                    --     telescope_project_actions.change_working_directory(prompt_bufnr, false)
                    --     local new_cwd = vim.fn.getcwd()
                    --
                    --     xpcall(function()
                    --         if old_cwd ~= new_cwd then
                    --             -- if we changed project working directories, save the old session
                    --             local old_session = require("session_manager.config").dir_to_session_filename(old_cwd)
                    --             require("session_manager.utils").save_session(old_session.filename)
                    --         end
                    --     end, function(err)
                    --         vim.notify(debug.traceback(err), vim.log.levels.ERROR)
                    --     end)
                    --
                    --     local new_session = require("session_manager.config").dir_to_session_filename(new_cwd)
                    --     if new_session:exists() then
                    --         xpcall(function()
                    --             -- load new cwd session if it exists
                    --             require("session_manager").load_current_dir_session(true) -- will force delete unsaved, get rektd
                    --         end, function(err)
                    --             vim.notify(debug.traceback(err), vim.log.levels.ERROR)
                    --         end)
                    --     else
                    --         -- since we changed project working directories, the picker was closed and
                    --         --  we only need to open telescope file picker
                    --         vim.schedule(function()
                    --             require("telescope.builtin").find_files({ cwd = new_cwd, hidden = false })
                    --         end)
                    --     end
                    -- end,mapping
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
        -- opts = function(_, opts)
        --     local button = opts.button(
        --         "p",
        --         " " .. " Projects",
        --         ":lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>"
        --     )
        --     button.opts.hl = "AlphaButtons"
        --     button.opts.hl_shortcut = "AlphaShortcut"
        --     table.insert(opts.section.buttons.val, 4, button)
        -- end,
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

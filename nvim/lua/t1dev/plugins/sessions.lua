return {
    { "folke/persistence.nvim", enabled = false },
    {
        "Shatur/neovim-session-manager",
        enabled = false,
        event = "BufReadPre",
        opts = function()
            local config = require("session_manager.config")
            return {
                autoload_mode = config.AutoloadMode.Disabled,
            }
        end,
        keys = {
            {
                "<leader>qs",
                function()
                    require("session_manager").load_current_dir_session()
                end,
                desc = "Load CWD Session",
            },
            {
                "<leader>ql",
                function()
                    require("session_manager").load_last_session()
                end,
                desc = "Load Last Used Session",
            },
            {
                "<leader>qp",
                function()
                    require("session_manager").load_session()
                end,
                desc = "Load Session (Picker)",
            },
            {
                "<leader>qS",
                function()
                    require("session_manager").save_current_session()
                end,
                desc = "Save CWD Session",
            },
            {
                "<leader>qd",
                function()
                    require("session_manager").delete_session()
                end,
                desc = "Delete Session (Picker)",
            },
        },
    },
}

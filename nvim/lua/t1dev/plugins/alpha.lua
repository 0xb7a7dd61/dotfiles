return {
    -- { "nvimdev/dashboard-nvim", enabled = false },
    {
        -- "goolord/alpha-nvim",
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        enabled = true,
        --         opts = function()
        --             local dashboard = require("alpha.themes.dashboard")
        --             local logo = [[
        -- ▄▄▄█████▓ ██▒▓█████▄ ▓█████  ██▒   █▓
        -- ▓  ██▒ ▓▒███▒▒██▀ ██▌▓█   ▀ ▓██░   █▒
        -- ▒ ▓██░ ▒▓░▓█▒░██   █▌▒███    ▓██  █▒░
        -- ░ ▓██▓ ░ ░▓█░░▓█▄   ▌▒▓█  ▄   ▒██ █░░
        --   ▒██▒ ░ ▓██▓░▒████▓ ░▒████▒   ▒▀█░
        --   ▒ ░░   ░▓   ▒▒▓  ▒ ░░ ▒░ ░   ░ ▐░
        --     ░     ▒ ░ ░ ▒  ▒  ░ ░  ░   ░ ░░
        --   ░       ▒ ░ ░ ░  ░    ░        ░░
        --           ░     ░       ░  ░      ░
        --               ░                  ░
        --             ]]
        --
        --             dashboard.section.header.val = vim.split(logo, "\n")
        --             dashboard.section.buttons.val = {
        --                 dashboard.button("f", " " .. " Find file", "<cmd> Telescope find_files <cr>"),
        --                 dashboard.button("n", " " .. " New file", "<cmd> ene <BAR> startinsert <cr>"),
        --                 dashboard.button("r", " " .. " Recent files", "<cmd> Telescope oldfiles <cr>"),
        --                 dashboard.button("g", " " .. " Find text", "<cmd> Telescope live_grep <cr>"),
        --                 dashboard.button("c", " " .. " Config", "<cmd> e $MYVIMRC <cr>"),
        --                 -- dashboard.button(
        --                 --     "s",
        --                 --     " " .. " Restore Last Session",
        --                 --     [[<cmd> lua require("session_manager").load_last_session()<cr>]]
        --                 -- ),
        --                 -- dashboard.button(
        --                 --     "S",
        --                 --     " " .. " Restore CWD Session",
        --                 --     [[<cmd> lua require("session_manager").load_current_dir_session()<cr>]]
        --                 -- ),
        --                 dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
        --                 dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
        --             }
        --             for _, button in ipairs(dashboard.section.buttons.val) do
        --                 button.opts.hl = "AlphaButtons"
        --                 button.opts.hl_shortcut = "AlphaShortcut"
        --             end
        --             dashboard.section.header.opts.hl = "AlphaHeader"
        --             dashboard.section.buttons.opts.hl = "AlphaButtons"
        --             dashboard.section.footer.opts.hl = "AlphaFooter"
        --             dashboard.opts.layout[1].val = 8
        --             return dashboard
        --         end,
        opts = function()
            local logo = [[
▄▄▄█████▓ ██▒▓█████▄ ▓█████  ██▒   █▓
▓  ██▒ ▓▒███▒▒██▀ ██▌▓█   ▀ ▓██░   █▒
▒ ▓██░ ▒▓░▓█▒░██   █▌▒███    ▓██  █▒░
░ ▓██▓ ░ ░▓█░░▓█▄   ▌▒▓█  ▄   ▒██ █░░
  ▒██▒ ░ ▓██▓░▒████▓ ░▒████▒   ▒▀█░  
  ▒ ░░   ░▓   ▒▒▓  ▒ ░░ ▒░ ░   ░ ▐░  
    ░     ▒ ░ ░ ▒  ▒  ░ ░  ░   ░ ░░  
  ░       ▒ ░ ░ ░  ░    ░        ░░  
          ░     ░       ░  ░      ░  
              ░                  ░   
            ]]
            logo = string.rep("\n", 8) .. logo .. "\n\n"

            local opts = {
                theme = "doom",
                hide = {
                    -- this is taken care of by lualine
                    -- enabling this messes up the actual laststatus setting after loading a file
                    statusline = false,
                },
                config = {
                    header = vim.split(logo, "\n"),
                    -- stylua: ignore
                    center = {
                      { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
                      { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
                      { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
                      { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
                      { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
                      { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
                      { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
                    },
                    footer = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                        return {
                            "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
                        }
                    end,
                },
            }

            for _, button in ipairs(opts.config.center) do
                button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
                button.key_format = "  %s"
            end

            -- close Lazy and re-open when the dashboard is ready
            if vim.o.filetype == "lazy" then
                vim.cmd.close()
                vim.api.nvim_create_autocmd("User", {
                    pattern = "DashboardLoaded",
                    callback = function()
                        require("lazy").show()
                    end,
                })
            end

            return opts
        end,
    },
}

return {
    -- copilot set up for ghost text only
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = false, -- set in cmp mapping for <Tab>
                    accept_line = "<M-Down>",
                    accept_word = "<M-Right>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<M-Space>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
            copilot_node_command = "node",
            server_opts_overrides = {},
        },
    },
    -- Disable tab and s-tab in lua snip to use for copilot
    {
        "L3MON4D3/LuaSnip",
        keys = function()
            return {}
        end,
    },
    -- show copilot status in lualine
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        event = "VeryLazy",
        opts = function(_, opts)
            local Util = require("lazyvim.util")
            local colors = {
                [""] = Util.ui.fg("Special"),
                ["Normal"] = Util.ui.fg("Special"),
                ["Warning"] = Util.ui.fg("DiagnosticError"),
                ["InProgress"] = Util.ui.fg("DiagnosticWarn"),
            }
            table.insert(opts.sections.lualine_x, 2, {
                function()
                    local icon = require("lazyvim.config").icons.kinds.Copilot
                    local status = require("copilot.api").status.data
                    return icon .. (status.message or "")
                end,
                cond = function()
                    local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
                    return ok and #clients > 0
                end,
                color = function()
                    if not package.loaded["copilot"] then
                        return
                    end
                    local status = require("copilot.api").status.data
                    return colors[status.status] or colors[""]
                end,
            })
        end,
    },
    -- add copilot to cmp source
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            local cmp = require("cmp")
            local luasnip = require("luasnip")

            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                -- hook for copilot accept mapping to <Tab>, luasnip to <Tab> or default <Tab> behavior
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if require("copilot.suggestion").is_visible() then
                        require("copilot.suggestion").accept()
                        cmp.close() -- close cmp menu. Without this, the menu will try to suggest word completion
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                -- hook for luasnip to use S-Tab or default S-Tab behavior
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })
        end,
    },
}

return {
    "neovim/nvim-lspconfig",
    lazy = false,
    opts = function(_, opts)
        opts.servers = vim.tbl_extend("force", opts.servers, {
            -- For solidity files, use nomicfoundation's language server with
            --  forge formatting defined in the project's detected git repo
            solidity = {
                root_dir = require("lspconfig.util").find_git_ancestor,
                cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
                filetypes = { "solidity" },
                single_file_support = true,
                init_options = {
                    extensionConfig = {
                        formatter = "forge",
                    },
                },
                autostart = true,
            },
        })
        opts.setup = vim.tbl_extend("force", opts.setup, {
            eslint = function()
                require("lazyvim.util").lsp.on_attach(function(client)
                    if client.name == "eslint" then
                        client.server_capabilities.documentFormattingProvider = true
                    elseif client.name == "tsserver" then
                        client.server_capabilities.documentFormattingProvider = false
                    end
                end)
            end,
        })
    end,
}

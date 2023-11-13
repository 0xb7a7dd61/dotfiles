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
    end,
}

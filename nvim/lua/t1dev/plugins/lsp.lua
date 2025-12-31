return {
  "neovim/nvim-lspconfig",
  lazy = false,
  opts = function(_, opts)
    opts.servers = vim.tbl_extend("force", opts.servers, {
      -- For solidity files, use nomicfoundation's language server with
      --  forge formatting defined in the project's detected git repo
      solidity = {
        root_dir = vim.fs.dirname(vim.fs.find(".git", { upward = true })[1]),
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
      move_analyzer = {
        cmd = { "aptos-move-analyzer" },
        filetypes = { "move" },
        root_dir = require("lspconfig.util").root_pattern("Move.toml", ".git"),
        autostart = true,
      },
    })
    opts.setup = vim.tbl_extend("force", opts.setup, {
      eslint = function()
        Snacks.util.lsp.on({ name = "eslint" }, function(buffer, client)
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

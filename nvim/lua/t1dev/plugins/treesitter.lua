return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "move",
        "solidity", -- important for filetypes detection
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      indent = { enable = true },
      highlight = { enable = true },
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable = true,
      enable_autocmd = false,
      config = {
        -- enables gcc for solidity
        solidity = { __default = "// %s", __multiline = "/* %s */" },
      },
    },
  },
}

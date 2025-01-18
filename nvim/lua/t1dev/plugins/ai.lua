-- return {
--   {
--     "olimorris/codecompanion.nvim",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-treesitter/nvim-treesitter",
--     },
--     config = true,
--   },
-- }
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- Optional dependencies for enhanced functionality
      "nvim-tree/nvim-web-devicons", -- For file icons
      {
        "HakonHarnes/img-clip.nvim", -- Support for image pasting
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true, -- Required for Windows users
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim", -- For prettier markdown rendering
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      provider = "claude", -- Default provider
      claude = {
        -- Defaults:
        -- endpoint = "https://api.anthropic.com",
        -- model = "claude-3-5-sonnet-20241022",
        -- temperature = 0,
        -- max_tokens = 4096,
      },
      file_selector = {
        provider = "fzf",
        -- Options override for custom providers
        provider_opts = {},
      },
      hints = { enabled = false },
    },
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "Avante" })
    end,
    opts = function(_, opts)
      opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
}

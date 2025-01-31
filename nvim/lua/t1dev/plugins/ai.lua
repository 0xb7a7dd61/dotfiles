return {
  {
    "olimorris/codecompanion.nvim",
    -- dependencies = {
    --   "nvim-lua/plenary.nvim",
    --   "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle chat" },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = { "n", "v" }, desc = "Add selected text to chat buffer" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Open action palette" },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:op read op://Employee/Anthropic/credential --no-newline",
              },
            })
          end,
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "o1-mini-2024-09-12",
                },
                max_tokens = {
                  default = 8192,
                },
              },
            })
          end,
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:op read op://personal/OpenAI/credential --no-newline",
              },
              schema = {
                model = {
                  default = function()
                    return "o1-preview"
                  end,
                },
              },
            })
          end,
        },
        prompt_library = {
          ["Test workflow"] = {
            strategy = "workflow",
            description = "Use a workflow to test the plugin",
            opts = {
              index = 4,
            },
            prompts = {
              {
                {
                  role = "user",
                  content = "Generate a Python class for managing a book library with methods for adding, removing, and searching books",
                  opts = {
                    auto_submit = false,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Write unit tests for the library class you just created",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Create a TypeScript interface for a complex e-commerce shopping cart system",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Write a recursive algorithm to balance a binary search tree in Java",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Generate a comprehensive regex pattern to validate email addresses with explanations",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Create a Rust struct and implementation for a thread-safe message queue",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Write a GitHub Actions workflow file for CI/CD with multiple stages",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Create SQL queries for a complex database schema with joins across 4 tables",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Write a Lua configuration for Neovim with custom keybindings and plugins",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
              {
                {
                  role = "user",
                  content = "Generate documentation in JSDoc format for a complex JavaScript API client",
                  opts = {
                    auto_submit = true,
                  },
                },
              },
            },
          },
        },
        strategies = {
          chat = {
            keymaps = {
              send = {
                modes = {
                  i = { "<C-CR>", "<C-s>" },
                },
              },
              completion = {
                modes = {
                  i = "<C-x>",
                },
              },
            },
            roles = { llm = "CodeCompanion", user = "olimorris" },
            slash_commands = {
              ["buffer"] = {
                opts = {
                  provider = "telescope",
                },
              },
              ["help"] = {
                opts = {
                  provider = "telescope",
                  max_lines = 1000,
                },
              },
              ["file"] = {
                opts = {
                  provider = "telescope",
                },
              },
              ["symbols"] = {
                opts = {
                  provider = "telescope",
                },
              },
            },
          },
          inline = { adapter = "copilot" },
        },
        display = {
          action_palette = {
            provider = "default",
          },
          chat = {
            -- show_references = true,
            -- show_header_separator = false,
            -- show_settings = false,
          },
          diff = {
            provider = "mini_diff",
          },
        },
        opts = {
          log_level = "DEBUG",
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim", -- Make Markdown buffers look beautiful
    ft = function(_, ft)
      vim.list_extend(ft, { "markdown", "codecompanion" })
    end,
    opts = {
      render_modes = true, -- Render in ALL modes
      sign = {
        enabled = false, -- Turn off in the status column
      },
    },
  },
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
          accept = "<M-Down>",
          accept_line = "<M-Right>",
          accept_word = "<M-Up>",
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
}
-- return {
--   {
--     "yetone/avante.nvim",
--     event = "VeryLazy",
--     dependencies = {
--       "nvim-treesitter/nvim-treesitter",
--       "nvim-lua/plenary.nvim",
--       "MunifTanjim/nui.nvim",
--       -- Optional dependencies for enhanced functionality
--       "nvim-tree/nvim-web-devicons", -- For file icons
--       {
--         "HakonHarnes/img-clip.nvim", -- Support for image pasting
--         event = "VeryLazy",
--         opts = {
--           default = {
--             embed_image_as_base64 = false,
--             prompt_for_file_name = false,
--             drag_and_drop = { insert_mode = true },
--             use_absolute_path = true, -- Required for Windows users
--           },
--         },
--       },
--       {
--         "MeanderingProgrammer/render-markdown.nvim", -- For prettier markdown rendering
--         opts = { file_types = { "markdown", "Avante" } },
--         ft = { "markdown", "Avante" },
--       },
--     },
--     opts = {
--       provider = "claude", -- Default provider
--       claude = {
--         -- Defaults:
--         -- endpoint = "https://api.anthropic.com",
--         -- model = "claude-3-5-sonnet-20241022",
--         -- temperature = 0,
--         -- max_tokens = 4096,
--       },
--       file_selector = {
--         provider = "fzf",
--         -- Options override for custom providers
--         provider_opts = {},
--       },
--       hints = { enabled = false },
--     },
--     build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
--   },
--   {
--     "MeanderingProgrammer/render-markdown.nvim",
--     optional = true,
--     ft = function(_, ft)
--       vim.list_extend(ft, { "Avante" })
--     end,
--     opts = function(_, opts)
--       opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
--     end,
--   },
-- }

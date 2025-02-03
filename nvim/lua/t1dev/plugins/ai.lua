return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "echasnovski/mini.diff", opts = {} },
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle chat" },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", mode = { "n", "v" }, desc = "Add selected text to chat buffer" },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Open action palette" },
      { "<leader>ai", "<cmd>'<,'>CodeCompanion<cr>", mode = { "n", "v" }, desc = "Run inline ai suggestions" },
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
                  default = "o3-mini-2025-01-31",
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
              -- schema = {
              --   model = {
              --     default = function()
              --       return "o1-preview"
              --     end,
              --   },
              -- },
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
          ["Solidity Development"] = {
            strategy = "workflow",
            description = "Smart contract development and security workflow",
            opts = { index = 1 },
            prompts = {
              {
                {
                  role = "user",
                  content = "Review this smart contract for common security vulnerabilities and suggest improvements",
                  opts = { auto_submit = true },
                },
              },
              {
                {
                  role = "user",
                  content = "Generate unit tests for this smart contract using Hardhat and Chai",
                  opts = { auto_submit = true },
                },
              },
              {
                {
                  role = "user",
                  content = "Create a gas-optimized version of this smart contract",
                  opts = { auto_submit = true },
                },
              },
              {
                {
                  role = "user",
                  content = "Generate events and error handling for this smart contract following best practices",
                  opts = { auto_submit = true },
                },
              },
            },
          },
          ["AWS CDK Patterns"] = {
            strategy = "workflow",
            description = "AWS Infrastructure as Code patterns using CDK",
            opts = { index = 1 },
            prompts = {
              {
                {
                  role = "user",
                  content = "Create a CDK stack for a serverless API with Lambda, API Gateway, and DynamoDB",
                  opts = { auto_submit = true },
                },
              },
              {
                {
                  role = "user",
                  content = "Add VPC configuration and security groups to this CDK stack",
                  opts = { auto_submit = true },
                },
              },
              {
                {
                  role = "user",
                  content = "Implement CloudWatch alarms and metrics for this infrastructure",
                  opts = { auto_submit = true },
                },
              },
              {
                {
                  role = "user",
                  content = "Generate IAM roles and policies following least privilege principle",
                  opts = { auto_submit = true },
                },
              },
              {
                {
                  role = "user",
                  content = "Add tags and cost allocation strategies to these resources",
                  opts = { auto_submit = true },
                },
              },
            },
          },
        },
        strategies = {
          chat = {
            adapter = "anthropic",
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
                  provider = "fzf_lua",
                },
              },
              ["help"] = {
                opts = {
                  provider = "fzf_lua",
                  max_lines = 1000,
                },
              },
              ["file"] = {
                opts = {
                  provider = "fzf_lua",
                },
              },
              ["symbols"] = {
                opts = {
                  provider = "fzf_lua",
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
    "echasnovski/mini.diff", -- Inline and better diff over the default
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
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
      copilot_node_command = "node",
      server_opts_overrides = {},
    },
  },
  -- Add statusline at the bottom for a spinner when code companion is processing a chat question
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      local M = require("lualine.component"):extend()

      M.processing = false
      M.spinner_index = 1

      local spinner_symbols = {
        "⠋",
        "⠙",
        "⠹",
        "⠸",
        "⠼",
        "⠴",
        "⠦",
        "⠧",
        "⠇",
        "⠏",
      }
      local spinner_symbols_len = 10

      -- Initializer
      function M:init(options)
        M.super.init(self, options)

        local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

        vim.api.nvim_create_autocmd({ "User" }, {
          pattern = "CodeCompanionRequest*",
          group = group,
          callback = function(request)
            if request.match == "CodeCompanionRequestStarted" then
              self.processing = true
            elseif request.match == "CodeCompanionRequestFinished" then
              self.processing = false
            end
          end,
        })
      end

      -- Function that runs every time statusline is updated
      function M:update_status()
        if self.processing then
          self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
          return spinner_symbols[self.spinner_index]
        else
          return nil
        end
      end

      table.insert(opts.sections.lualine_x, 2, M)
    end,
  },

  -- add ai_accept action
  -- {
  --   "zbirenbaum/copilot.lua",
  --   opts = function()
  --     LazyVim.cmp.actions.ai_accept = function()
  --       if require("copilot.suggestion").is_visible() then
  --         LazyVim.create_undo()
  --         require("copilot.suggestion").accept()
  --         return true
  --       end
  --     end
  --   end,
  -- },
  -- -- lualine
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     table.insert(
  --       opts.sections.lualine_x,
  --       2,
  --       LazyVim.lualine.status(LazyVim.config.icons.kinds.Copilot, function()
  --         local clients = package.loaded["copilot"] and LazyVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
  --         if #clients > 0 then
  --           local status = require("copilot.api").status.data.status
  --           return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
  --         end
  --       end)
  --     )
  --   end,
  -- },
  --
  -- vim.g.ai_cmp
  --     and {
  --       -- copilot cmp source
  --       {
  --         "hrsh7th/nvim-cmp",
  --         optional = true,
  --         dependencies = { -- this will only be evaluated if nvim-cmp is enabled
  --           {
  --             "zbirenbaum/copilot-cmp",
  --             opts = {},
  --             config = function(_, opts)
  --               local copilot_cmp = require("copilot_cmp")
  --               copilot_cmp.setup(opts)
  --               -- attach cmp source whenever copilot attaches
  --               -- fixes lazy-loading issues with the copilot cmp source
  --               LazyVim.lsp.on_attach(function()
  --                 copilot_cmp._on_insert_enter({})
  --               end, "copilot")
  --             end,
  --             specs = {
  --               {
  --                 "hrsh7th/nvim-cmp",
  --                 optional = true,
  --                 opts = function(_, opts)
  --                   table.insert(opts.sources, 1, {
  --                     name = "copilot",
  --                     group_index = 1,
  --                     priority = 100,
  --                   })
  --                 end,
  --               },
  --             },
  --           },
  --         },
  --       },
  --       {
  --         "saghen/blink.cmp",
  --         optional = true,
  --         dependencies = {
  --           "giuxtaposition/blink-cmp-copilot",
  --           "saghen/blink.compat",
  --         },
  --         opts = {
  --           sources = {
  --             default = { "copilot" },
  --             providers = {
  --               copilot = {
  --                 name = "copilot",
  --                 module = "blink-cmp-copilot",
  --                 kind = "Copilot",
  --                 score_offset = 100,
  --                 async = true,
  --               },
  --             },
  --             compat = {
  --               "avante_commands",
  --               "avante_mentions",
  --               "avante_files",
  --             },
  --           },
  --         },
  --       },
  --     }
  --   or nil,
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

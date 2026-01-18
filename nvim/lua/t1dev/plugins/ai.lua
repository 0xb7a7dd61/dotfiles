return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "nvim-mini/mini.diff", opts = {} },
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
          acp = {
            claude_code = function()
              return require("codecompanion.adapters").extend("claude_code", {
                env = {
                  CLAUDE_CODE_OAUTH_TOKEN = "cmd:op read op://Private/ClaudeCode/credential --account my.1password.com --no-newline",
                },
              })
            end,
          },
          http = {
            anthropic = function()
              return require("codecompanion.adapters").extend("anthropic", {
                env = {
                  api_key = "cmd:op read op://Private/Anthropic/credential --account my.1password.com --no-newline",
                },
              })
            end,
            copilot = function()
              return require("codecompanion.adapters").extend("copilot", {})
            end,
            openai = function()
              return require("codecompanion.adapters").extend("openai", {
                env = {
                  api_key = "cmd:op read op://Private/OpenAI/credential --account my.1password.com --no-newline",
                },
              })
            end,
            gemini = function()
              return require("codecompanion.adapters").extend("gemini", {
                env = {
                  api_key = "cmd:op read op://Private/Gemini/credential --account my.1password.com --no-newline",
                },
              })
            end,
          },
        },
        prompt_library = {
          ["Zod object creation workflow"] = {
            interactions = "chat",
            description = "Instruct the LLM to create Zod objects to represent DTOs or ORMs",
            opts = { index = 1, is_workflow = true },
            prompts = {
              {
                {
                  role = "system",
                  content = "You carefully provide accurate, factual, thoughtful, nuanced answers, and are brilliant at reasoning. If you think there might not be a correct answer, you say so. Always spend a few sentences explaining background context, assumptions, and step-by-step thinking BEFORE you try to answer a question. Don't be verbose in your answers, but do provide details and examples where it might help the explanation. You are an expert software engineer for the TypeScript language, specializing in Zod schema object creation.",
                  opts = { visible = false },
                },
              },
              {
                {
                  role = "user",
                  content = function()
                    -- Leverage auto_tool_mode which disables the requirement of approvals and automatically saves any edited buffer
                    vim.g.codecompanion_auto_tool_mode = true

                    -- Some clear instructions for the LLM to follow
                    return [[### Instructions

1. Create a new schema file next to #buffer{diff} using the @full_stack_dev
2. Then write the code that includes the Zod schema objects noted in the following schema outline.
3. Finally, analyze the original buffer for any opportunities to implement the newly created Zod schema objects.
4. If there are any places that could benefit from the Zod objects, implement them. If there is any doubt, ask about the places that may benefit from the new Zod objects.

### Schema Outline 

Your objects here 

### Steps to Follow

You are required to write code following the instructions provided above, providing any questions you may have regarding object structure or object strictness, etc. Follow these steps exactly:

1. Do everything asked from you in the Instructions section above.
2. Then using @full_stack_dev, run `npx tsc --noEmit` to ensure there are no compilation errors from your code changes.
3. Make sure you trigger all necessary tools in the same response

We'll repeat this cycle until the project compiles without errors. Ensure no deviations from these steps.]]
                  end,
                  opts = { auto_submit = false },
                },
              },
            },
          },
        },
        interactions = {
          chat = {
            adapter = "claude_code",
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
    "nvim-mini/mini.diff", -- Inline and better diff over the default
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

}

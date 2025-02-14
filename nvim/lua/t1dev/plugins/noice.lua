return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "E85: There is no listed buffer" },
              { find = "E486: Pattern not found: ?$" },
              { find = "E490: No fold found" },
              { find = "Already at oldest change" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "^%d+ fewer lines;?" },
              { find = "^%d+ more lines;?" },
              { find = "^%d+ line lesses;?" },
              { find = ".*Pattern not found.*$" },
              { find = "^%d+ lines .ed %d+ times?$" },
              { find = "^%d+ lines yanked$" },
              { find = "No information available" },
              { kind = "wmsg" },
            },
          },
          opts = { skip = true },
        },
      },
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}

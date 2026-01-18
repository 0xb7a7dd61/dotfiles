vim.keymap.set("n", "<leader><tab>}", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>{", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- move selected text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv")

-- move line below without losing cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- allow half page jumping to retain cursor in middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep cursor in middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- paste without yanking
vim.keymap.set("x", "<leader>p", [["_dP]])

-- delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- remap ctrl-c to esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- disable ex mode
vim.keymap.set("n", "Q", "<nop>")

-- replace work under cursor
vim.keymap.set(
  "n",
  "<leader>rr",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Replace All Under Cursor" }
)

-- remap shift up/down to half screen scrolling
vim.keymap.set("n", "<S-Up>", "<C-u>")
vim.keymap.set("n", "<S-Down>", "<C-d>")

vim.keymap.set("n", "<leader>ww", function()
  local start_win = vim.api.nvim_get_current_win()
  local tries = 0
  local max_tries = 20

  repeat
    vim.cmd("wincmd w")
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype

    tries = tries + 1
    if ft ~= "snacks_notif" then
      return
    end

    if win == start_win or tries >= max_tries then
      return
    end
  until false
end, { desc = "Next window (skip notifications)" })

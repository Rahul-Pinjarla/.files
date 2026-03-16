-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "gD", "<cmd>Glance definitions<cr>", { desc = "Peek Definition (Glance)" })
vim.keymap.set("n", "gR", "<CMD>Glance references<CR>")
vim.keymap.set("n", "gY", "<CMD>Glance type_definitions<CR>")
vim.keymap.set("n", "gM", "<CMD>Glance implementations<CR>")

-- restore vim viewport navigation
vim.keymap.del("n", "H")
vim.keymap.del("n", "L")

-- buffer switching
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { silent = true })

local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>do", dap.step_over)
vim.keymap.set("n", "<leader>dO", dap.step_out)
vim.keymap.set("n", "<leader>dr", dap.repl.open)
vim.keymap.set("n", "<leader>du", dapui.toggle)

--
pcall(vim.keymap.del, "n", "<C-h>")
pcall(vim.keymap.del, "n", "<C-j>")
pcall(vim.keymap.del, "n", "<C-k>")
pcall(vim.keymap.del, "n", "<C-l>")

vim.keymap.set("n", '<C-k>', ':TmuxNavigateUp<CR>')
vim.keymap.set("n", '<C-j>', ':TmuxNavigateDown<CR>')
vim.keymap.set("n", '<C-h>', ':TmuxNavigateLeft<CR>')
vim.keymap.set("n", '<C-l>', ':TmuxNavigateRight<CR>')

vim.keymap.set("v", "<leader>sr", [[:s/]], { desc = "Substitute in selection" })
vim.keymap.set("v", "<leader>ss", [[:s/^]], { desc = "Substitute in selection start" })


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

keymap.set("i", "<C-j>", "<Down>", { desc = "Insert Mode Down" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Insert Mode Up" })
keymap.set("i", "<C-h>", "<Left>", { desc = "Insert Mode Left" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Insert Mode Right" })

-- remap write and quit to capitals
vim.cmd([[
command! W write
command! Q quit
command! Wq write | quit
command! WQ write | quit
]])

keymap.set("n", "q", "<Nop>")

keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "Clear Search Highlights" })

keymap.set("n", "x", '"_x', { desc = "Delete Char without Copy" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split Vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split Horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make Equal" })
keymap.set("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close Current" })

-- buffer navigation
keymap.set("n", "<leader>p", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
keymap.set("n", "<leader>n", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

-- disable arrow navigation in normal mode
keymap.set("n", "<Up>", "<Nop>")
keymap.set("n", "<Down>", "<Nop>")
keymap.set("n", "<Left>", "<Nop>")
keymap.set("n", "<Right>", "<Nop>")

----------------------
-- Plugin Keybinds
----------------------
-- telescope

vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })

-- vim.keymap.set('n', '<leader>/', function()
--     -- You can pass additional configuration to telescope to change theme, layout, etc.
--     require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--         winblend = 10,
--         previewer = false,
--     })
-- end, { desc = '[/] Fuzzily search in current buffer' })

keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
keymap.set('n', '<leader>fs', require('telescope.builtin').live_grep, { desc = '[F]ind [S]trings' })
keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
keymap.set('n', '<leader>nb', require('nvim-navbuddy').open, { desc = '[N]av[B]uddy' })

keymap.set("n", "<leader>ca", "<cmd>CodeActionMenu<cr>", { desc = "Smart Rename" })
keymap.set("n", "gf", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", { desc = "Flotaing Definition" })
keymap.set("n", "gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<cr>",
    { desc = "Floating Type Definition" })
keymap.set("n", "q", "<cmd>lua require('goto-preview').close_all_win()<cr>", { desc = "Close floating windows" })

keymap.set("n", "<C-k>", function()
    vim.diagnostic.goto_prev()
end, { desc = "Jump Prev Diagnostic" })
keymap.set("n", "<C-j>", function()
    vim.diagnostic.goto_next()
end, { desc = "Jump Next Diagnostic" })

-- nvim-tree
keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle Explorer" })

-- undoTree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- terminal keybinds
keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>")
vim.cmd([[
tnoremap <esc> <C-\><C-N>
]])

keymap.set('n', "<leader>b", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle Breakpoint" })
keymap.set('n', "<leader>rs", "<cmd>LspRestart<cr>", { desc = "Continue" })

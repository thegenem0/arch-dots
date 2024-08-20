local utils = require("thegenem0.utils");

return {
    {
        'mistweaverco/kulala.nvim',
        config = function()
            require('kulala').setup({
                default_view = "body",
                formatters = {
                    json = { "jq", "." },
                    xml = { "xmllint", "--format", "-" },
                    html = { "xmllint", "--format", "--html", "-" },
                }
            })

            utils.keymap("n", "<leader>rr", ":lua require('kulala').run() <CR>", { desc = "[R]un [R]equest" })
            utils.keymap("n", "<leader>ss", ":lua require('kulala').scratchpad() <CR>", { desc = "[S]cratch [S]etup" })
            utils.keymap("n", "<leader>tr", ":lua require('kulala').toggle_view() <CR>", { desc = "[T]oggle [R]equest" })
            utils.keymap("n", "<leader>sr", ":lua require('kulala').search() <CR>", { desc = "[S]earch [R]equest" })
            utils.keymap("n", "<leader>se", ":lua require('kulala').set_selected_env() <CR>",
                { desc = "[S]elect [E]nvironment" })
        end
    },
}

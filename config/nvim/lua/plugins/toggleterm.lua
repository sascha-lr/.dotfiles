return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("toggleterm").setup()

        vim.keymap.set('n', 'þ', function()
            local git_root = vim.fs.root(0, ".git")
            local target_dir = git_root

            if not target_dir then
                target_dir = vim.fn.expand("%:p:h")
                if target_dir == "" then target_dir = vim.fn.getcwd() end
            end

            vim.cmd("ToggleTerm dir=" .. target_dir)
        end, { desc = "Toggle Terminal in Git Root" })

        vim.keymap.set('t', 'þ', '<cmd>ToggleTerm<CR>', { desc = "Hide Terminal" })

        local Terminal = require('toggleterm.terminal').Terminal

        local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            hidden = true,
            float_opts = {
                border = "curved",
            },
        })

        local function toggle_lazygit()
            local git_root = vim.fs.root(0, ".git")

            if git_root then
                lazygit.dir = git_root
            else
                local current_dir = vim.fn.expand("%:p:h")
                lazygit.dir = current_dir ~= "" and current_dir or vim.fn.getcwd()
            end

            lazygit:toggle()
        end

        vim.keymap.set('n', '<leader>gg', toggle_lazygit, { desc = "Toggle Lazygit", noremap = true, silent = true })
    end
}

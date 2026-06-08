return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(bufnr)
            local gs = require('gitsigns')

            vim.keymap.set('n', ']g', function() gs.nav_hunk('next') end, { buffer = bufnr, desc = "Next Git Hunk" })

            vim.keymap.set('n', '[g', function() gs.nav_hunk('prev') end, { buffer = bufnr, desc = "Previous Git Hunk" })

            vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr, desc = "Preview Git Hunk" })
        end
    }
}

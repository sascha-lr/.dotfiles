return {
    'brianhuster/live-preview.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    keys = {
        { "<leader>ls", "<cmd>LivePreview start<CR>", desc = "Live Preview Start" },
        { "<leader>lq", "<cmd>LivePreview close<CR>", desc = "Live Preview Stop" },
    },
    config = function()
        require("live-preview").setup({
        })
    end
}

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Forces lazy.nvim to load this before other plugins
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            flavour = "mocha", 
        })
    end
}

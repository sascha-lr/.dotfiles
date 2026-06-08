return {
    "williamboman/mason.nvim",
    config = function()
        -- 1. Setup the Mason UI
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
     end
}

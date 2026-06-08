return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Required for file icons
    config = function()
        -- Load your Matugen colors here
        local matugen = require("config.matugen-colors")

        -- Define your custom theme inside the config function
        local custom_lualine_theme = {
            normal = {
                a = { bg = matugen.primary, fg = matugen.on_primary, gui = "bold" },
                b = { bg = "NONE", fg = matugen.primary },
                c = { bg = "NONE", fg = matugen.primary },
            },
            insert = {
                a = { bg = matugen.secondary, fg = matugen.on_secondary, gui = "bold" },
                b = { bg = "NONE", fg = matugen.secondary },
                c = { bg = "NONE", fg = matugen.secondary },
            },
            visual = {
                a = { bg = matugen.tertiary, fg = matugen.on_tertiary, gui = "bold" },
                b = { bg = "NONE", fg = matugen.tertiary },
                c = { bg = "NONE", fg = matugen.tertiary },
            },
            replace = {
                a = { bg = matugen.tertiary, fg = matugen.on_tertiary, gui = "bold" },
                b = { bg = "NONE", fg = matugen.tertiary },
                c = { bg = "NONE", fg = matugen.tertiary },
            },
            command = {
                a = { bg = matugen.primary, fg = matugen.on_primary, gui = "bold" },
                b = { bg = "NONE", fg = matugen.primary },
                c = { bg = "NONE", fg = matugen.primary },
            },
            inactive = {
                a = { bg = "NONE", fg = matugen.on_surface },
                b = { bg = "NONE", fg = matugen.on_surface },
                c = { bg = "NONE", fg = matugen.on_surface },
            },
        }

        -- Set up Lualine
        require("lualine").setup({
            options = {
                theme = custom_lualine_theme, -- Applies your Matugen theme
                globalstatus = true,          -- Only one globalstatus (set to true!)
                icons_enabled = true,
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    'branch',
                    { 'diff',        colored = false },
                    { 'diagnostics', colored = false }
                },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end,
}

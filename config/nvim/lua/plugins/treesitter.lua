return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        branch = "master",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "query", "python", "javascript", "html", "bash"
                },
                sync_install = false,
                auto_install = true,
                indent = {
                    enable = false,
                },
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        -- The Primeagen's performance tweak: disable for files > 100KB
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            vim.notify(
                                "File larger than 100KB. Treesitter disabled for performance.",
                                vim.log.levels.WARN,
                                { title = "Treesitter" }
                            )
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = { "markdown" },
                },
            })
        end,
    },

    -- The Sticky Context Plugin
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesitter-context").setup({
                enable = true, 
                max_lines = 0, 
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20, 
                trim_scope = "outer", 
                mode = "cursor", 
                separator = nil,
                zindex = 20, 
            })
        end,
    },
}

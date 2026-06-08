return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
    end,
    keys = {
        { "<leader>a", function() require("harpoon"):list():add() end,     desc = "Harpoon Add File" },
        {
            "<leader>hh",
            function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end,
            desc = "Harpoon Quick Menu",
        },
        {
            "<leader>ht",
            function()
                local harpoon = require("harpoon")
                local conf = require("telescope.config").values
                local file_paths = {}
                for _, item in ipairs(harpoon:list().items) do
                    table.insert(file_paths, item.value)
                end

                require("telescope.pickers").new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                }):find()
            end,
            desc = "Open Harpoon window in Telescope",
        },
        { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon to File 1" },
        { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon to File 2" },
        { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon to File 3" },
        { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon to File 4" },
    },
}

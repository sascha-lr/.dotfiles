local matugen = require("config.matugen-colors")

vim.cmd.colorscheme "catppuccin-mocha"

function SetUIColors()
    vim.api.nvim_set_hl(0, "Normal", { fg = matugen.secondary, bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { fg = matugen.tertiary, bg = "none" })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = matugen.primary, bg = "none" })
    vim.api.nvim_set_hl(0, "FloatTitle", { fg = matugen.primary, bg = "none" })

    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = matugen.primary, bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { fg = matugen.primary, bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { fg = matugen.primary, bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = matugen.primary, bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = matugen.primary, bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = matugen.primary, bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = matugen.primary, bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = matugen.primary, fg = matugen.on_primary, bold = true })
    vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = matugen.tertiary, bold = true })
    vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = matugen.primary })

    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = matugen.primary })
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = matugen.primary })
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = matugen.primary })

    vim.api.nvim_set_hl(0, "WinSeparator", { fg = matugen.primary })

    vim.api.nvim_set_hl(0, "PmenuSel", { bg = matugen.primary, fg = matugen.on_primary, bold = true })
    vim.api.nvim_set_hl(0, "PmenuMatch", { fg = matugen.tertiary, bold = true })
    vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "PmenuThumb", { bg = matugen.tertiary })

    vim.api.nvim_set_hl(0, "WildMenu", { bg = matugen.primary, fg = matugen.on_primary, bold = true })

    vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE", fg = matugen.on_surface })
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = "NONE", fg = matugen.primary, bold = true })

    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = matugen.primary, fg = matugen.on_primary, bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = matugen.tertiary, bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuScrollbar", { bg = matugen.tertiary })
    vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpScrollbar", { bg = matugen.tertiary })

    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true, sp = matugen.primary })

    vim.api.nvim_set_hl(0, "UndotreeNode", { fg = matugen.tertiary })
    vim.api.nvim_set_hl(0, "UndotreeBranch", { fg = matugen.primary })
    vim.api.nvim_set_hl(0, "UndotreeNodeCurrent", { fg = matugen.tertiary, bold = true })
    vim.api.nvim_set_hl(0, "UndotreeCurrent", { fg = matugen.tertiary, bold = true, italic = true })
    vim.api.nvim_set_hl(0, "UndotreeHead", { fg = matugen.primary, bold = true })
    vim.api.nvim_set_hl(0, "UndotreeTimestamp", { fg = matugen.on_surface })
    vim.api.nvim_set_hl(0, "UndotreeSeq", { fg = matugen.on_surface })
end

SetUIColors()
vim.api.nvim_create_autocmd("Signal", {
    pattern = "SIGUSR1",
    callback = function()
        package.loaded["config.matugen-colors"] = nil

        matugen = require("config.matugen-colors")

        SetUIColors()
    end,
})

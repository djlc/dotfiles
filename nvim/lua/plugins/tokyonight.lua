return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
            on_highlights = function(hl, c)
                    hl["DiagnosticVirtualTextError"] = { fg = c.error, bg = "NONE" }
                    hl["DiagnosticVirtualTextWarn"]  = { fg = c.comment, bg = "NONE" }
                    hl["DiagnosticVirtualTextInfo"]  = { fg = c.info, bg = "NONE" }
                    hl["DiagnosticVirtualTextHint"]  = { fg = c.hint, bg = "NONE" }
                --for _, sev in ipairs({ "Error", "Warn", "Info", "Hint" }) do
                --    hl["DiagnosticVirtualText" .. sev] = { fg = c[sev:lower()], bg = "NONE" }
                --end
            end,
        })
    end
}

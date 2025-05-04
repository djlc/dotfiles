return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")

        --local signs = {
        --    Error = "❌",
        --    Warn  = "⚠️",
        --    Hint  = "💡",
        --    Info  = "ℹ️",
        --}

        --for type, icon in pairs(signs) do
        --    local hl = "DiagnosticSign" .. type
        --    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        --end

        vim.api.nvim_create_autocmd("DiagnosticChanged", {
            callback = function()
                vim.diagnostic.setqflist({ open = false })
            end,
        })

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "❌",
                    [vim.diagnostic.severity.WARN]  = "⚠️",
                    [vim.diagnostic.severity.HINT]  = "💡",
                    [vim.diagnostic.severity.INFO]  = "ℹ️",
                },
            },
            virtual_text = {
                prefix = "🔸",
                spacing = 4,
                format = function(diagnostic)
                    return diagnostic.message
                end
            },
            severity_sort = true
        })

        -- Lua
        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" } -- suppress warning
                    }
                }
            }
        })

        -- python
        lspconfig.pyright.setup({})

        -- C/C++
        lspconfig.clangd.setup({})

        -- SystemVerilog
        lspconfig.svlangserver.setup({
            cmd = { "svlangserver" },
            filetypes = { "systemverilog", "verilog" },
            root_dir = require("lspconfig.util").root_pattern("*.sdc", "Makefile", ".git"),
        })
    end
}

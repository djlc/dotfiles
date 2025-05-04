return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "RRethy/nvim-treesitter-endwise",
    },
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "lua", "vim", "bash", "tcl", "c", "verilog"
            },
            highlight = {
                enable = true,
                disable = { "verilog" }
            },
            indent = {
                enable = true,
            },
        })
    end
}

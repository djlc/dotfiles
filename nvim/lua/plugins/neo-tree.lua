return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim"
    },
    config = function()
        require("neo-tree").setup({
            window = {
                mappings = {
                    ["-"] = "navigate_up",
                    ["R"] = "refresh",
                    ["gh"] = "toggle_hidden",
                },
            },
        })
    end,
    lazy = false
}

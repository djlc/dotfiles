return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep"
    },
    config = function()
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "node_modules", "%.git/" },
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top",
                },
            },
            extensions = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        })
        require("telescope").load_extension("fzf")
    end
}

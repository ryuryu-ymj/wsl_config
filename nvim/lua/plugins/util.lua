return {
    -- Startup timer
    {
        'dstein64/vim-startuptime',
        cmd = 'StartupTime',
        config = function()
            vim.g.startuptime_tries = 5
        end,
    },

    -- Greeter
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            local startify = require("alpha.themes.startify")
            -- available: devicons, mini, default is mini
            -- if provider not loaded and enabled is true, it will try to use another provider
            startify.file_icons.provider = "devicons"
            require("alpha").setup(
                startify.config
            )
        end,
    },

    -- cursor animation effect
    {
        "sphamba/smear-cursor.nvim",
        opts = {},
    },

    -- smooth scroll
    {
        "karb94/neoscroll.nvim",
        opts = {
            duration_multiplier = 0.5,
        },
    },
}

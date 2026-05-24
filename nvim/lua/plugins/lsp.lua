return {
    -- Lsp server manager
    {
        'williamboman/mason.nvim',
        cmd = "Mason",
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {},
    },

    -- Configs for the LSP client
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.config("*", {
                capabilities = require('blink.cmp').get_lsp_capabilities()
            })
        end
    },

    -- Show inlay hints
    {
        "chrisgrieser/nvim-lsp-endhints",
        event = "LspAttach",
        opts = {}, -- required, even if empty
    },

    -- Display prettier diagnostic messages.
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy", -- Or `LspAttach`
        priority = 1000,    -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup()
            vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
        end
    },

    -- Show lsp progress at the right bottom corner
    {
        'j-hui/fidget.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
}

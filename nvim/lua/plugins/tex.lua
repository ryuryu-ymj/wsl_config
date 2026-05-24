return {
    {
        'lervag/vimtex',
        lazy = false, -- VimTeXは内部で遅延ロードされる
        config = function()
            vim.g.vimtex_view_method = "skim"
            vim.g.vimtex_imaps_leader = "@"
        end
    }
}

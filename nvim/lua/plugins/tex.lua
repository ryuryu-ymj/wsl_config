return {
    {
        'lervag/vimtex',
        lazy = false,
        config = function()
            vim.g.vimtex_view_general_viewer = "/mnt/c/Users/ryuryu/AppData/Local/SumatraPDF/SumatraPDF.exe"
            vim.g.vimtex_view_general_options = '-reuse-instance @pdf'
            vim.g.vimtex_imaps_leader = "@"
        end
    }
}

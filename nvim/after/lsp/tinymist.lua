return {
    -- single_file_support = true,
    -- -- offset_encoding = "utf-8",
    -- root_dir = function()
    --     return vim.fn.getcwd()
    -- end,
    settings = {
        -- Disable LSP syntax highlighting.
        semanticTokens = "disable",
        -- Enable formatter.
        formatterMode = "typstyle",
        formatterPrintWidth = 120,
    },
}

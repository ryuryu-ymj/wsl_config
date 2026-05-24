return {
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = '1.*',
        -- build = function() require 'typst-preview'.update() end,
        config = function()
            require 'typst-preview'.setup {
                dependencies_bin = {
                    ["tinymist"] = vim.fn.stdpath("data") .. "/mason/bin/tinymist",
                },
                open_cmd = 'chrome.exe --args --app=%s > /dev/null 2>&1',
                -- open_cmd = 'firefox %s -P typst-preview --class typst-preview',
                -- debug = true,
                -- cur dirをコンパイル時のrootに
                -- get_root = function(path_of_main_file)
                --     return vim.fn.getcwd()
                -- end
            }
        end,
    },
}

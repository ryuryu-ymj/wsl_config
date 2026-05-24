-- ファイルを開いた時に前回のカーソルの位置を復元
vim.api.nvim_create_autocmd('BufRead', {
    callback = function(opts)
        vim.api.nvim_create_autocmd('BufWinEnter', {
            once = true,
            buffer = opts.buf,
            callback = function()
                local ft = vim.bo[opts.buf].filetype
                local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
                if
                    not (ft:match('commit') and ft:match('rebase'))
                    and last_known_line > 1
                    and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
                then
                    vim.api.nvim_feedkeys([[g`"]], 'nx', false)
                end
            end,
        })
    end,
})

-- ヤンクした範囲をハイライト
local id = vim.api.nvim_create_augroup('highlight_yank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
    group = id,
    callback = function()
        vim.hl.on_yank { higroup = 'IncSearch', timeout = 100 }
    end,
})

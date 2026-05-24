-- Mappings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<Leader>dk', vim.diagnostic.open_float, opts)
vim.keymap.set('n', 'g]', function() vim.diagnostic.jump({ count = 1, float = false }) end, opts)
vim.keymap.set('n', 'g[', function() vim.diagnostic.jump({ count = -1, float = false }) end, opts)
vim.keymap.set('n', '<Leader>dl', "<cmd>Trouble diagnostics toggle<cr>", opts)
vim.keymap.set('n', '<Leader>ds', "<cmd>Trouble symbols toggle focus=false<cr>", opts)

-- Set diagnostics signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅙 ",
            [vim.diagnostic.severity.WARN] = "󰀦 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
        }
    }
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- 行番号の左にサインを表示する列を常に表示
        vim.wo.signcolumn = 'yes'

        -- Mappings
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gd', "<cmd>Trouble my_lsp_definitions <cr>", bufopts)
        vim.keymap.set('n', 'gr', "<cmd>Trouble my_lsp_references <cr>",
            { noremap = true, nowait = true, silent = true, buffer = bufnr })
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<Leader>ac', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<Leader>l', function() vim.lsp.buf.format { async = true } end, bufopts)
        vim.keymap.set('n', '<Leader>w', function()
            vim.lsp.buf.format()
            vim.cmd.write()
        end, bufopts)

        -- カーソル下の変数などをハイライト
        if client ~= nil and client:supports_method("textDocument/formatting", bufnr) then
            vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#3c3836' })
            vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#3c3836' })
            vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#3c3836' })
            vim.api.nvim_create_augroup('lsp_document_highlight', {
                clear = false
            })
            vim.api.nvim_clear_autocmds({
                buffer = bufnr,
                group = 'lsp_document_highlight',
            })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                group = 'lsp_document_highlight',
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                group = 'lsp_document_highlight',
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end
})

-- Enable language server
local lsp_list = {
    -- typo checker
    "typos_lsp",
    -- Lua
    "lua_ls",
    -- Python
    -- "jedi_language_server",
    "pyright",
    "ruff",
    -- Rust
    "rust_analyzer",
    -- Markdown
    "marksman",
    -- Tex
    "texlab",
    -- Web
    "html",
    "cssls",
    "ts_ls",
    -- Julia
    "julials",
    -- C, C++
    "clangd",
    -- Typst
    "tinymist",
}
vim.lsp.enable(lsp_list)

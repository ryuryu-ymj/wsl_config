return {
    -- Snipet engine
    -- {
    --     'L3MON4D3/LuaSnip',
    --     keys = {
    --         {
    --             '<C-i>',
    --             function()
    --                 local snip = require('luasnip')
    --                 if snip.jumpable(1) then
    --                     snip.jump(1)
    --                 else
    --
    --                 end
    --             end,
    --             mode = { "i", "s" }
    --         },
    --         {
    --             '<C-k>',
    --             function()
    --                 require('luasnip').jump(-1)
    --             end,
    --             mode = { "i", "s" }
    --         },
    --     },
    --     config = function()
    --         require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    --     end
    -- },

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        version = false, -- last release is way too old
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            -- snipet engine
            {
                'L3MON4D3/LuaSnip',
                config = function()
                    -- vim.api.nvim_set_hl(0, 'LuasnipInsertNodePassive', { link = 'GruvboxRedUnderline' })
                    -- vim.api.nvim_set_hl(0, 'LuasnipInsertNodeActive', { link = 'GruvboxAquaUnderline' })

                    require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

                    -- local types = require("luasnip.util.types")
                    require("luasnip").setup({
                        -- ext_opts = {
                        --     [types.insertNode] = {
                        --         active = {
                        --             hl_group = "GruvboxAqua"
                        --         },
                        --         unvisited = {
                        --             hl_group = "GruvboxRed"
                        --         },
                        --     },
                        -- },
                    })
                end
            },
            -- Completion sources
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            -- 'hrsh7th/cmp-omni',
            {
                'uga-rosa/cmp-dictionary',
                config = function()
                    local dict = require('cmp_dictionary')
                    dict.setup {
                        exact = 4,
                    }
                    dict.switcher {
                        spelllang = {
                            en = vim.fn.stdpath('config') .. '/dict/en.dict',
                        }
                    }
                end
            },
            -- 'f3fora/cmp-spell',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-c>'] = cmp.mapping.abort(),
                    ['<C-j>'] = cmp.mapping.confirm { select = true },
                    -- ['<C-j>'] = cmp.mapping(function ()
                    --     if luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         cmp.confirm{ select = true }
                    --     end
                    -- end),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ['<C-m>'] = cmp.mapping.scroll_docs(4),
                    ['<C-o>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-i>'] = cmp.mapping(function(fallback)
                        local snip = require('luasnip')
                        if snip.jumpable(1) then
                            snip.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<C-k>'] = cmp.mapping(function(fallback)
                        local snip = require('luasnip')
                        if snip.jumpable(-1) then
                            snip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                    -- { name = 'omni' },
                }, {
                    { name = 'buffer' },
                }, {
                    { name = 'dictionary' },
                })
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = {
                    ['<Tab>'] = {
                        c = function()
                            if cmp.visible() then
                                cmp.select_next_item()
                            end
                        end
                    },
                    ['<S-Tab>'] = {
                        c = function()
                            if cmp.visible() then
                                cmp.select_prev_item()
                            end
                        end
                    },
                },
                sources = {
                    { name = 'buffer' }
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = {
                    ['<Tab>'] = {
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item()
                            else
                                fallback()
                            end
                        end
                    },
                    ['<S-Tab>'] = {
                        c = function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item()
                            else
                                fallback()
                            end
                        end
                    },
                },
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
            })
        end,
    },

    -- Add/delete/replace surroundings such as (), "".
    {
        'machakann/vim-sandwich',
        init = function()
            vim.g.sandwich_no_default_key_mappings = 1
        end,
        keys = {
            { mode = 'n',          'ds',  '<Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-query-a)' },
            { mode = 'n',          'dsb', '<Plug>(operator-sandwich-delete)<Plug>(textobj-sandwich-auto-a)' },
            { mode = 'n',          'cs',  '<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-query-a)' },
            { mode = 'n',          'csb', '<Plug>(operator-sandwich-replace)<Plug>(textobj-sandwich-auto-a)' },
            { mode = 'n',          'ys',  '<Plug>(operator-sandwich-add)' },
            { mode = 'n',          'yss', '<Plug>(operator-sandwich-add)_' },
            { mode = 'v',          'S',   '<Plug>(operator-sandwich-add)' },
            { mode = { 'x', 'o' }, 'ib',  '<Plug>(textobj-sandwich-auto-i)' },
            { mode = { 'x', 'o' }, 'ab',  '<Plug>(textobj-sandwich-auto-a)' },
            { mode = { 'x', 'o' }, 'is',  '<Plug>(textobj-sandwich-query-i)' },
            { mode = { 'x', 'o' }, 'as',  '<Plug>(textobj-sandwich-query-a)' },
        },
        config = function()
            vim.fn['operator#sandwich#set']('all', 'all', 'hi_duration', 100)
        end,
    },

    -- Automatically close surroundings
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function()
            local npairs = require('nvim-autopairs')
            npairs.setup()
            -- vim.keymap.set('i', '<C-h>', function()
            --     return npairs.autopairs_bs()
            -- end)

            local rule = require('nvim-autopairs.rule')
            local cond = require('nvim-autopairs.conds')

            npairs.get_rule('(')
                :with_pair(cond.not_before_text('\\'))
            npairs.get_rule('[')
                :with_pair(cond.not_before_text('\\'))
            npairs.get_rule('{')
                :with_pair(cond.not_before_text('\\'))
            npairs.add_rules({
                rule('$', '$', { "markdown", "tex" })
                    :with_pair(cond.not_after_regex('[^ \\t\\r\\n,.]', 1))
                    :with_move(function(opts)
                        return opts.next_char == opts.char
                    end)
            })
        end
    },

    -- Toggle comments
    {
        'numToStr/Comment.nvim',
        event = "VeryLazy",
        config = true,
    },

    {
        'NMAC427/guess-indent.nvim',
        config = true,
    },
}

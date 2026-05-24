-- ホイールのクリックによるペーストを無効化
vim.keymap.set({ '', '!' }, '<MiddleMouse>', '<Nop>')
-- Shift+ホイールで左右スクロール
vim.keymap.set({ '', '!' }, '<S-ScrollWheelUp>', '3zh')
vim.keymap.set({ '', '!' }, '<S-ScrollWheelDown>', '3zl')
-- Alt+h,j,k,lでウィンドウ間の移動
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-j>', '<C-w>j')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('i', '<A-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('i', '<A-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('i', '<A-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('i', '<A-l>', '<C-\\><C-N><C-w>l')
-- Alt+H,J,K,Lでウィンドウを移動
vim.keymap.set('n', '<A-H>', '<C-w>H')
vim.keymap.set('n', '<A-J>', '<C-w>J')
vim.keymap.set('n', '<A-K>', '<C-w>K')
vim.keymap.set('n', '<A-L>', '<C-w>L')
vim.keymap.set('i', '<A-H>', '<C-\\><C-N><C-w>H')
vim.keymap.set('i', '<A-J>', '<C-\\><C-N><C-w>J')
vim.keymap.set('i', '<A-K>', '<C-\\><C-N><C-w>K')
vim.keymap.set('i', '<A-L>', '<C-\\><C-N><C-w>L')
-- -- 左右キーでタブ間の移動
-- vim.keymap.set('n', '<Left>', '<C-Pageup>')
-- vim.keymap.set('n', '<Right>', '<C-Pagedown>')
-- vim.keymap.set('i', '<Left>', '<C-\\><C-N><C-Pageup>')
-- vim.keymap.set('i', '<Right>', '<C-\\><C-N><C-Pagedown>')
-- -- Shift+左右キーでタブを移動
-- vim.keymap.set('n', '<S-Left>', '<Cmd>-tabmove<CR>')
-- vim.keymap.set('n', '<S-Right>', '<Cmd>+tabmove<CR>')
-- vim.keymap.set('i', '<S-Left>', '<Cmd>-tabmove<CR>')
-- vim.keymap.set('i', '<S-Right>', '<Cmd>+tabmove<CR>')
-- <Leader>qでバッファを削除
vim.keymap.set('n', '<Leader>q', '<Cmd>bdelete<CR>')
vim.keymap.set('n', '<Leader>!', '<Cmd>bdelete!<CR>')
-- <Leader>wでバッファを保存
vim.keymap.set('n', '<Leader>w', '<Cmd>write<CR>')

-- ^, $の代わりにH, Lで行頭行末移動
vim.keymap.set({ 'n', 'x', 'o' }, 'H', '^')
vim.keymap.set({ 'n', 'x', 'o' }, 'L', '$')
-- insertモードでemacs風のキーバインド
vim.keymap.set('i', '<C-h>', '<BS>', { remap = true })
vim.keymap.set('i', '<C-j>', '<CR>', { remap = true })
vim.keymap.set('!', '<C-a>', '<C-o>^')
vim.keymap.set('i', '<C-e>', '<End>')
vim.keymap.set('i', '<C-d>', '<Delete>')
-- vim.keymap.set('i', '<C-k>', '<Esc>lDa')
vim.keymap.set('!', '<C-b>', '<Left>')
vim.keymap.set('!', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')

-- 消去したときにレジスタを汚さない
vim.keymap.set({ 'n', 'x' }, 'd', '"_d')
vim.keymap.set('n', 'dd', '"_dd')
vim.keymap.set('n', 'D', '"_D')
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')
vim.keymap.set({ 'n', 'x' }, 'c', '"_c')
vim.keymap.set('n', 'cc', '"_cc')
vim.keymap.set('n', 'C', '"_C')
-- カットにはsを用いる
vim.keymap.set({ 'n', 'x' }, 's', 'd')
vim.keymap.set('n', 'ss', 'dd')
vim.keymap.set('n', 'S', 'D')


-- gJでスペースなしの行結合
-- vim.cmd [[
-- nnoremap <expr> gJ JointLinesWithNoSpaces()
--
-- function JointLinesWithNoSpaces(type = '') abort
--   if a:type == ''
--     set opfunc=JointLinesWithNoSpaces
--     return 'g@l'
--   endif
--   substitute/\n\s*//
-- endfunction
-- ]]
_G.JointLinesWithNoSpaces = function()
  -- カーソルの現在の行番号を取得（APIは0オリジン）
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  -- 現在の行と次の行を取得
  local lines = vim.api.nvim_buf_get_lines(0, row, row + 2, false)
  -- 次の行が存在しない（ファイルの最終行）場合は処理を抜ける
  if #lines < 2 then
    return
  end
  -- Luaのパターンマッチングを使って、次の行の先頭にある空白をすべて削除
  -- 2つの行を結合し、バッファを更新（2行を1行に置き換える）
  local new_line = lines[1] .. lines[2]:gsub("^%s*", "")
  vim.api.nvim_buf_set_lines(0, row, row + 2, false, { new_line })
end
-- gJキーのキーマップを設定
vim.keymap.set('n', 'gJ', function()
  vim.go.opfunc = "v:lua.JointLinesWithNoSpaces"
  -- 'g@l' を返すことで、1文字分のモーションに対してopfuncが実行される（ドットリピート対応）
  return "g@l"
end, { expr = true, desc = "Join lines without spaces" })


-- Escの2回押しで検索ハイライト解除
vim.keymap.set('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>')

vim.cmd [[

function! s:win_by_bufname(bufname) abort
    let bufmap = map(range(1, winnr('$')), '[bufname(winbufnr(v:val)), v:val]')
    let thewindow = filter(bufmap, 'v:val[0] =~ a:bufname')[0][1]
    execute thewindow.'wincmd w'
endfunction

command! -nargs=* WinGo call s:win_by_bufname(<q-args>)

]]
--
--
--

--  THESE ARE MANDATORY --
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
vim.cmd [[command! PC PackerCompile]]
vim.cmd [[command! PU PackerSync]]
vim.cmd(
    [[
    " You can delete these YAY

    command! CdInitnvimLINUX :cd /home/matiss/.config/nvim
    command! CdInitnvimWINDOWS :cd /mnt/c/Users/Matiss/AppData/Local/nvim/
    command! CdCode :cd /mnt/c/Users/Matiss/code/

]]
)

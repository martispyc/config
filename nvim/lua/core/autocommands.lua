local function make_autocmd(filetype, minimal, normal, size, def_nr) -- main function to do all of this
    local args = {
        "'"..filetype.."', '"..minimal.." <inp', 0",
        "'"..filetype.."', '"..normal.." <inp', "..size,
        "'"..filetype.."', '"..minimal.."', 0",
        "'"..filetype.."', '"..normal.."', "..size,
    }
    local autocmds = [[autocmd filetype ]]..filetype..[[ noremap <leader>r :call <sid>toggle_terminal(]]..args[def_nr]..[[) <CR>]];
    for i, arg in ipairs(args) do
        autocmds = autocmds..[[
            
        autocmd filetype ]]..filetype..[[ noremap <F]]..(i+3)..[[> :call <sid>toggle_terminal(]]..arg..[[) <CR>
        autocmd filetype ]]..filetype..[[ inoremap <F]]..(i+3)..[[> :call <sid>toggle_terminal(]]..arg..[[) <CR>

        ]]
    end 
    return autocmds;
end


vim.cmd([[

function! s:toggle_terminal(filetype, com, size) abort
    " The buffer will have the name 'term://{path}{command}' then we can just search for a buffer containing the commad
    if bufwinnr("RUN_PROCESS_FOR_".a:filetype) > 0 " if found
        execute "bd! RUN_PROCESS_FOR_".a:filetype
    endif

    execute "wa"
    if a:size == 0
       execute "split"
    else
       execute a:size."split"
    endif
    execute "term ".a:com
    execute "file RUN_PROCESS_FOR_".a:filetype
    execute "bufdo e"
    execute "startinsert"
endfunction

        autocmd TermOpen * setlocal nonu
        autocmd FocusGained * checktime
        autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
        autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
        augroup compileandrun
            autocmd!
]]

-- settings
-- F5...minimal w input
-- F6...normal w input
-- F7...minimal w/o input
-- F8...normal w/o input
--
-- function USE
-- Use autocmds(filtype, 'command to run with no flags, aka. "minimal" mode', 'command to run with all the flags, aka. "normal" mode', 'number of rows that the terminal will take in normal mode, 0 for content size', 'the def setting when using leader_r from all the four setting')


..make_autocmd("cpp", "g++ -std=c++17 -DONPC -O2 -o %< % && %<", "g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 -o %< % && ./%<", 4, 2)
..make_autocmd("python", "python3 %", "python3 %", 0, 4)
..make_autocmd("rust", "cargo run", "cargo run", 0, 4)
..make_autocmd("javascript", "node %", "node %", 0, 4)
..make_autocmd("typescript", "node %", "node %", 0, 4)
.."augroup END")




-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel", "lir" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
  end,
})

-- Remove statusline and tabline when in Alpha
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd [[
      set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

-- Set wrap and spell in markdown and gitcommit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Fixes Autocomment
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Highlight Yanked Text
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

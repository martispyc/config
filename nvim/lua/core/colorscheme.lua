---0------
vim.cmd(
  [[
try
  colorscheme tokyonight
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
)

-- TODO: Add a notification that something didnt work

return {
      cmd = {'emmet-language-server', '--stdio'},
      filetypes = {
          'html', 'typescriptreact', 'javascriptreact', 'javascript.jsx', 'typescript.tsx', 'css'
      },
      -- root_dir = require 'lspconfig/util'.root_pattern("package.json", ".git")
}

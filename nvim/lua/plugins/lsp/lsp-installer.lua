local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    vim.notify("PLUGIN NOT DETECTED: nvim-lsp-installer", "error")
	return
end
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("plugins.lsp.handlers").on_attach,
		capabilities = require("plugins.lsp.handlers").capabilities,
	}
    local available_configs = {
        "jsonls",
        "sumneko_lua",
        "rust-analyzer",
        -- "ccls",
        -- "pyright",
    }
    for _, s in ipairs(available_configs) do
        if s == server.name then
            local new_opts = require("plugins.lsp.settings."..server.name)
            server:setup(vim.tbl_deep_extend("force", new_opts, opts))
            break
        end
    end
    server:setup(opts)
	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
end)

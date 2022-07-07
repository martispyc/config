local configs = require("nvim-treesitter.configs")
configs.setup(
	{
		ensure_installed = {}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
		ignore_install = {""}, -- List of parsers to ignore installing
		highlight = {
			enable = true, -- false will disable the whole extension
			disable = {""}, -- list of language that will be disabled
			additional_vim_regex_highlighting = true
		},
		indent = {enable = true, disable = {"yaml"}},
		--rainbow = {
		--enable = true
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		-- extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		-- max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
		--},
		autotag = {
			enable = true
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				scope_incremental = "<CR>",
				node_incremental = "<TAB>",
				node_decremental = "<S-TAB>"
			}
		},
		refactor = {},
		textobjects = {
			lsp_interop = {
				enable = true,
				border = "none",
				peek_definition_code = {
					["df"] = "@function.outer",
					["dF"] = "@class.outer"
				}
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@call.outer"
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@call.outer"
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@call.outer"
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@call.outer"
				}
			},
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@call.outer",
					["ic"] = "@call.inner"
				}
			},
			swap = {
				enable = true,
				swap_next = {
					[",a"] = "@parameter.inner"
				},
				swap_previous = {
					[",A"] = "@parameter.inner"
				}
			}
		}
	}
)

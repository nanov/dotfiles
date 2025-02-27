-- neovide specifig
if vim.g.neovide then
	vim.g.neovide_input_macos_alt_is_meta = false
	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.0
	vim.g.transparency = 0.97
	vim.g.neovide_background_color = "#24283B" .. alpha()
end

-- tokyo night
lvim.colorscheme = "tokyonight-storm"

-- relativenumber
vim.opt.relativenumber = true

-- tabs no spaces NOTE: experimenting with 2 spaces width
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.foldmethod = "expr" -- default is "normal"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- default is ""
vim.opt.foldenable = false -- if this option is true and fold method option is other than normal, every time a document is opened everything will be folded.
lvim.builtin.which_key.setup.plugins.presets.z = true

-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
	{'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async', event='BufReadPost',
		init = function ()
			vim.o.foldcolumn = 'auto:9' -- '0' is not bad
			vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep:│,foldclose:'
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		config = function ()
			-- Option 2: nvim lsp as LSP client
			-- Tell the server the capability of foldingRange,
			-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
					dynamicRegistration = false,
					lineFoldingOnly = true
			}
			local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
			for _, ls in ipairs(language_servers) do
					require('lspconfig')[ls].setup({
							capabilities = capabilities
							-- you can add other fields for setting up lsp server in this table
					})
			end
			require("ufo").setup()
		end
	},
  { "letieu/hacker.nvim" },
  -- Harpoon https://github.com/ThePrimeagen/harpoon
  { "nvim-lua/plenary.nvim"},
  { "ThePrimeagen/harpoon" },
  -- DAP - debugger
  { "ldelossa/nvim-dap-projects" },
  { "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },

	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{ "hiphish/rainbow-delimiters.nvim" },

	{ "folke/zen-mode.nvim" },
  -- Useless but fun
  { "eandrju/cellular-automaton.nvim" },
	-- hint when you type
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function() require"lsp_signature".on_attach() end,
	},
}

function Toggle_haproon()
  local mark = require('harpoon.mark')
  local i = mark.get_current_index()
  mark.toggle_file(i)
end


lvim.keys.normal_mode["M"] = "<cmd>Man<cr>"

-- lvim.keys.normal_mode["<M-p>"] = '"0p'
	-- lvim.keys.normal_mode["p"] = '"0p'
lvim.keys.normal_mode["<C-c>"] = "<cmd>noh<cr>"
-- previous buffer Ctrl+^ is not usable because shift is needed in order to produce ^ on osx 😿
lvim.keys.normal_mode["<leader>6"] = "<cmd>b#<cr>"
-- Key Maps
lvim.keys.normal_mode["<leader>z"] = "<cmd>ZenMode<cr>"
-- More beautiful references
lvim.keys.normal_mode["<leader>lR"] = "<cmd>Telescope lsp_references<cr>"
-- Cellular Automation
lvim.keys.normal_mode["<leader>ml"] = "<cmd>CellularAutomaton make_it_rain<CR>";

-- Harpoon
 lvim.keys.normal_mode["<leader>a"] = "<cmd>lua Toggle_haproon()<cr>"
 lvim.keys.normal_mode["<C-p>"] = "<cmd>lua require(\"harpoon.ui\").toggle_quick_menu()<cr>"

-- Multiple Cursours
-- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
-- Functions for multiple cursors
vim.g.mc = vim.api.nvim_replace_termcodes([[y/\V<C-r>=escape(@", '/')<CR><CR>]], true, true, true)

lvim.keys.normal_mode["cn"] = "*``cgn"
lvim.keys.normal_mode["cN"] = "*``cgN"

lvim.keys.visual_mode["cn"] = { [[g:mc . "``cgn"]], { silent = true, expr = true }}
lvim.keys.visual_mode["cN"] = { [[g:mc . "``cgN"]], { silent = true, expr = true }}

vim.api.nvim_create_user_command('W', function(opts)
	vim.api.nvim_cmd({
		cmd = "w",
		bang = opts.bang,
		mods = { noautocmd = true },
		}, {})
end, { bang = true });


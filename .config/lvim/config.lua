-- tokyo night
lvim.colorscheme = "tokyonight-storm"

-- relativenumber
vim.opt.relativenumber = true

-- tabs no spaces NOTE: experimenting with 2 spaces width
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
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
  -- Useless but fun
  { "eandrju/cellular-automaton.nvim" },
}

function Toggle_haproon()
  local mark = require('harpoon.mark')
  local i = mark.get_current_index()
  mark.toggle_file(i)
end

-- Key Maps
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






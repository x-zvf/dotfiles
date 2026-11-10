vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.scrolloff = 5
vim.opt.spell = true
vim.opt.spelllang = { "en", "de", "hu" }
vim.opt.colorcolumn = { 81, 101, 121 }
vim.opt.mousescroll = "ver:1,hor:1"

vim.opt.tabstop = 8
vim.opt.softtabstop = -1
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>y", '"+y')

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/saghen/blink.lib",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/f-person/git-blame.nvim",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/nvim-tree/nvim-web-devicons", -- req. by lualine
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/SmiteshP/nvim-navic",
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/tpope/vim-surround",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/kevinhwang91/nvim-ufo",
  "https://github.com/kevinhwang91/promise-async",
  "https://github.com/chomosuke/typst-preview.nvim",
  "https://github.com/Olical/conjure",
})
require("vim._core.ui2").enable({})
require("lazydev").setup({})
require("typst-preview").setup({})

vim.g["conjure#mapping#doc_word"] = "<localleader>K"

require("oil").setup({
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },

  view_options = {
    show_hidden = true,
  },
})

vim.lsp.enable({
  "lua_ls",
  "clangd",
  "gopls",
  "pyright",
  "rust_analyzer",
  "emmet_language_server",
})

local cmp = require("blink.cmp")
cmp.setup({
  keymap = { preset = "default" },
  appearance = { nerd_font_variant = "mono" },

  completion = {
    ghost_text = {
      enabled = true,
    },
    documentation = { auto_show = true },
    menu = {
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
      },
    },
  },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
})

vim.g.gitblame_enabled = 0

require("nvim-navic").setup({
  click = true,
  highlight = true,
  depth_limit = 10,
  depth_limit_indicator = "...",
  separator = " > ",
  lsp = {
    auto_attach = true,
    preference = nil,
  },
})

local git_blame = require("gitblame")
require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      {
        "filename",
        file_status = true,
        path = 1,
        shorting_target = 20,
      },
    },
    lualine_c = { "diagnostics", { "navic", color_correction = nil } },
    lualine_x = {
      -- {
      --   git_blame.get_current_blame_text,
      --   cond = git_blame.is_blame_text_available,
      -- },
      "diff",
    },
    lualine_y = { "lsp_status", "filetype" },
    lualine_z = { "progress", "location" },
  },
})

vim.pack.add({})
local conform = require("conform")
conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "prettierd" },
    nix = { "nixfmt" },
    rust = { "rustfmt" },
    go = { "gofmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
  },
  formatters = {
    clang_format = {
      prepend_args = { "--style=file" },
    },
  },
})

local autoformat = true
vim.keymap.set("n", "<leader>cfe", function()
  autoformat = true
end, { desc = "[C]ode auto [F]ormat [E]nable" })

vim.keymap.set("n", "<leader>cfd", function()
  autoformat = false
end, { desc = "[C]ode auto [F]ormat [D]isable" })

vim.keymap.set("n", "<leader>cfb", function()
  conform.format({ async = true, lsp_fallback = true, timeout_ms = 2500 })
end, { desc = "[C]code auto [F]ormat [B]uffer" })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if autoformat then
      conform.format({ bufnr = args.buf, lsp_fallback = true, timeout_ms = 2500 })
    end
  end,
})

require("ufo").setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
  enable_get_fold_virt_text = true,
  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fs", builtin.search_history, { desc = "[F]ind [S]earch history" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })

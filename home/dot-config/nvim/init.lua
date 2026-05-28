vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 750
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.scrolloff = 5
vim.opt.spell = true
vim.opt.spelllang = { "en", "de", "hu" }
vim.opt.colorcolumn = { 81, 121 }
vim.opt.mousescroll = "ver:3,hor:1"

-- we are using vim-sleuth so these are only the fallback values
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>y", '"+y')

vim.keymap.set("n", "<leader>wh", "<C-w><C-h>", { desc = "[W]indow focus left" })
vim.keymap.set("n", "<leader>wl", "<C-w><C-l>", { desc = "[W]indow focus right" })
vim.keymap.set("n", "<leader>wj", "<C-w><C-j>", { desc = "[W]indow focus down" })
vim.keymap.set("n", "<leader>wk", "<C-w><C-k>", { desc = "[W]indow focus up" })
vim.keymap.set("n", "<leader>ww", "<CMD>split<CR>", { desc = "[W]indow split horizontal" })
vim.keymap.set("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "[W]indow split vertical" })

vim.keymap.set("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[t", "<cmd>bprevious<cr>", { desc = "Prev Tab" })
vim.keymap.set("n", "]t", "<cmd>bnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New Tab" })

vim.pack.add({ "https://github.com/EdenEast/nightfox.nvim" })
require("nightfox").setup({
  options = {
    transparent = true,
  },
})
vim.cmd.colorscheme("nightfox")

vim.pack.add({ "https://github.com/tpope/vim-sleuth" })

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
  -- "https://github.com/nvim-treesitter/nvim-treesitter-context",
})
require("nvim-treesitter").setup({
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(lang, buf)
      if lang == "svelte" then
        return false
      end
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
})
--require("treesitter-context").setup({
--    multiwindow=true,
--    mode = "topline",
--})

vim.pack.add({
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
})
require("lualine").setup({
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      {
        "filename",
        file_status = true,
        newfile_status = false,
        path = 1,
        shorting_target = 40,
      },
    },
    lualine_c = { "diff", "diagnostics", { "navic", color_correction = nil } },
    lualine_x = { "lsp_status" },
    lualine_y = { "filetype" },
    lualine_z = { "progress", "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})

vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })
require("tiny-inline-diagnostic").setup({
  preset = "powerline",
  options = {
    multilines = { enabled = true },
  },
})

vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
require("lazydev").setup({})

vim.pack.add({
  "https://github.com/saghen/blink.compat",
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
})
local blink = require("blink.cmp")
require("blink.compat").setup({})
blink.setup({
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
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" },
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

vim.pack.add({ "https://github.com/SmiteshP/nvim-navic" })
local navic = require("nvim-navic")
navic.setup({
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

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})
require("mason").setup({})
require("mason-lspconfig").setup({})
local language_servers = {
  lua_ls = {},
  clangd = {},
  arduino_language_server = {},
  gopls = {},
  templ = {},
  pyright = {},
  rust_analyzer = {},
  ts_ls = {},
  html = {
    filetypes = { "html", "templ", "svelte" },
  },
  htmx = {
    filetypes = { "html", "templ" },
  },
  emmet_language_server = {
    filetypes = {
      "templ",
      "svelte",
      "css",
      "eruby",
      "html",
      "javascript",
      "javascriptreact",
      "less",
      "sass",
      "scss",
      "pug",
      "typescriptreact",
    },
    init_options = {},
  },
  svelte = {},
  tailwindcss = { includeLanguages = { templ = "html" } },
  clojure_lsp = {},
  ltex_plus = {
    language = "en-GB",
    additionalRules = {
      languageModel = "/usr/share/ngrams/",
      enablePickyRules = true,
      motherTongue = "en-GB",
    },
    on_attach = function(_, _)
      require("ltex_extra").setup()
    end,
    filetypes = {
      -- "bibtex",
      "context",
      "context.tex",
      -- "html",
      "latex",
      "markdown",
      "org",
      "restructuredtext",
      "rsweave",
      "typst",
      "typ",
      "txt",
      "text",
    },
  },
  nil_ls = {},
  tinymist = {
    formatterMode = "typstyle",
    --exportPdf = "onType",
    formatterProseWrap = true,
    formatterPrintWidth = 100,
    formatterIndentSize = 4,
  },
}

for server, config in pairs(language_servers) do
  -- passing config.capabilities to blink.cmp merges with the capabilities in your
  -- `opts[server].capabilities, if you've defined it
  config.capabilities = blink.get_lsp_capabilities(config.capabilities)
  --lspconfig[server].setup(config)
  local prev_oa = config.on_attach
  config.on_attach = function(client, bufnr)
    if not prev_oa == nil then
      prev_oa(client, bufnr)
    end
    -- if client.server_capabilities.documentSymbolProvider then
    --   navic.attach(client, bufnr)
    -- end
  end

  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

vim.pack.add({
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-tree/nvim-web-devicons", -- dep
})
require("nvim-tree").setup({})
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle neovim tree" })

vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/f-person/git-blame.nvim",
  "https://github.com/tpope/vim-fugitive",
})
require("gitsigns").setup({})

vim.pack.add({ "https://github.com/olrtg/nvim-emmet" })
vim.keymap.set({ "n", "v" }, "<leader>xe", require("nvim-emmet").wrap_with_abbreviation)

vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
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

local autoformat = false
vim.keymap.set("n", "<leader>fae", function()
  autoformat = true
end, { desc = "[F]ormat [A]utomatically on save [E]nable" })

vim.keymap.set("n", "<leader>fad", function()
  autoformat = false
end, { desc = "[F]ormat [A]utomatically on save [D]isable" })

vim.keymap.set("n", "<leader>fb", function()
  conform.format({ async = true, lsp_fallback = true, timeout_ms = 2500 })
end, { desc = "[F]ormat [B]uffer" })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if autoformat then
      conform.format({ bufnr = args.buf, lsp_fallback = true, timeout_ms = 2500 })
    end
  end,
})

vim.pack.add({ "https://github.com/folke/trouble.nvim" })
require("trouble").setup({ use_diagnostic_signs = true })
vim.keymap.set("n", "<leader>tda", "<cmd>Trouble diagnostics toggle<cr>", { desc = "[T]rouble [D]iagnostics [A]ll" })
vim.keymap.set(
  "n",
  "<leader>td",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "[T]rouble [D]iagnostics (buf)" }
)
vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "[T]rouble [S]ymbols" })
vim.keymap.set(
  "n",
  "<leader>tls",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "[T] [LS]P Definitions / references / ..." }
)
vim.keymap.set("n", "<leader>tll", "<cmd>Trouble loclist toggle<cr>", { desc = "[T]rouble [L]ocation List" })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { desc = "[T]rouble [Q]uickfix List" })

vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})
require("which-key").setup({
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "a", mode = { "n", "v" } },
  },
})

vim.pack.add({
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

vim.pack.add({
  "https://github.com/kevinhwang91/nvim-ufo",
  "https://github.com/kevinhwang91/promise-async",
})

vim.opt.foldcolumn = '1'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:'

local ufo = require('ufo')
ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end,
    enable_get_fold_virt_text = true,

    fold_virt_text_handler = 
    function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
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
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

})
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

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
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>s/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    local buf = event.data and event.data.bufnr or event.buf

    local ft = vim.bo[buf].filetype
    if ft == "javascriptreact" or ft == "typescriptreact" then
      vim.treesitter.start(buf, "tsx")
      vim.bo[buf].syntax = "ON"
    elseif ft == "svelte" then
      vim.treesitter.start(buf, "svelte")
      vim.bo[buf].syntax = "ON"
    elseif ft == "templ" then
      vim.treesitter.start(buf, "templ")
      vim.bo[buf].syntax = "ON"
    end

    map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("gr", builtin.lsp_references, "[G]oto [R]eferences")
    map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
    map("gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
    map("K", function()
      return vim.lsp.buf.hover()
    end, "Hover")
    map("<leader>D", builtin.lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client == nil then
      return
    end
    if client:supports_method("textDocument/documentHighlight") then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    if client:supports_method("textDocument/inlayHint") then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end

    if client:supports_method("textDocument/documentSymbol") then
      navic.attach(client, buf)
    end
  end,
})

vim.pack.add({
  "https://github.com/chomosuke/typst-preview.nvim",
})
require("typst-preview").setup({})

vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { svelte = "svelte" } })

vim.pack.add({ "https://github.com/folke/trouble.nvim" })
require("trouble").setup({
  use_diagnostic_signs = true,
})

vim.keymap.set("n", "<leader>tda", "<cmd>Trouble diagnostics toggle<cr>", { desc = "[T]rouble [D]iagnostics [A]ll" })
vim.keymap.set(
  "n",
  "<leader>td",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "[T]rouble [D]iagnostics (buf)" }
)
vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "[T]rouble [S]ymbols" })
vim.keymap.set(
  "n",
  "<leader>tls",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "[T] [LS]P Definitions / references / ..." }
)
vim.keymap.set("n", "<leader>tll", "<cmd>Trouble loclist toggle<cr>", { desc = "[T]rouble [L]ocation List" })
vim.keymap.set("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { desc = "[T]rouble [Q]uickfix List" })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command("LTexSetLang", function(opts)
  local clients = vim.lsp.get_clients({ buffer = 0 })

  for _, client in ipairs(clients) do
    if client.name == "ltex_plus" then
      client.config.settings.ltex.language = tostring(opts.fargs[1])
      vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = client.config.settings })
      return
    end
  end
end, { nargs = 1 })

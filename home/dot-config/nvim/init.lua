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
vim.keymap.set("n", "<leader>ws", "<CMD>split<CR>", { desc = "[W]indow [S]plit horizontal" })
vim.keymap.set("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "[W]indow split [V]ertical" })
vim.keymap.set("n", "<leader>wt", "<cmd>tabnew<cr>", { desc = "[W]indow new [T]ab" })

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
vim.keymap.set("n", "<leader>uf", "<cmd>NvimTreeToggle<CR>", { desc = "[U]I [F]iletree toggle" })

vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/f-person/git-blame.nvim",
  "https://github.com/tpope/vim-fugitive",
})
require("gitsigns").setup({})

vim.pack.add({ "https://github.com/olrtg/nvim-emmet" })
vim.keymap.set({ "n", "v" }, "<leader>ce", require("nvim-emmet").wrap_with_abbreviation, { desc = "[C]ode [E]mmet" })

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

vim.pack.add({ "https://github.com/folke/trouble.nvim" })
require("trouble").setup({ use_diagnostic_signs = true })
vim.keymap.set(
  "n",
  "<leader>utda",
  "<cmd>Trouble diagnostics toggle<cr>",
  { desc = "[U]I [T]rouble [D]iagnostics [A]ll" }
)
vim.keymap.set(
  "n",
  "<leader>utdb",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "[U]I [D]iagnostics [B]uffer" }
)
vim.keymap.set("n", "<leader>uts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "[U]I [T]rouble [S]ymbols" })
vim.keymap.set(
  "n",
  "<leader>uti",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "[U]I [T]rouble lsp [I]for (Definitions / references / ...)" }
)

vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})
require("which-key").setup({
  triggers = {
    { "<auto>", mode = "nixsotc" },
    { "a", mode = { "n", "v" } },
  },
  spec = {
    { "<leader>w", group = "[W]indow" },
    { "<leader>c", group = "[C]ode" },
    { "<leader>cf", group = "[C]ode [F]ormat" },
    { "<leader>u", group = "[U]I" },
    { "<leader>ut", group = "[U]I [T]rouble" },
    { "<leader>f", group = "[F]ind" },
    { "<leader>l", group = "[L]sp" },
    { "<leader>lg", group = "[L]sp [G]oto" },
    { "<leader>ls", group = "[L]sp [S]ymbols" },
    { "<leader>d", group = "[D]ebugger" },
    { "<leader>ds", group = "[D]ebugger [S]tep" },
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

vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldinner: ,foldclose:"

local ufo = require("ufo")
ufo.setup({
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
vim.keymap.set("n", "zR", ufo.openAllFolds)
vim.keymap.set("n", "zM", ufo.closeAllFolds)

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
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>f/", function()
  builtin.live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[F]ind [/] in open files" })

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

    map("<leader>lgd", builtin.lsp_definitions, "[L]sp [G]oto [D]efinition")
    map("<leader>lgD", vim.lsp.buf.declaration, "[L]sp [G]oto [D]eclaration")
    map("<leader>lgr", builtin.lsp_references, "[L]sp [G]oto [R]eferences")
    map("<leader>lgI", builtin.lsp_implementations, "[L]sp [G]oto [I]mplementation")
    map("<leader>lgy", builtin.lsp_type_definitions, "[L]sp [G]oto T[y]pe Definition")
    map("<leader>lgi", builtin.lsp_incoming_calls, "[L]sp [G]oto [I]coming calls")
    map("<leader>lgo", builtin.lsp_incoming_calls, "[L]sp [G]oto [O]utgoing calls")
    map("K", function()
      return vim.lsp.buf.hover()
    end, "Hover")
    map("<leader>lsd", builtin.lsp_document_symbols, "[L]sp [S]ymbols [D]ocument")
    map("<leader>lsw", builtin.lsp_dynamic_workspace_symbols, "[L]sp [S]ymbols [W]orkspace")
    map("<leader>lr", vim.lsp.buf.rename, "[L]sp [R]ename")
    map("<leader>lc", vim.lsp.buf.code_action, "[L]sp [C]ode action")
    map("<leader>lh", vim.lsp.buf.signature_help, "[L]sp signature [H]elp")

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
      map("<leader>li", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[L]sp [I]nlay hints toggle")
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

vim.pack.add({
  "https://codeberg.org/mfussenegger/nvim-dap",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/theHamsta/nvim-dap-virtual-text",

  "https://github.com/nvim-neotest/nvim-nio",
  "https://codeberg.org/mfussenegger/nvim-dap-python",
  "https://github.com/leoluz/nvim-dap-go",
})
local dap = require("dap")
local dapui = require("dapui")
dapui.setup({})
require("nvim-dap-virtual-text").setup({
  all_references = true,
  clear_on_continue = true,
  display_callback = function(variable, buf, stackframe, node, options)
    local val = variable.value:gsub("%s+", " ")
    if string.len(val) > 20 then
      return " " .. string.sub(val, 1, 17) .. "... "
    end
    return " " .. val
  end,
})
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebugger [B]reakpoint toggle" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebugger [C]ontinue" })
vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "[D]ebugger re[s]tart" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "[D]ebugger [T]erminate" })
vim.keymap.set("n", "<leader>dsc", dap.run_to_cursor, { desc = "[D]ebugger [S]tep (run) to [C]ursor" })
vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "[D]ebugger [S]tep [I]nto <F1>" })
vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "[D]ebugger [S]tep [O]ver <F2>" })
vim.keymap.set("n", "<leader>dsu", dap.step_out, { desc = "[D]ebugger [S]tep [U]p (over) <F3>" })
vim.keymap.set("n", "<leader>dsb", dap.step_back, { desc = "[D]ebugger [S]tep [B]ackwards <F4>" })

vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Step out" })
vim.keymap.set("n", "<F4>", dap.step_back, { desc = "Step backwards" })

vim.keymap.set({ "n", "v" }, "<leader>de", function()
  dapui.eval(nil, { enter = true })
end, { desc = "[D]ebugger [E]val word/region" })

dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = {}, -- provide arguments if needed
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "gdb",
    request = "attach",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    pid = function()
      local name = vim.fn.input("Executable name (filter): ")
      return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Attach to gdbserver :1234",
    type = "gdb",
    request = "attach",
    target = "localhost:1234",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
}
dap.configurations.cpp = dap.configurations.c

dap.configurations.rust = {
  {
    name = "Launch",
    type = "rust-gdb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = {}, -- provide arguments if needed
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = "Select and attach to process",
    type = "rust-gdb",
    request = "attach",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    pid = function()
      local name = vim.fn.input("Executable name (filter): ")
      return require("dap.utils").pick_process({ filter = name })
    end,
    cwd = "${workspaceFolder}",
  },
  {
    name = "Attach to gdbserver :1234",
    type = "rust-gdb",
    request = "attach",
    target = "localhost:1234",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
  },
}

require("dap-go").setup({
    dap_configurations = {
    {
      type = "go",
      name = "Attach delve air",
      mode = "remote",
      host = "127.0.0.1",
      port = 38697,
      request = "attach",
    },
  },
})
require("dap-python").setup("python3")

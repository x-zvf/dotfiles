local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

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

-- we are using vim-sleuth so these are only the fallback values
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- folding
--vim.opt.foldmethod = "expr"
--vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--vim.opt.foldenable = false

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

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

local autoformat = true

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- theming
    {
      "EdenEast/nightfox.nvim",
      config = function()
        vim.cmd.colorscheme("carbonfox")
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = {
          theme = "carbonfox",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
      },
    },

    --
    { "tpope/vim-sleuth" },
    {
      "folke/trouble.nvim",
      opts = { use_diagnostic_signs = true },
      keys = {
        { "<leader>tda", "<cmd>Trouble diagnostics toggle<cr>", desc = "[T]rouble [D]iagnostics [A]ll" },
        {
          "<leader>td",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "[T]rouble [D]iagnostics (buf)",
        },
        { "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "[T]rouble [S]ymbols" },
        {
          "<leader>tls",
          "<cmd>Troublejlsp toggle focus=false win.position=right<cr>",
          desc = "[T] [LS]P Definitions / references / ...",
        },
        { "<leader>tll", "<cmd>Trouble loclist toggle<cr>", desc = "[T]rouble [L]ocation List" },
        { "<leader>tq", "<cmd>Trouble qflist toggle<cr>", desc = "[T]rouble [Q]uickfix List" },
      },
    },
    {
      "saghen/blink.cmp",
      -- optional: provides snippets for the snippet source
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "1.*",
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = { preset = "default" },
        appearance = { nerd_font_variant = "mono" },

        completion = { documentation = { auto_show = true } },
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
      },
      opts_extend = { "sources.default" },
    },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {},
      dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
      },
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = { "saghen/blink.cmp" },

      opts = {
        servers = {
          lua_ls = {},
          clangd = {},
          arduino_language_server = {},
          gopls = {},
          pyright = {},
          rust_analyzer = {},
          ts_ls = {},
          emmet_language_server = {},
          tailwindcss = {},
          clojure_lsp = {},
          ltex = {
            language = "en-GB",
            additionalRules = {
              languageModel = "/usr/share/ngrams/",
              enablePickyRules = true,
              motherTongue = "de-DE",
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
            },
          },
          nil_ls = {},
          tinymist = {
            formatterMode = "typstyle",
            exportPdf = "onType",
          },
        },
      },
      config = function(_, opts)
        -- local lspconfig = require("lspconfig")
        for server, config in pairs(opts.servers) do
          -- passing config.capabilities to blink.cmp merges with the capabilities in your
          -- `opts[server].capabilities, if you've defined it
          config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
          --lspconfig[server].setup(config)
          vim.lsp.enable(server)
          vim.lsp.config(server, config)
        end
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
      },
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {},
      },

      {
        "rachartier/tiny-inline-diagnostic.nvim",
        opts = {
          preset = "powerline",
          options = {
            multilines = { enabled = true },
          },
        },
      },
    },
    --{ "anurag3301/nvim-platformio.lua", opts = {} },
    { "folke/lazydev.nvim", ft = "lua", opts = {} },
    {
      "stevearc/conform.nvim",
      opts = {
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
      },
      keys = {
        {
          "<leader>fae",
          function()
            autoformat = true
          end,
          desc = "[F]ormat [A]utomatically] on save [E]nable",
        },
        {
          "<leader>fad",
          function()
            autoformat = false
          end,
          desc = "[F]ormat [A]utomatically on save [D]isable",
        },
        {
          "<leader>fb",
          function()
            require("conform").format({ async = true, lsp_fallback = true })
          end,
          desc = "[F]ormat [B]uffer",
        },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  install = { colorscheme = { "carbonfox" } },
  checker = { enabled = true },
  defaults = { lazy = false },
})

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
    if client.name == "ltex" then
      client.config.settings.ltex.language = opts.fargs[1]
      vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = client.config.settings })
      return
    end
  end
end, { nargs = 1 })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if autoformat then
      require("conform").format({ bufnr = args.buf })
    end
  end,
})

local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")
telescope.setup({
  defaults = {
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
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
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
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
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

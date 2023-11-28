-- Creator : Zer0G0ld
-- collaborator : BinSys
--==================================--

---------------------------------
-- Opções
---------------------------------
local set = vim.opt

set.background = "dark"
set.clipboard = "unnamedplus"
set.completeopt = "noinsert,menuone,noselect"
set.cursorline = true
set.expandtab = true
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldmethod = "manual"
set.hidden = true
set.inccommand = "split"
set.mouse = "a"
set.number = true
set.relativenumber = true
set.shiftwidth = 2
set.smarttab = true
set.splitbelow = true
set.splitright = true
set.swapfile = false
set.tabstop = 2
set.termguicolors = true
set.title = true
set.ttimeoutlen = 0
set.updatetime = 250
set.wildmenu = true
set.wrap = true

vim.cmd([[
  filetype plugin indent on
  syntax on
]])

---------------------------------
-- Plugins
---------------------------------
local packer = require("packer")

-- Inclusão do packer.nvim no Neovim
vim.cmd([[packadd packer.nvim]])

packer.startup(function()
  -- Plugins são listados aqui
  use("wbthomason/packer.nvim")
    -- Auto-completar
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/nvim-cmp")
  -- Motor de snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  -- Formatação
  use("jose-elias-alvarez/null-ls.nvim")
  -- Servidor de linguagens
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  -- Analisador de sintaxe
  use("nvim-treesitter/nvim-treesitter")
  -- Gerenciador de plugins
  use("wbthomason/packer.nvim")
  -- Utilitários
  use("windwp/nvim-autopairs")
  use("norcalli/nvim-colorizer.lua")
  use("lewis6991/gitsigns.nvim")
  -- Dependências
  use("nvim-lua/plenary.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("MunifTanjim/nui.nvim")
  -- Navegador de arquivos
  use("nvim-telescope/telescope.nvim")
  -- Interface
  use("akinsho/bufferline.nvim")
  use({ "nvim-neo-tree/neo-tree.nvim", branch = "v2.x" })
  use("nvim-lualine/lualine.nvim")
  -- Tema
  use("elvessousa/sobrio")
end)

--------------------------------
-- Plugins
---------------------------------
-- Autopairs
require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt" },
})

-- Colorizer
require("colorizer").setup()

-- Git signs
require("gitsigns").setup()

-- Bufferline
require("bufferline").setup()

-- Lualine
require("lualine").setup()

-- Neo tree
require("neo-tree").setup({
  close_if_last_window = false,
  enable_diagnostics = true,
  enable_git_status = true,
  popup_border_style = "rounded",
  sort_case_insensitive = false,
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
  window = { width = 30 },
})

---------------------------------
-- Esquema de cores e sintaxe
---------------------------------
vim.cmd([[
  filetype plugin indent on
  syntax on
  colorscheme sobrio
]])

---------------------------------
-- Sintaxe
---------------------------------
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "elixir",
    "fish",
    "graphql",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "php",
    "python",
    "regex",
    "ruby",
    "rust",
    "scss",
    "sql",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "yaml",
  },
  highlight = { enable = true },
  indent = { enable = true },
  autotag = {
  enable = true,
  filetypes = {
    "html",
    "javascript",
    "javascriptreact",
    "svelte",
    "typescript",
    "typescriptreact",
    "vue",
    "xml",
  },
  },
})


---------------------------------
-- Auto-completar
---------------------------------
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Configuração para tipos específicos de arquivo
cmp.setup.filetype("gitcommit", {
  sources = cmp.config.sources({
    { name = "cmp_git" },
  }, {
    { name = "buffer" },
  }),
})

-- Auto-completar do modo de comando
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

---------------------------------
-- Formatação
---------------------------------
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
  sources = {
    formatting.black,
    formatting.rustfmt,
    formatting.phpcsfixer,
    formatting.prettier,
    formatting.stylua,
  },
  on_attach = function(client, bufnr)
    if client.name == "tsserver" or client.name == "rust_analyzer" or client.name == "pyright" then
      client.resolved_capabilities.document_formatting = false
    end

    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        -- buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
    })
    end
  end,
})

---------------------------------
-- Auto commands
---------------------------------
vim.cmd([[ autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync() ]])


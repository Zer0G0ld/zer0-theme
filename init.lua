-- Arquivo: ~/.config/nvim/init.lua

-- Carrega o Packer antes de qualquer outra configuração
vim.cmd [[packadd packer.nvim]]

-- Instalação do Packer (se ainda não estiver instalado)
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Configuração do Packer
local packer = require('packer')

packer.startup(function()
    -- Instalação do Packer (se ainda não estiver instalado)
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    end

    -- Configurações e plugins do Packer
    use 'nvim-lua/plenary.nvim' -- Biblioteca Lua usada por alguns plugins
    use 'nvim-telescope/telescope.nvim' -- Plugin de pesquisa e navegação
    use 'hrsh7th/nvim-cmp' -- Plugin de conclusão automática
    use 'neovim/nvim-lspconfig' -- Configurações para LSP (Language Server Protocol)

    -- Se você quiser adicionar mais plugins, siga o padrão:
    -- use 'nome_do_autor/nome_do_plugin'
end)

-- Configurações básicas
vim.cmd('set background=dark')
vim.cmd('set number')

-- Configuração do nvim-cmp
local cmp = require('cmp')
cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
})

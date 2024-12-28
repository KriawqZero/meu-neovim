-- ### INÍCIO: Configuração do nvim-tree ###
require('nvim-tree').setup({
    sort_by = "case_sensitive", -- Ordena por nomes de arquivos (sensível ao caso)
    view = {
        width = 30,              -- Largura da árvore de arquivos
        side = "left",           -- Posiciona no lado esquerdo
    },
    renderer = {
        group_empty = true,      -- Agrupa diretórios vazios
        icons = {
            git_placement = "after", -- Mostra ícones de Git após os nomes
        },
    },
    filters = {
        dotfiles = false,        -- Não filtrar arquivos ocultos
    },
    git = {
        enable = true,           -- Ativar integração com Git
        ignore = false,          -- Mostrar arquivos ignorados pelo Git
    },
    actions = {
        open_file = {
            quit_on_open = true, -- Fecha o Nvim-Tree ao abrir um arquivo
        },
        remove_file = {
            close_window = false -- Não fecha ao remover arquivos
        },
    },
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Mapeamentos para navegação
        vim.keymap.set('n', '<leader>cd', api.tree.change_root_to_node)
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts)
        vim.keymap.set('n', 'o', api.node.open.edit, opts)
        vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts)
        vim.keymap.set('n', 'u', api.node.navigate.parent, opts)

        -- Manipulação de arquivos
        vim.keymap.set('n', 'a', api.fs.create, opts) -- Criar arquivo/pasta
        vim.keymap.set('n', 'r', api.fs.rename, opts) -- Renomear
        vim.keymap.set('n', 'd', api.fs.remove, opts) -- Remover arquivo/pasta

        -- Atualizar a árvore
        vim.keymap.set('n', 'R', api.tree.reload, opts)
    end,
})
-- ### FIM: Configuração do nvim-tree ###

-- ### INÍCIO: Configuração do nvim-cmp ###
local cmp = require'cmp'
local lspconfig = require'lspconfig'
local cmp_nvim_lsp = require'cmp_nvim_lsp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- Para usuários de `vsnip`
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },  -- Para usuários de `vsnip`
        { name = 'buffer' },
    }),
    formatting = {
        fields = { "abbr", "kind", "menu" },
    },
    experimental = {
        ghost_text = true,
    },
    completion = {
        completeopt = 'menu,menuone,noselect',
        max_item_count = 5, -- Limite de sugestões exibidas
    }
})
-- ### FIM: Configuração do nvim-cmp ###

-- ### INÍCIO: Configuração do LSP ###
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.intelephense.setup{
    capabilities = capabilities
}

lspconfig.html.setup{
    capabilities = capabilities
}
lspconfig.cssls.setup{
    capabilities = capabilities
}
lspconfig.ts_ls.setup{
    capabilities = capabilities
}

lspconfig.clangd.setup{
    capabilities = capabilities
}

lspconfig.pyright.setup{
    capabilities = capabilities
}

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })
-- ### FIM: Configuração do LSP ###

-- ### INÍCIO: Configuração do toggleterm ###
require("toggleterm").setup({
    shell = "powershell",
    open_mapping = [[<S-Tab>]], -- Tecla para abrir o terminal
    direction = "horizontal", -- Opções: 'float', 'horizontal', 'vertical'
    float_opts = {
        border = "curved",
    },
})
-- ### FIM: Configuração do toggleterm ###

-- ### INÍCIO: Autoclose ###
require("autoclose").setup()
-- ### FIM: Autoclose ###

-- ### INÍCIO: Comandos para abrir arquivos de configuração ###
local os_type = vim.fn.has('unix') == 1 and 'unix' or vim.fn.has('win32') == 1 and 'windows' or vim.fn.has('mac') == 1 and 'macos' or 'unknown'
local init_vim_path = ""
local init_lua_path = ""
local neovide_settings_path = ""

if os_type == 'unix' then
    init_vim_path = vim.fn.expand('$HOME') .. '/.config/nvim/init.vim'
    init_lua_path = vim.fn.expand('$HOME') .. '/.config/nvim/init.lua'
    neovide_settings_path = vim.fn.expand('$HOME') .. '/.config/neovide/neovide-settings.json'
elseif os_type == 'windows' then
    init_vim_path = vim.fn.expand('$HOME') .. '\\AppData\\Local\\nvim\\init.vim'
    init_lua_path = vim.fn.expand('$HOME') .. '\\AppData\\Local\\nvim\\init.lua'
    neovide_settings_path = vim.fn.expand('$HOME') .. '\\AppData\\Local\\neovide\\neovide-settings.json'
elseif os_type == 'macos' then
    init_vim_path = vim.fn.expand('$HOME') .. '/.config/nvim/init.vim'
    init_lua_path = vim.fn.expand('$HOME') .. '/.config/nvim/init.lua'
    neovide_settings_path = vim.fn.expand('$HOME') .. '/.config/neovide/neovide-settings.json'
else
    print("Sistema operacional desconhecido.")
    return
end

vim.api.nvim_command('command InitVim edit ' .. init_vim_path)
vim.api.nvim_command('command InitLua edit ' .. init_lua_path)
-- vim.api.nvim_command('command InitVide edit ' .. neovide_settings_path)
-- ### FIM: Comandos para abrir arquivos de configuração ###

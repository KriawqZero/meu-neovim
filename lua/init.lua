-- ### INICÍO: Configuração do telescope
require("telescope").setup({
  defaults = { 
    file_ignore_patterns = { 
      "node_modules",
      "dist",
      ".git",
      "vendor" 
    },
    hidden = true,
  }
})
-- ### FIM: Configuração do telescope


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



-- ### INÍCIO: Configuração do Treesitter ###
require'nvim-treesitter.install'.prefer_git = false
require'nvim-treesitter.install'.compilers = { 'clang', 'gcc' }
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c", "cpp", "c_sharp", "php", "blade", "html",
        "lua", "json", "css", "javascript", "typescript",
        "markdown", "python", "bash", "vim", "yaml",
        "regex", "comment", "query", "dockerfile",
        "rust", "java", "toml", "tsx", "vue",
        "svelte", "graphql", "scss", "dart", "swift",
        "ruby", "go", "haskell", "ocaml", "elm",
        "nix", "scala", "kotlin", "zig", "julia",
        "json",
    }, -- Linguagens que você usa frequentemente ou são relevantes
    highlight = {
        enable = true,              -- Habilita o highlight com base no Treesitter
        additional_vim_regex_highlighting = true, -- Desativa regex do Vim para melhor desempenho
    },
    indent = {
        enable = true,              -- Habilita indentação automática
    },
    incremental_selection = {
        enable = true,              -- Permite seleção incremental
        keymaps = {
            init_selection = "gnn", -- Inicia seleção incremental
            node_incremental = "grn", -- Expande seleção ao próximo nó
            node_decremental = "grm", -- Reduz seleção ao nó anterior
            scope_incremental = "grc", -- Expande seleção ao próximo escopo
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,       -- Move automaticamente para o próximo texto relevante
            keymaps = {
                ["af"] = "@function.outer", -- Seleciona função inteira
                ["if"] = "@function.inner", -- Seleciona dentro da função
                ["ac"] = "@class.outer",    -- Seleciona classe inteira
                ["ic"] = "@class.inner",    -- Seleciona dentro da classe
            },
        },
    },
}

-- ### FIM: Configuração do Treesitter ###


-- ### INÍCIO: Configuração do LSP ###
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.intelephense.setup{
    capabilities = capabilities
    -- settings = {
    --     -- intelephense = {
        --     diagnostics = {
        --         undefinedMethods = false,
        --         undefinedProperties = false
        --     }
        -- }
    -- }
}

lspconfig.html.setup{
    capabilities = capabilities
}

lspconfig.cssls.setup{
    capabilities = capabilities
}

-- Configuração para HTML
lspconfig.html.setup {
    capabilities = capabilities,
}

lspconfig.ts_ls.setup{
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false -- Desativa formatação para evitar conflitos com formatadores externos
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    end,
}
-- Configuração para ESLint (opcional, mas recomendada para TypeScript/JavaScript)
lspconfig.eslint.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    end,
}

lspconfig.clangd.setup{
    capabilities = capabilities
}

lspconfig.pyright.setup{
    capabilities = capabilities
}

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true, silent = true })

-- ### FIM: Configuração do LSP ###





-- ### INÍCIO: Configuração do nvim-tree ###
require('nvim-tree').setup({
    sort_by = "case_sensitive", -- Ordena por nomes de arquivos (sensível ao caso)
    view = {
        width = 40,              -- Largura da árvore de arquivos
        side = "left",           -- Posiciona no lado esquerdo
    },
    renderer = {
        group_empty = true,      -- Agrupa diretórios vazios
        icons = {
            git_placement = "before", -- Mostra ícones de Git após os nomes
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
            quit_on_open = false, -- Fecha o Nvim-Tree ao abrir um arquivo
        },
        remove_file = {
            close_window = false -- Não fecha ao remover arquivos
        },
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
    },
    on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- Mapeamentos para navegação
        vim.keymap.set('n', '<leader>c', api.tree.change_root_to_node)
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


-- ### INICIO: Configuração do Ident Blankline ###
vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#cccccc", nocombine = true }) -- Linhas verticais claras
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#aaaaaa", nocombine = true }) -- Contexto mais claro

require("ibl").setup {
    indent = {
        char = "│", -- Define o caractere usado para as linhas verticais
        highlight = "IndentBlanklineChar", -- Usa o destaque configurado acima
    },
    scope = {
        show_start = false, -- Desativa o início do escopo
        show_end = false,   -- Desativa o final do escopo
        highlight = { "IndentBlanklineContextChar" }, -- Destaque para o contexto
    },
    exclude = {
        filetypes = { "help", "dashboard", "lazy", "mason" }, -- Evita linhas em certos arquivos
    },
}
-- ### FIM: Configuração do Ident Blankline ###



-- ### Configuração pra formatador blade
-- local null_ls = require("null-ls")
--
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.formatting.blade_formatter.with({
--             command = "blade-formatter", -- Usa o comando instalado globalmente pelo yarn
--         }),
--         null_ls.builtins.diagnostics.eslint_d,
--         null_ls.builtins.code_actions.eslint_d,
--         null_ls.builtins.formatting.prettier, -- ou eslint_d para formatação
--     },
-- })
--
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>f",
--   ":lua vim.lsp.buf.format({ async = true })<CR>",
--   { noremap = true, silent = true }
-- )

-- ### FIM

-- ### INÍCIO: Configuração do toggleterm ###
require("toggleterm").setup({
    shell = "powershell",
    open_mapping = [[<S-Tab>]], -- Tecla para abrir o terminal
    direction = "horizontal", -- Opções: 'float', 'horizontal', 'vertical'
    start_in_insert = true,    -- Inicia sempre em modo inserção
    insert_mappings = true,    -- Mapeamentos em modo inserção
    terminal_mappings = true,  -- Mapeamentos no terminal,
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

if os_type == 'unix' or os_type == 'macos' then
    init_vim_path = vim.fn.expand('$HOME') .. '/.config/nvim/init.vim'
    init_lua_path = vim.fn.expand('$HOME') .. '/.config/nvim/lua/init.lua'
    neovide_settings_path = vim.fn.expand('$HOME') .. '/.config/neovide/neovide-settings.json'
elseif os_type == 'windows' then
    init_vim_path = vim.fn.expand('$HOME') .. '\\AppData\\Local\\nvim\\init.vim'
    init_lua_path = vim.fn.expand('$HOME') .. '\\AppData\\Local\\nvim\\lua\\init.lua'
    neovide_settings_path = vim.fn.expand('$HOME') .. '\\AppData\\Local\\neovide\\neovide-settings.json'
else
    print("Sistema operacional desconhecido.")
    return
end

vim.api.nvim_command('command InitVim edit ' .. init_vim_path)
vim.api.nvim_command('command InitLua edit ' .. init_lua_path)
-- vim.api.nvim_command('command InitVide edit ' .. neovide_settings_path)
-- ### FIM: Comandos para abrir arquivos de configuração ###

-- ### Configuração do tema Catppuccin ###
require("catppuccin").setup({
    flavour = "macchiato", -- Usando o tema macchiato
    background = { 
        light = "latte",
        dark = "macchiato", -- Mantém o fundo como 'macchiato'
    },
})

require("monokai-pro").setup({
    filter = "spectrum",
})

-- Aplica o esquema de cores após configurar
vim.cmd.colorscheme "monokai-pro"

-- Altera a cor do fundo para #141414 após carregar o tema
-- vim.api.nvim_set_hl(0, "Normal", { bg = "#141414" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#141414" })

-- ## FIM: Configuração do tema cattpuccin ###

require("bufferline").setup{}

require('barbecue').setup {
  theme = 'monokai-pro'
}

require('plugins.lualine.evil_lualine')

-- -- Configuração do Lualine com tema Monokai-Pro e seções customizadas
-- require('lualine').setup {
--   options = {
--     theme = 'monokai-pro',  -- Tema para a barra de status
--     section_separators = {'', ''},  -- Separadores de seções
--     component_separators = {'', ''},  -- Separadores entre os componentes
--     icons_enabled = true,   -- Habilita ícones nos componentes
--   },
--   sections = {
--     lualine_b = {'branch', 'diff', 'diagnostics'},  -- Seção do meio com branch, diffs e diagnósticos
--     lualine_c = {'filename', 'filetype'},  -- Nome do arquivo e tipo de arquivo
--     lualine_x = {'encoding', 'fileformat', 'location'},  -- Informações de codificação, formato de arquivo e localização
--     lualine_y = {'progress'},  -- Progresso da linha no arquivo
--     lualine_z = {'time'},  -- Hora atual
--   },
--   inactive_sections = {
--     lualine_b = {},
--     lualine_c = {'filename'},  -- Apenas o nome do arquivo quando o buffer está inativo
--     lualine_x = {'location'},  -- Localização do cursor
--     lualine_y = {},
--     lualine_z = {},
--   },
--   extensions = {'fugitive'}  -- Extensão para integrar com o Git
-- }
--


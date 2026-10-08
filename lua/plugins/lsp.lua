-- ==========================================================================
--  LSP (Language Server Protocol) Configuration
--  Configured for Bash, Python, Golang, and Lua
-- ==========================================================================

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspRestart", "LspStart", "LspStop" },
  dependencies = {
    { "williamboman/mason.nvim", cmd = "Mason" },
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Configure diagnostic appearance and icons
    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        spacing = 4,
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- LSP Attach callback (sets buffer-local keymaps when an LSP connects to a file)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("gi", vim.lsp.buf.implementation, "Go to Implementation")
        map("gr", vim.lsp.buf.references, "Find References")
        map("gt", vim.lsp.buf.type_definition, "Type Definition")
        map("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
        map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
        map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        map("<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer Diagnostics")
      end,
    })

    -- Add extra completion capabilities to LSP servers via cmp-nvim-lsp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    end

    -- Setup Mason package manager
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Ensure automatic installation of LSP servers, formatters, and linters
    require("mason-tool-installer").setup({
      ensure_installed = {
        "bash-language-server",
        "pyright",
        "gopls",
        "lua-language-server",
        "shellcheck",
        "shfmt",
        "ruff",
        "stylua",
      },
      auto_update = false,
      run_on_start = true,
    })

    -- Language Server specific configurations
    local servers = {
      -- Bash language server
      bashls = {},

      -- Python (pyright)
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      },

      -- Golang (gopls)
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            completeUnimported = true,
            usePlaceholders = true,
            gofumpt = true,
          },
        },
      },

      -- Lua language server (for editing Neovim configs and plugins)
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
    }

    local lspconfig = require("lspconfig")

    -- Setup Mason-lspconfig to ensure key servers are present
    require("mason-lspconfig").setup({
      ensure_installed = { "bashls", "pyright", "gopls", "lua_ls" },
      automatic_installation = true,
      handlers = {
        function(server_name)
          local server_opts = servers[server_name] or {}
          server_opts.capabilities = capabilities
          lspconfig[server_name].setup(server_opts)
        end,
      },
    })
  end,
}

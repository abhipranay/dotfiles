return {
  -- vtsls configuration for better TypeScript experience
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vtsls = {
          -- Exclude build artifacts and heavy directories from file watching
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          single_file_support = true,
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              tsserver = {
                maxTsServerMemory = 4096,
                -- Exclude patterns to prevent scanning build artifacts
                watchOptions = {
                  excludeDirectories = {
                    "**/node_modules",
                    "**/Pods",
                    "**/build",
                    "**/ios/build",
                    "**/android/build",
                    "**/.gradle",
                    "**/SourcePackages",
                  },
                },
              },
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            javascript = {
              updateImportsOnFileMove = { enabled = "always" },
              inlayHints = {
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
              },
            },
          },
          keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = { only = { "source.organizeImports" }, diagnostics = {} },
                })
              end,
              desc = "Organize Imports",
            },
            {
              "<leader>cM",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = { only = { "source.addMissingImports.ts" }, diagnostics = {} },
                })
              end,
              desc = "Add Missing Imports",
            },
            {
              "<leader>cu",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = { only = { "source.removeUnused.ts" }, diagnostics = {} },
                })
              end,
              desc = "Remove Unused Imports",
            },
            {
              "<leader>cD",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = { only = { "source.fixAll.ts" }, diagnostics = {} },
                })
              end,
              desc = "Fix All Diagnostics",
            },
            {
              "gD",
              function()
                require("vtsls").commands.goto_source_definition(0)
              end,
              desc = "Goto Source Definition",
            },
            {
              "gR",
              function()
                require("vtsls").commands.file_references(0)
              end,
              desc = "File References",
            },
          },
        },
      },
    },
  },

  -- Disable eslint-lsp completely (uses Mason's eslint which lacks project's custom rules)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = false,
      },
      setup = {
        eslint = function()
          return true -- Return true to skip setup
        end,
      },
    },
  },

  -- Use project's local ESLint via nvim-lint (respects custom rules like react-hooks/gating)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "eslint" },
        javascriptreact = { "eslint" },
        typescript = { "eslint" },
        typescriptreact = { "eslint" },
      },
      linters = {
        eslint = {
          -- Use project's node_modules eslint
          cmd = function()
            local local_eslint = vim.fn.fnamemodify("./node_modules/.bin/eslint", ":p")
            if vim.fn.executable(local_eslint) == 1 then
              return local_eslint
            end
            return "eslint"
          end,
        },
      },
    },
  },

  -- Formatting with prettier/biome
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "prettier", "biome", stop_after_first = true },
        typescriptreact = { "prettier", "biome", stop_after_first = true },
        javascript = { "prettier", "biome", stop_after_first = true },
        javascriptreact = { "prettier", "biome", stop_after_first = true },
      },
    },
  },
}

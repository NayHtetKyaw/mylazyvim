local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

--Basic settings
vim.g.mapleader = " "         --leader key
vim.opt.number = true         -- show/hide line numbers
vim.opt.relativenumber = true --show/hide relative line numbers
vim.opt.expandtab = true      -- use spacess instead of tabs
vim.opt.shiftwidth = 2        -- size of line indent (cm)
vim.opt.tabstop = 4           -- number of spaces tab count for
vim.opt.smartindent = true    -- auto indent on / off

require("lazy").setup({
  spec = {
    -- lazyvim core
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- custom plugins
    { import = "plugins" },

    {
      "nvim-telescope/telescope.nvim",
      opts = {
        defaults = {
          vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case"
          },
          prompt_prefix = "🔍 ",
          selection_caret = "▶ ",
          layout_strategy = "flex",
          layout_config = {
            flex = {
              flip_columns = 150,
            },
          },
        },
      },
    },
    {
      "stevearc/conform.nvim",
      opts = {
        formatter_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          go = { "gofmt", "goimports" },
          php = { "php-cs-fixer" },
          python = { "black", "isort" },
          r = { "styler" },
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          -- JavaScript/TypeScript
          tsserver = {},
          -- HTML
          html = {},
          -- CSS
          cssls = {},
          -- Go
          gopls = {},
          -- PHP
          intelephense = {},
          -- Python
          pyright = {},
          -- R
          -- r_language_server = {},
        },
      },
    },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "javascript",
          "typescript",
          "html",
          "css",
          "go",
          "php",
          "python",
          "r",
          "json",
          "markdown",
          "lua",
        },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      },
    },

    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        filesystem = {
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      },
    },
  },

  defaults = {
    lazy = false,
    version = false,
  },

  install = { colorscheme = { "tokyonight", "habamax" } },

  checker = {
    enabled = true,
    notify = false,
  },

  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

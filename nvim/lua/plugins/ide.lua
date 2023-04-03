return {
  -- Configure rust lsp
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },
    },
  },

  -- Show hidden files in neo-tree
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

  -- Sticky context
  { "nvim-treesitter/nvim-treesitter-context" },

  --"gcc" to comment out line
  --"gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },
}

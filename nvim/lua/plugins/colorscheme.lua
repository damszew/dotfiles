return {
  { "Mofiqul/dracula.nvim" },

  -- onedark looks better but not for rust :/ wait for better semantic support
  {
    "navarasu/onedark.nvim",
    opts = {
      style = "deep",
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}

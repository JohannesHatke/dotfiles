return function(use)
  -- which key
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end
  })

  -- plugins for fast latex editing 
  use({
    "lervag/vimtex"
  })
  use({
    "SirVer/ultisnips"
  })


  -- markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })


  -- ranger integration
  use({
    "rbgrouleff/bclose.vim"
  })

  use({
     'francoiscabrol/ranger.vim'
  })

  -- Color
  use 'kvrohit/rasmus.nvim'

  -- Obsidian
  use {
    "epwalsh/obsidian.nvim",
    tag = "*",  -- recommended, use latest release instead of latest commit
    requires = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "Books",
            path = "~/Studium/misc_vaults/Books",
          },
          {
            name = "Semester5",
            path =  "~/Studium/vault/Semester5",
          },
        },

        -- see below for full list of options 👇
      })
    end,
  }

end

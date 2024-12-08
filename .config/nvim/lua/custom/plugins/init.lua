-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
local function weeklyNoteName(...)
	local offset = ...
	local weeknumber = tonumber(os.date("%W",os.time()))
	if offset == nil then
		offset = 0
	end
	if weeknumber + offset > 1 and weeknumber + offset < 52 then
		weeknumber = weeknumber + offset
	else
		return "invalid week"
	end
	local padding = ""
	if weeknumber < 10 then
		padding = "0"
	end
	return "W" .. padding .. tostring(weeknumber) .. os.date("-%Y",os.time())
end
local function monthlyNoteName(...)
	local offset = ...
	if offset == nil then
		offset = 0
	end
	local temp = os.date("*t",os.time())
	if temp["month"] + offset >= 1 and temp["month"] + offset <= 12 then
		temp["month"] = temp["month"] + offset
	else
		return "No Month Available"
	end
	return os.date("%B-%Y",os.time{year=temp["year"], month = temp["month"], day = 1})
end

return {
	-- "SirVer/ultisnips",
	--
	-- "kvrohit/rasmus.nvim",
	{
	  "epwalsh/obsidian.nvim",
	  version = "*",  -- recommended, use latest release instead of latest commit
	  lazy = true,
	  ft = "markdown",
	  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	  -- event = {
	  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	  --   "BufReadPre path/to/my-vault/**.md",
	  --   "BufNewFile path/to/my-vault/**.md",
	  -- },
	  dependencies = {
	    -- Required.
	    "nvim-lua/plenary.nvim",
	    "nvim-telescope/telescope.nvim",
	    "hrsh7th/nvim-cmp",
	    "nvim-treesitter",
	    -- see below for full list of optional dependencies 👇
	  },
	  opts = {
	    workspaces = {
	      {
		name = "Semester5",
		path = "~/Studium/vault/Semester5",
	      },
	    },

		mappings = {
		    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
		    ["gd"] = {
		      action = function()
			return require("obsidian").util.gf_passthrough()
		      end,
		      opts = { noremap = false, expr = true, buffer = true },
		    },
		    -- Toggle check-boxes.
		    ["<localleader>x"] = {
		      action = function()
			return require("obsidian").util.toggle_checkbox()
		      end,
		      opts = { buffer = true },
		    },
		  },

		note_id_func = function(title)
		    return tostring(title)
		  end,

		  follow_url_func = function(url)
		    -- Open the URL in the default web browser.
		    vim.fn.jobstart({"xdg-open", url})  -- linux
		  end,

		  templates = {
		      subdir = "templates",
		      date_format = "%d-%m-%Y",
		      time_format = "%H:%M",
		      substitutions = {
			    lastMonth= function()
			      return "[[" .. monthlyNoteName(-1) .. "]]"
			    end,
			    thisMonth= function()
			      return "[[" .. monthlyNoteName(0) .. "]]"
			    end,
			    nextMonth= function()
			      return "[[" .. monthlyNoteName(1) .. "]]"
			    end,

			    lastWeek= function()
			      return "[[" .. weeklyNoteName(-1) .. "]]"
			    end,
			    thisWeek= function()
			      return "[[" .. weeklyNoteName(0) .. "]]"
			    end,
			    nextWeek= function()
			      return "[[" .. weeklyNoteName(1) .. "]]"
			    end,

			    yesterday= function()
			      return os.date("%d-%m-%Y", os.time() - 86400)
			    end,
			    yesterdayNote= function()
			      return "[[" .. os.date("%d-%m-%Y", os.time() - 86400) .. "|Gestern]]"
			    end,
			    tomorrowNote= function()
			      return "[[" .. os.date("%d-%m-%Y", os.time() + 86400) .. "|Morgen]]"
			    end,
			},
		  },
		  daily_notes = {
		    -- Optional, if you keep daily notes in a separate directory.
		    folder = "dailies",
		    -- Optional, if you want to change the date format for the ID of daily notes.
		    date_format = "%d-%m-%Y",
		    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
		    template = "templates/daily.md"
		  },
	  },
	},

	{ "lervag/vimtex",
		lazy=false,
	},
	{
	  'nvimdev/dashboard-nvim',
	  event = 'VimEnter',
	  config = function()
	    require('dashboard').setup {
	      -- config
	    }
	  end,
	  dependencies = { {'nvim-tree/nvim-web-devicons'}},

	{
	  "nvim-tree/nvim-tree.lua",
	  version = "*",
	  lazy = false,
	  dependencies = {
	    "nvim-tree/nvim-web-devicons",
	  },
	  config = function()
	    require("nvim-tree").setup {}
	  end,
	}
	}
}

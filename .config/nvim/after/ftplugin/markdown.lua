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
	return "weeklies/" .. "W" .. padding .. tostring(weeknumber) .. os.date("-%Y",os.time())
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
	return "monthlies/" .. os.date("%B-%Y",os.time{year=temp["year"], month = temp["month"], day = 1})
end

vim.cmd[[
set conceallevel=1
]]
vim.api.nvim_set_keymap('n', '<localleader>o', ':ObsidianQuickSwitch<cr>', {} )
vim.api.nvim_set_keymap('n', '<localleader>p', ':ObsidianPasteImg<cr>', {} )
vim.api.nvim_set_keymap('n', '<localleader>ll', ':ObsidianOpen<cr>', {} )
vim.api.nvim_set_keymap('n', '<localleader>n', ':ObsidianNew ', {} )
vim.api.nvim_set_keymap('n', '<localleader>dt', ':ObsidianToday<cr>', {} )
vim.api.nvim_set_keymap('n', '<localleader>dm', ':ObsidianTomorrow<cr>', {} )
vim.api.nvim_set_keymap('n', '<localleader>wt', ':ObsidianNew ' .. weeklyNoteName(0) , {} )
vim.api.nvim_set_keymap('n', '<localleader>wm', ':ObsidianNew ' .. weeklyNoteName(1) , {} )
vim.api.nvim_set_keymap('n', '<localleader>mt', ':ObsidianNew ' .. monthlyNoteName(0) , {} )
vim.api.nvim_set_keymap('n', '<localleader>mm', ':ObsidianNew ' .. monthlyNoteName(1) , {} )

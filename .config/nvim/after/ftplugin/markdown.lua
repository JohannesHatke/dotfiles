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
-- local function compile_markdown()
--	
-- end
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

    
local function upload_apy_note(ev, file)
	print("CLOSED")
	-- print(string.format('event fired: %s on file %s', vim.inspect(ev), ev["file"]))

	local apy_add_command = string.format("apy add-from-file %s", ev["file"])
	local handle = io.popen(apy_add_command)
	local result = handle:read("*a")
	handle:close()
	print(result)

	return true

end
local function new_apy_window()
	local temp_script = "~/.config/nvim/misc/createtemp.py"
	local handle = io.popen(temp_script)
	local result = handle:read("*a")
	handle:close()
	local command = string.format(":vsplit %s",result)
	print(command)
	vim.cmd(command)
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_create_autocmd({"BufWinLeave"}, {buffer = buf, callback = upload_apy_note} )
end

local function change_to_callout()
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], 0 , -1)
	if n_lines == 1 then
	lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
	lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	


	-- lines[1] = "> [!info] " .. lines[1]
	for i = 1, n_lines, 1 do
		lines[i] = "> " .. lines[i]
	end
	vim.api.nvim_buf_set_text(0,s_start[2]-1,0,s_end[2],0,lines)
end

-- Bind to visual mode.
-- vim.keymap.set('v', '<leader>D', change_to_callout , { noremap = true, silent = true })

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
vim.api.nvim_set_keymap('v', '<leader>d' ,':s/^/> /<cr>' , {} )
-- vim.api.nvim_set_keymap('n', '<leader>n', '<cmd>vsplit +terminal<cr>iapy add<cr>',  {})
vim.api.nvim_set_keymap('n', '<leader>n', '', {callback=new_apy_window})

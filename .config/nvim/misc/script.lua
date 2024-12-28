
local temp_script = "~/.config/nvim/misc/createtemp.py"
local handle = io.popen(temp_script)
local result = handle:read("*a")
handle:close()
print(result)

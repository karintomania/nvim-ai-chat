local resultPrinter = {}


local function getBuffer(buffName)

	-- get buffer handle by name
	local handle = vim.fn.bufnr(buffName)

	-- if the buffer doesn't exist, create a new one
	if handle == -1 then 
		handle = vim.api.nvim_create_buf(false, "throwaway")
		vim.api.nvim_buf_set_name(handle, buffName)
	end

	return handle
end

local function appendBuffer(handle, str)

	local lines = {}
	for line in string.gmatch(str, "[^\n]+") do
	  -- insert each line into the table as a new element
	  table.insert(lines, line)
	end
	table.insert(lines, '')
	table.insert(lines, '-------------')
	table.insert(lines, '')
	vim.api.nvim_buf_set_lines(handle, -1, -1, false, lines)
end

-- show result in a new tab
function printTab(buffName, str)

	local handle = getBuffer(buffName)
	appendBuffer(handle, str)

	vim.cmd('tab drop ' .. buffName)
end

function resultPrinter.print(str)
	local buffName = 'Chat_Result'

	-- might add other method like printWindow
	printTab(buffName, str)
end

return resultPrinter

local resultPrinter = {}

local buffName = 'Chat_Result'

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

function formatQA(question, answer)
	return 'Q: ' .. question .. '\nA: ' .. answer .. '\n'
end

function resultPrinter.create(question, answer)
	local str = formatQA(question, answer)
	local handle = getBuffer(buffName)
	appendBuffer(handle, str)

	return handle
end

return resultPrinter

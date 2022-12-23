local windowDisplay = {}

function windowDisplay.display(buffer)

	local buffName = vim.api.nvim_buf_get_name(buffer)
	local winId = vim.fn.bufwinid(buffer)

	if winId == -1 then
		-- if the window is not open, open it in belowright
		vim.cmd('belowright sp ' .. buffName)
	else
		-- if the window is open, move to the window
		vim.cmd('drop ' .. buffName)
	end
	-- move cursor to the end
	vim.api.nvim_command('normal! G')

end

return windowDisplay

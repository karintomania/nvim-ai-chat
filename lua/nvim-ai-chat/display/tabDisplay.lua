local tabDisplay = {}

function tabDisplay.display(buffer)

	local buffName = vim.api.nvim_buf_get_name(buffer)
	vim.cmd('tab drop ' .. buffName)
	-- move cursor to the end
	vim.api.nvim_command('normal! G')

end

return tabDisplay

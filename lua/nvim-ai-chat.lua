local M = {}

local resultPrinter = require('nvim-ai-chat/resultPrinter')
local api = require('nvim-ai-chat/api/api')
local client = require('nvim-ai-chat/api/curlClient')
local resultBuffer = require('nvim-ai-chat/display/resultBuffer')

M.config = {
	token = '',
	display = 'tab',
	maxLength = 300,
	temperature = 0.1
}

function M.setup(customConfig)
	local filled = vim.tbl_deep_extend("keep", customConfig, M.config)
	M.config = filled
end

function getDisplay()

	local display = {}

	if M.config.display == 'window' then
		display = require('nvim-ai-chat/display/windowDisplay')
	else
		display = require('nvim-ai-chat/display/tabDisplay')
	end
	return display
end

function M.chat(question)
	local answer = api.call(question, client, M.config)

	local buffer = resultBuffer.create(question, answer)
	
	getDisplay().display(buffer)
end


return M


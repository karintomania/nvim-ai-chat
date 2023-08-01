local M = {}

local resultPrinter = require('nvim-ai-chat/resultPrinter')
local api = require('nvim-ai-chat/api/api')
local client = require('nvim-ai-chat/api/curlClient')
local resultBuffer = require('nvim-ai-chat/display/resultBuffer')

M.config = {
	token = '',
	model = "gpt-3.5-turbo",
	display = 'tab',
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

function M.chatSelection(lineStart, lineEnd)
    local lines = vim.fn.getline(lineStart, lineEnd)
    local question = table.concat(lines, "\n")
    M.chat(question)
end


return M


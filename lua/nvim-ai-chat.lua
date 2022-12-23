local M = {}

local resultPrinter = require('nvim-ai-chat/resultPrinter')
local api = require('nvim-ai-chat/api/api')
local client = require('nvim-ai-chat/api/curlClient')

M.config = {
	token = '',
	resultType = 'tab',
	maxLength = 300,
	temperature = 0.1
}

function M.setup(customConfig)
	local filled = vim.tbl_deep_extend("keep", customConfig, M.config)
	M.config = filled
end

function M.chat(question)
	local answer = api.call(question, client, M.config)
	resultPrinter.print(question, answer)
end

return M


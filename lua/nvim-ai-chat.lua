local M = {}

local resultPrinter = require('nvim-ai-chat/resultPrinter')
local apiClient = require('nvim-ai-chat/apiClient')

M.config = {
	token = '',
	resultType = 'tab',
	maxLength = 300
}

function M.setup(customConfig)
	local filled = vim.tbl_deep_extend("keep", customConfig, M.config)
	M.config = filled
end

function M.chat(string)
	local result = apiClient.call(string, M.config)
	resultPrinter.print(result)
end

return M


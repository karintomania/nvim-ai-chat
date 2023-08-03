local M = {}

local api = require('nvim-ai-chat/api/api')
local client = require('nvim-ai-chat/api/curlClient')
local resultBuffer = require('nvim-ai-chat/display/resultBuffer')
local display = require('nvim-ai-chat/display/tabDisplay')

M.config = {
	token = '',
	model = "gpt-3.5-turbo",
}

function M.setup(customConfig)
	local filled = vim.tbl_deep_extend("keep", customConfig, M.config)
	M.config = filled
end

function M.chat(question)
	local answer = api.call(question, client, M.config)

	local buffer = resultBuffer.create(question, answer)
	
	display.display(buffer)
end

function M.chatSelection(lineStart, lineEnd, additionalQuestion)
    local lines = vim.fn.getline(lineStart, lineEnd)
    local question = table.concat(lines, "\n")

    if additionalQuestion ~= nil and additionalQuestion ~= ""  then
        question = additionalQuestion .. "\n" .. question
    end
    M.chat(question)
end


return M


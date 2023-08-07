local M = {}

local api = require('nvim-ai-chat/api/api')
local client = require('nvim-ai-chat/api/curlClient')
local resultBuffer = require('nvim-ai-chat/display/resultBuffer')
local display = require('nvim-ai-chat/display/tabDisplay')

require('nvim-ai-chat/display/ChatManager')
local chatManager = ChatManager:new()
require('nvim-ai-chat/display/InputManager')
local inputManager = InputManager:new()

local openTab = require('nvim-ai-chat/display/openTab')
local curl = require('nvim-ai-chat/api/chatCurlClient')

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

function M.ask()
    local questionLines = inputManager:getQuestion()

    -- if question input exists 
    if #questionLines ~= 0 then
        local chat = chatManager:getChat()
        local qa = curl.call(chat, questionLines, M.config)

        chatManager:addChat(qa)
        inputManager:reset()
    end

    openTab.open(chatManager.buffer.handle, inputManager.buffer.handle)

end

return M


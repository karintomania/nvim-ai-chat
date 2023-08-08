local M = {}

require('nvim-ai-chat/display/ChatManager')
local chatManager = ChatManager:new()
require('nvim-ai-chat/display/InputManager')
local inputManager = InputManager:new()

local openTab = require('nvim-ai-chat/display/openTab')
local curl = require('nvim-ai-chat/api/chatCurlClient')

_G.config = {
    token = '',
    model = "gpt-3.5-turbo",
    inputHeight = 10
}

function M.setup(customConfig)
	local filled = vim.tbl_deep_extend("keep", customConfig, _G.config)
	_G.config = filled
end

function M.ask()
    local questionLines = inputManager:getQuestion()

    -- if question input exists 
    if #questionLines ~= 0 then
        local chat = chatManager:getChat()
        local qa = curl.call(chat, questionLines)

        chatManager:addChat(qa)
        inputManager:reset()
    end

    openTab.open(chatManager.buffer.handle, inputManager.buffer.handle)

end

return M


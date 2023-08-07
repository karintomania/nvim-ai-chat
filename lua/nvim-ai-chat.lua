local M = {}

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


local M = {}

-- TODO: create buffers when :Chat is called for the first time instead of plugin load
require('nvim-ai-chat/display/ChatManager')
local chatManager = ChatManager:new()
require('nvim-ai-chat/display/InputManager')
local inputManager = InputManager:new()

local openTab = require('nvim-ai-chat/display/openTab')
local curl = require('nvim-ai-chat/api/chatCurlClient')

_G.config = {token = '', model = "gpt-3.5-turbo", inputHeight = 10}

function M.setup(customConfig)
    local filled = vim.tbl_deep_extend("keep", customConfig, _G.config)
    _G.config = filled
end

local function openChatTab()
    openTab.open(chatManager.buffer.handle, inputManager.buffer.handle)
end


function M.ask()

    -- if question input exists 
    if not inputManager:validateQuestion() then
        openChatTab()
        return
    end

    local questionLines = inputManager:getQuestion()
    local chat = chatManager:getChat()

    local handleQa = vim.schedule_wrap(function(qa)
        chatManager:addChat(qa)
        inputManager:reset()
        openChatTab()
    end)

    local qa = curl.call(chat, questionLines, handleQa)

end

return M


local M = {}

-- TODO: create buffers when :Chat is called for the first time instead of plugin load
require('nvim-ai-chat/display/ChatManager')
require('nvim-ai-chat/display/InputManager')
local openTab = require('nvim-ai-chat/display/openTab')
local curl = require('nvim-ai-chat/api/chatCurlClient')

local function initBuffers()
    if M.chatManager == nil then
        M.chatManager = ChatManager:new()
    end
    if M.inputManager == nil then
        M.inputManager = InputManager:new()
    end
end

_G.config = {token = '', model = "gpt-3.5-turbo", inputHeight = 10}

function M.setup(customConfig)
    local filled = vim.tbl_deep_extend("keep", customConfig, _G.config)
    _G.config = filled
end

local function openChatTab()
    openTab.open(M.chatManager.buffer.handle, M.inputManager.buffer.handle)
end


function M.ask()

    initBuffers()

    -- if question input exists 
    if not M.inputManager:validateQuestion() then
        openChatTab()
        return
    end

    local questionLines = M.inputManager:getQuestion()
    local chat = M.chatManager:getChat()

    local handleQa = vim.schedule_wrap(function(qa)
        M.chatManager:addChat(qa)
        M.inputManager:reset()
        openChatTab()
    end)

    local qa = curl.call(chat, questionLines, handleQa)

end

return M


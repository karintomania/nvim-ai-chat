local M = {}

-- TODO: create buffers when :Chat is called for the first time instead of plugin load
local ChatManager = require('nvim-ai-chat/display/ChatManager')
local InputManager = require('nvim-ai-chat/display/InputManager')
local Config = require('nvim-ai-chat/Config')
local openTab = require('nvim-ai-chat/display/openTab')
local curl = require('nvim-ai-chat/api/chatCurlClient')

local function initBuffers()
    if M.chatManager == nil then M.chatManager = ChatManager:new() end
    if M.inputManager == nil then M.inputManager = InputManager:new() end
end

function M.setup(customConfig) Config.init(customConfig) end

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


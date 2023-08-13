local M = {}

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

local function callApi(chat, questionLines)

    local handleQa = vim.schedule_wrap(function(qa)
        chatManager:addChat(qa)
        inputManager:reset()
        openChatTab()
    end)

    local qa = curl.call(chat, questionLines, handleQa)

end

local function validateQuestion(questionLines)
    local q = table.concat(questionLines)
    if q == "" then
        openChatTab()
        error("question shouldn't be blank")
    end
end

function M.ask()
    local questionLines = inputManager:getQuestion()

    -- if question input exists 
    if #questionLines ~= 0 then
        validateQuestion(questionLines)

        local chat = chatManager:getChat()

        -- TODO: call asynchronously without blocking UI
        callApi(chat, questionLines)
    else
        openChatTab()
    end

end

return M


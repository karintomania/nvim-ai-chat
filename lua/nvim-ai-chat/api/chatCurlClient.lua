local chatCurlClient = {}
local asyncCurl = require('nvim-ai-chat/api/asyncCurl')
local getOptionsFromChat = require('nvim-ai-chat/api/getOptionsFromChat')
local getQAFromResponse = require('nvim-ai-chat/api/getQAFromResponse')

chatCurlClient.command = ''

function chatCurlClient.call(chat, questionLines, handleQa)

    local options = getOptionsFromChat(chat, questionLines)

    local callback = function(response)
        local qa = getQAFromResponse(questionLines, response)
        handleQa(qa)
    end

    asyncCurl.call(options, callback)

end

return chatCurlClient

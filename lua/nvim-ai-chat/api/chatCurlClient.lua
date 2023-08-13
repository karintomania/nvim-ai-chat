local chatCurlClient = {}
local strUtil = require('nvim-ai-chat/strUtil')
local asyncCurl = require('nvim-ai-chat/api/asyncCurl')

chatCurlClient.command = ''

function chatCurlClient.call(chat, questionLines, handleQa)

    local options = chatCurlClient.chatToOptions(chat, questionLines)

    local callback = function(response)
        local qa = chatCurlClient.getQA(questionLines, response)
        handleQa(qa)
    end

    asyncCurl.call(options, callback)

end

local function escapeQuestion(questionLines)
    local questionStr = table.concat(questionLines, "\n")
    return strUtil.escape(questionStr)
end

local function processLines(lines)
    local processedLines = table.concat(lines, "\n")
    processedLines = strUtil.escape(processedLines)
    return processedLines
end

local function chatToStringArray(chat, questionLines)

    local res = ""

    for i, pair in ipairs(chat) do
        local q = processLines(pair.question)
        local a = processLines(pair.answer)
        res = res .. '{"role": "user", "content": "' .. q .. '"},'
        res = res .. '{"role": "assistant", "content": "' .. a .. '"},'
    end

    local question = escapeQuestion(questionLines)
    res = res .. '{"role": "user", "content": "' .. question .. '"}'
    return "[" .. res .. "]"
end

function chatCurlClient.chatToOptions(chat, questionLines)

    local token = _G.config.token
    local model = _G.config.model

    local chatString = chatToStringArray(chat, questionLines)

    local body = string.format('-d{"model": "%s", "messages": %s}', model,
                               chatString)

    local options = {
        "https://api.openai.com/v1/chat/completions",
        "-sS",
        "-HContent-Type: application/json",
        "-HAuthorization: Bearer " .. token,
        body,
    }

    return options
end

local function getAnswer(response)

    local start_index = string.find(response, "\"content\": \"")
    if start_index == nil then
        -- json doesnt' contain the answer because something went wrong
        error(response)
    end
    local end_index = string.find(response, '"\n', start_index + 8)
    local answer = string.sub(response, start_index + 12, end_index - 1)

    local escaped = strUtil.unescape(answer)

    local answerLines = {}
    for str in string.gmatch(escaped, "([^\n]+)") do
        table.insert(answerLines, str)
    end

    return answerLines
end

function chatCurlClient.getQA(questionLines, response)
    -- get answer from response
    local answer = getAnswer(response)
    local qa = {question = questionLines, answer = answer}

    return qa
end

function chatCurlClient.jsonToChat() return {} end

return chatCurlClient

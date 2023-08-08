local chatCurlClient = {}
local strUtil = require('nvim-ai-chat/strUtil')

chatCurlClient.command = ''

function chatCurlClient.call(chat, questionLines)

    local command = chatCurlClient.chatToCommand(chat, questionLines)

    local response = chatCurlClient.runCurl(command)

    return chatCurlClient.getQA(questionLines, response)

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

function chatCurlClient.chatToCommand(chat, questionLines)

    local token = _G.config.token
    local model = _G.config.model

    local chatString = chatCurlClient.chatToStringArray(chat, questionLines)

    local command = string.format(
                        [[curl https://api.openai.com/v1/chat/completions -s \
-H "Content-Type: application/json" \
-H "Authorization: Bearer %s" \
-d '{"model": "%s", "messages": %s}'
]], token, model, chatString)

    return command
end

function chatCurlClient.chatToStringArray(chat, questionLines)

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

function chatCurlClient.runCurl(command)

    local handle = assert(io.popen(command, 'r'))
    local output = assert(handle:read('*a'))
    handle:close()

    -- error handling
    local index = string.find(output, "\"error\":")

    if index ~= nil then error(output) end

    return output
end

local function getAnswer(response)

    local start_index = string.find(response, "\"content\": \"")
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

local strUtil = require('nvim-ai-chat/strUtil')
local Config = require('nvim-ai-chat/Config')

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

    local system = Config.get("system")

    if system ~= nil then
        system = string.format('{"role": "system", "content": "%s"},',
                               strUtil.escape(system))
    else
        system = ""
    end

    local res = ""

    for i, pair in ipairs(chat) do
        local q = processLines(pair.question)
        local a = processLines(pair.answer)
        res = string.format('%s{"role": "user", "content": "%s"},', res, q)
        res = string.format('%s{"role": "assistant", "content": "%s"},', res, a)
    end

    local question = escapeQuestion(questionLines)
    res = string.format('%s{"role": "user", "content": "%s"}', res, question)
    res = string.format('%s%s', system, res)

    return string.format("[%s]", res)
end

local function getOptionsFromChat(chat, questionLines)

    local token = Config.get("token")
    local model = Config.get("model")

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

return getOptionsFromChat

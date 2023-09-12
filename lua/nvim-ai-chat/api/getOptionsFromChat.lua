local strUtil = require('nvim-ai-chat/strUtil')

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

local function getOptionsFromChat(chat, questionLines)

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

return getOptionsFromChat

local strUtil = require('nvim-ai-chat/strUtil')

local function getAnswerFromResponse(response)

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

local function getQAFromResponse(questionLines, response)
    -- get answer from response
    local answer = getAnswerFromResponse(response)
    local qa = {question = questionLines, answer = answer}

    return qa
end
return getQAFromResponse

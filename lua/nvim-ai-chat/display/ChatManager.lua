local Buffer = require('nvim-ai-chat/display/Buffer')

local function ChatManager()

    local questionPrefix = "[You]> "
    local answerPrefix = "[GPT]> "
    local indent = ""
    local buffName = "Chat_Main"
    local buffer = Buffer(buffName)

    local function convertChatToTable(chat)
        local result = {}
        local function addQA(question, answer)
            table.insert(result, {question = question, answer = answer})
        end

        local currentQuestion = {}
        local currentAnswer = {}
        local isQuestion = true

        -- TODO: rewrite in regex?
        -- TODO: add if for blank chat
        for i, line in ipairs(chat) do
            if string.sub(line, 1, 7) == questionPrefix then
                table.insert(currentQuestion, (line:gsub("%[You%]%> ", "")))
                isQuestion = true
            elseif string.sub(line, 1, 7) == answerPrefix then
                isQuestion = false
                table.insert(currentAnswer, (line:gsub("%[GPT%]%> ", "")))
            else
                if isQuestion then
                    table.insert(currentQuestion, (line:gsub(indent, "")))
                else
                    table.insert(currentAnswer, (line:gsub(indent, "")))
                end
            end

            if -- when next line includes question prefix or final line
            (chat[i + 1] and string.sub(chat[i + 1], 1, 7) == questionPrefix) or
                i == #chat then
                addQA(currentQuestion, currentAnswer)
                currentQuestion = {}
                currentAnswer = {}
            end

        end

        return result

    end

    local function getChat()

        local str = buffer.read()

        if #str == 0 or table.concat(str) == "" then return {} end

        local result = convertChatToTable(str)

        return result
    end

    local function formatLines(rawLines, prefix)

        local lines = {}
        for i, rawLine in ipairs(rawLines) do
            local line = ""
            if i == 1 then
                line = prefix .. rawLine
            else
                line = indent .. rawLine
            end
            table.insert(lines, line)
        end
        return lines
    end

    -- add question and answer to the buffer
    -- This funciton adds the prefix/indent to the lines
    local function addChat(chat)

        local questionLines = formatLines(chat.question, questionPrefix)
        local answerLines = formatLines(chat.answer, answerPrefix)

        buffer.append(questionLines)
        buffer.append(answerLines)
    end

    local function reset() buffer.empty() end

    reset()

    return {
        getChat = getChat,
        addChat = addChat,
        convertChatToTable = convertChatToTable,
        reset = reset,
        getBuffer = function() return buffer end,
    }

end

return ChatManager

require('nvim-ai-chat/display/Buffer')

ChatManager = {
    questionPrefix = "[You]> ",
    answerPrefix = "[GPT]> ",
    indent = "",
    buffName = "Chat_Main",
}

function ChatManager:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o.buffer = Buffer:new({bufferName = self.buffName})
    o:reset()
    return o
end

function ChatManager:getChat()

    local str = self.buffer:read()

    if #str == 0 or table.concat(str) == "" then return {} end

    local result = self:convertChatToTable(str)

    return result
end

function ChatManager:convertChatToTable(chat)
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
        if string.sub(line, 1, 7) == self.questionPrefix then
            table.insert(currentQuestion, (line:gsub("%[You%]%> ", "")))
            isQuestion = true
        elseif string.sub(line, 1, 7) == self.answerPrefix then
            isQuestion = false
            table.insert(currentAnswer, (line:gsub("%[GPT%]%> ", "")))
        else
            if isQuestion then
                table.insert(currentQuestion, (line:gsub(self.indent, "")))
            else
                table.insert(currentAnswer, (line:gsub(self.indent, "")))
            end
        end

        if -- when next line includes question prefix or final line
        (chat[i + 1] and string.sub(chat[i + 1], 1, 7) == self.questionPrefix) or
            i == #chat then
            addQA(currentQuestion, currentAnswer)
            currentQuestion = {}
            currentAnswer = {}
        end

    end

    return result

end

-- add question and answer to the buffer
-- This funciton adds the prefix/indent to the lines
function ChatManager:addChat(chat)

    local questionLines = self:formatLines(chat.question, self.questionPrefix)
    local answerLines = self:formatLines(chat.answer, self.answerPrefix)

    self.buffer:append(questionLines)
    self.buffer:append(answerLines)
end

function ChatManager:formatLines(rawLines, prefix)

    local lines = {}
    for i, rawLine in ipairs(rawLines) do
        local line = ""
        if i == 1 then
            line = prefix .. rawLine
        else
            line = self.indent .. rawLine
        end
        table.insert(lines, line)
    end
    return lines
end

function ChatManager:reset() self.buffer:empty() end

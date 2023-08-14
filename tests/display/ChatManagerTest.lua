package.loaded['lua/nvim-ai-chat/display/ChatManager'] = nil
package.loaded['lua/nvim-ai-chat/display/Buffer'] = nil
require('lua/nvim-ai-chat/display/ChatManager')

local function test_ConvertChatToTable_converts_chat_to_table()
    local cm = ChatManager:new()
    local input = {
        "[You]> This is the first question",
        "[GPT]> This is the first answer",
        "[You]> This is",
        cm.indent .. "the second question",
        "[GPT]> This is",
        cm.indent .. "the second answer",
    }
    local res = cm:convertChatToTable(input)

    vim.fn.assert_equal(2, #res)
    vim.fn.assert_equal("This is the first question", res[1].question[1])
    vim.fn.assert_equal("This is the first answer", res[1].answer[1])
    vim.fn.assert_equal('This is', res[2].question[1])
    vim.fn.assert_equal('the second question', res[2].question[2])
    vim.fn.assert_equal('This is', res[2].answer[1])
    vim.fn.assert_equal('the second answer', res[2].answer[2])
end

local function test_ConvertChatToTable_returns_blank_table_if_chat_is_blank()
    local cm = ChatManager:new()
    local input = {}
    local res = cm:convertChatToTable(input)

    vim.fn.assert_equal(0, #res)
end

local function test_addChat_and_getChat()
    local cm = ChatManager:new()

    local input = {
        question = {"This is", "the first question"},
        answer = {"This is", "the first answer"},
    }

    -- test add chat
    cm:addChat(input)
    local res = cm:getChat()

    vim.fn.assert_equal(1, #res)
    vim.fn.assert_equal("This is", res[1].question[1])
    vim.fn.assert_equal("the first question", res[1].question[2])

    vim.fn.assert_equal("This is", res[1].answer[1])
    vim.fn.assert_equal("the first answer", res[1].answer[2])

    local input2 = {
        question = {"And this is", "the second question"},
        answer = {"Finaly, this is", "the second answer"},
    }

    cm:addChat(input2)
    res = cm:getChat()
    vim.fn.assert_equal('And this is', res[2].question[1])
    vim.fn.assert_equal('the second question', res[2].question[2])
    vim.fn.assert_equal('Finaly, this is', res[2].answer[1])
    vim.fn.assert_equal('the second answer', res[2].answer[2])
end

test_ConvertChatToTable_converts_chat_to_table()
test_ConvertChatToTable_returns_blank_table_if_chat_is_blank()
test_addChat_and_getChat()

require('lua/nvim-ai-chat/util').test('ChatManager')

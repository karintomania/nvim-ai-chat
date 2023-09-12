package.loaded['nvim-ai-chat/api/getOptionsFromChat'] = nil
local getOptions = require('nvim-ai-chat/api/getOptionsFromChat')

local function test_getOptionsFromChat()

    local chat = {{question = {"first question"}, answer = {"first answer"}}}

    local question = {"This is the", "second question"}
    _G.config = {token = "test_token", model = "test_model"}

    local options = getOptions(chat, question)

    local expected = {
        "https://api.openai.com/v1/chat/completions",
        "-sS",
        "-HContent-Type: application/json",
        "-HAuthorization: Bearer test_token",
        [[-d{"model": "test_model", "messages": [{"role": "user", "content": "first question"},{"role": "assistant", "content": "first answer"},{"role": "user", "content": "This is the\nsecond question"}]}]],
    }

    vim.fn.assert_equal(expected[1], options[1])
    vim.fn.assert_equal(expected[2], options[2])
    vim.fn.assert_equal(expected[3], options[3])
    vim.fn.assert_equal(expected[4], options[4])
    vim.fn.assert_equal(expected[5], options[5])

end

test_getOptionsFromChat()

require('nvim-ai-chat/util').test('getOptionsFromChatTest')

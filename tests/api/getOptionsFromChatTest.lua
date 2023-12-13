package.loaded['nvim-ai-chat/api/Config'] = nil
local Config = require('nvim-ai-chat/Config')
Config.init({
    token = "test_token",
    model = "test_model",
    -- system="system call test"
})

package.loaded['nvim-ai-chat/api/getOptionsFromChat'] = nil
local getOptions = require('nvim-ai-chat/api/getOptionsFromChat')

local function test_getOptionsFromChat()
    Config.init({
        token = "test_token",
        model = "test_model",
        system = "system call test",
    })

    local chat = {{question = {"first question"}, answer = {"first answer"}}}

    local question = {"This is the", "second question"}

    local options = getOptions(chat, question)

    local expected = {
        "https://api.openai.com/v1/chat/completions",
        "-sS",
        "-HContent-Type: application/json",
        "-HAuthorization: Bearer test_token",
        [[-d{"model": "test_model", "messages": [{"role": "system", "content": "system call test"},{"role": "user", "content": "first question"},{"role": "assistant", "content": "first answer"},{"role": "user", "content": "This is the\nsecond question"}]}]],
    }

    vim.fn.assert_equal(expected[1], options[1])
    vim.fn.assert_equal(expected[2], options[2])
    vim.fn.assert_equal(expected[3], options[3])
    vim.fn.assert_equal(expected[4], options[4])
    vim.fn.assert_equal(expected[5], options[5])

end

local function test_getOptionsFromChatWithNilSystem()

    Config.init({token = "test_token", model = "test_model"}) -- without system set

    local chat = {{question = {"first question"}, answer = {"first answer"}}}

    local question = {"second question"}

    local options = getOptions(chat, question)

    local expected = {
        "https://api.openai.com/v1/chat/completions",
        "-sS",
        "-HContent-Type: application/json",
        "-HAuthorization: Bearer test_token",
        [[-d{"model": "test_model", "messages": [{"role": "user", "content": "first question"},{"role": "assistant", "content": "first answer"},{"role": "user", "content": "second question"}]}]],
    }

    vim.fn.assert_equal(expected[1], options[1])
    vim.fn.assert_equal(expected[2], options[2])
    vim.fn.assert_equal(expected[3], options[3])
    vim.fn.assert_equal(expected[4], options[4])
    vim.fn.assert_equal(expected[5], options[5])

end

test_getOptionsFromChat()
test_getOptionsFromChatWithNilSystem()

require('nvim-ai-chat/util').test('getOptionsFromChatTest')

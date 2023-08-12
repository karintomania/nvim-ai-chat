package.loaded['nvim-ai-chat/api/chatCurlClient'] = nil
local curl = require('nvim-ai-chat/api/chatCurlClient')

local function test_chatToOptions()

    local chat = {{question = {"first question"}, answer = {"first answer"}}}

    local question = {"This is the", "second question"}
    _G.config = {token = "test_token", model = "test_model"}

    local options = curl.chatToOptions(chat, question)

    local expected = {
    "https://api.openai.com/v1/chat/completions",
    "-sS",
    "-HContent-Type: application/json",
    "-HAuthorization: Bearer test_token",
    [[-d{"model": "test_model", "messages": [{"role": "user", "content": "first question"},{"role": "assistant", "content": "first answer"},{"role": "user", "content": "This is the\nsecond question"}]}]]
    }

    vim.fn.assert_equal(expected[1], options[1])
    vim.fn.assert_equal(expected[2], options[2])
    vim.fn.assert_equal(expected[3], options[3])
    vim.fn.assert_equal(expected[4], options[4])
    vim.fn.assert_equal(expected[5], options[5])

end

local function test_getQA()
    local questionLines = {"second question"}

    local response = [[{
  "id": "chatcmpl-xxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "object": "chat.completion",
  "created": 9999999999,
  "model": "gpt-3.5-turbo-0613",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "This is \nsecond answer"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 21,
    "completion_tokens": 2,
    "total_tokens": 23
  }
}
]]
    local qa = curl.getQA(questionLines, response)

    vim.fn.assert_equal("second question", qa.question[1])
    vim.fn.assert_equal("This is ", qa.answer[1])
    vim.fn.assert_equal("second answer", qa.answer[2])
end

-- test_chatToCommand()
test_chatToOptions()
test_getQA()

require('lua/nvim-ai-chat/util').test('curlClientTest')

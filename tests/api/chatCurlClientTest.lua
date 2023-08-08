package.loaded['lua/nvim-ai-chat/api/chatCurlClient'] = nil
local curl = require('lua/nvim-ai-chat/api/chatCurlClient')

local function test_chatToStringArray()
    local chat = {
        {
            question = {"This is the ", "first question"},
            answer = {"first answer"},
        },
        {question = {"second question"}, answer = {"second answer"}},
    }

    -- local question = {"This is the ", "third question"}
    local question = {"third question"}

    local res = curl.chatToStringArray(chat, question)

    local expected =
        [[[{"role": "user", "content": "This is the \nfirst question"},{"role": "assistant", "content": "first answer"},{"role": "user", "content": "second question"},{"role": "assistant", "content": "second answer"},{"role": "user", "content": "third question"}]] ..
            "]"
    vim.fn.assert_equal(expected, res)
end

local function test_chatToCommand()

    local chat = {{question = {"first question"}, answer = {"first answer"}}}

    local question = {"second question"}
    _G.config = {token = "test_token", model = "test_model"}

    local res = curl.chatToCommand(chat, question)

    local expected = [[curl https://api.openai.com/v1/chat/completions -s \
-H "Content-Type: application/json" \
-H "Authorization: Bearer test_token" \
-d '{"model": "test_model", "messages": [{"role": "user", "content": "first question"},{"role": "assistant", "content": "first answer"},{"role": "user", "content": "second question"}]}'
]]

    vim.fn.assert_equal(expected, res)

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

test_chatToStringArray()
test_chatToCommand()
test_getQA()

require('lua/nvim-ai-chat/util').test('curlClientTest')

package.loaded['nvim-ai-chat/api/getQAFromResponse'] = nil
local getQA = require('nvim-ai-chat/api/getQAFromResponse')

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
    local qa = getQA(questionLines, response)

    vim.fn.assert_equal("second question", qa.question[1])
    vim.fn.assert_equal("This is ", qa.answer[1])
    vim.fn.assert_equal("second answer", qa.answer[2])
end

test_getQA()

require('nvim-ai-chat/util').test('getQAFromResponseTest')

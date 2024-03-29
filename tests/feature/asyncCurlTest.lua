package.loaded['nvim-ai-chat/api/asyncCurl'] = nil
package.loaded['nvim-ai-chat/api/getQAFromResponse'] = nil
local getQAFromResponse = require('nvim-ai-chat/api/getQAFromResponse')
local asyncCurl = require('nvim-ai-chat/api/asyncCurl')
local secret = require('tests/secret')

local question = "Count 1 to 3. Separate the numbers by comma."
local options = {
    "https://api.openai.com/v1/chat/completions",
    "-sS",
    "-HContent-Type: application/json",
    "-HAuthorization: Bearer " .. secret,
    [[-d{"model": "gpt-3.5-turbo", "messages": [{"role": "user", "content": "Count 1 to 3. Separate the numbers by comma."}]}]],
}

local callback = function(response)

    local questionLines = {question}
    local qa = getQAFromResponse(questionLines, response)

    -- can't use vim.fn.assert_equal inside vim.schedule_wrap
    assert(question == qa.question[1],
           question .. "expected, but got " .. qa.question[1])
    assert("1, 2, 3" == qa.answer[1],
           "1, 2, 3" .. "expected, but got " .. qa.answer[1])

    require('nvim-ai-chat/util').test('asyncCurlTest')
end

asyncCurl.call(options, vim.schedule_wrap(callback))

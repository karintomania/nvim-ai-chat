package.loaded['lua/nvim-ai-chat/api/curlJsonResponse'] = nil
local curlJsonResponse = require('lua/nvim-ai-chat/api/curlJsonResponse')

-- test validate shows error with json with error
local errorJson = [[
{
	"error": {
			"message": "Incorrect API key provided",
			"type": "invalid_request_error",
			"param": null,
			"code": "invalid_api_key"
    }
]]
local status, err = pcall(curlJsonResponse.init, errorJson)

vim.fn.assert_false(status)
vim.fn.assert_notequal(-1, string.find(err, 'Incorrect API key provided'))


-- test getAnswer gets answer from json
local validJson = [[{"text":"test\n\nThis is a test\nThis is a second line","index":0}]]
local answer = curlJsonResponse.init(validJson).getAnswer()

vim.fn.assert_equal([[test

This is a test
This is a second line]],answer)

-- test getAnswer removes new line at the beginning
local validJson = [[{"text":"\n\nThis is a test\n\nThis is a second line","index":0}]]
local answer = curlJsonResponse.init(validJson).getAnswer()

vim.fn.assert_equal([[This is a test

This is a second line]],answer)

require('lua/nvim-ai-chat/util').test('curlJsonResponseTest')

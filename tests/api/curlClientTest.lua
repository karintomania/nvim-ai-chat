package.loaded['lua/nvim-ai-chat/api/curlClient'] = nil
package.loaded['tests/secret'] = nil
local secret = require('tests/secret')
local curl = require('lua/nvim-ai-chat/api/curlClient')

local question = [[test question "test"]]
local escapedQuestion = [[test question \"test\"]]

local config = {
	temperature = 0.5,
	model = 'text-ada-001',
	maxLength = 100,
	token = secret,
}

-- test init make a curl command
curl.init(question, config)

vim.fn.assert_equal(
string.format([[curl https://api.openai.com/v1/completions -s \
-H "Content-Type: application/json" \
-H "Authorization: Bearer %s" \
-d '{ "model": "text-ada-001", "prompt": "%s", "temperature": %s, "max_tokens": %s}'
]], config.token, escapedQuestion, config.temperature, config.maxLength),
curl.command
)

-- test curl command returns result
local answer = curl
	.init("Give me a quote about unit tests.", config)
	.call()

print(answer)

require('lua/nvim-ai-chat/util').test('curlClientTest')

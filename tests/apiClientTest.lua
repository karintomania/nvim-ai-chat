package.loaded['lua/nvim-ai-chat/apiClient'] = nil
local apiClient = require('lua/nvim-ai-chat/apiClient')


-- test getAnswerFromJson
local answer = apiClient.getAnswerFromJson([[{"choices":[{"text":"\n\nThis is a test","index":0,"logprobs":null,"finish_reason":"length"}]])
assert(answer == "This is a test")

-- test validate error json
local result, message = apiClient.validateJson([[{"choices":[{"text":"\n\nThis is a test","index":0,"logprobs":null,"finish_reason":"length"}]])
assert(result)
assert(message == "")

result, message = apiClient.validateJson([[
{
	"error": {
			"message": "Incorrect API key provided",
			"type": "invalid_request_error",
			"param": null,
			"code": "invalid_api_key"
    }
]])
assert(not result)
assert(message == "Error: Incorrect API key provided")

-- test formatQA
local formattedQA = apiClient.formatQA('test question', 'test answer')
assert(formattedQA == 'Q: test question\nA: test answer\n')

-- test makeCurlCommand
local curlCommand = apiClient.makeCurlCommand('test question',
	{token = 'token', maxLength = '100', temperature = 0.5})
assert(
	curlCommand == [[
curl https://api.openai.com/v1/completions -s \
-H "Content-Type: application/json" \
-H "Authorization: Bearer token" \
-d '{ "model": "text-davinci-003", "prompt": "test question", "temperature": 0.5, "max_tokens": 100}'
]])

-- test call
-- local result = apiClient.call(
-- 	'what is a good programming language for web?',
-- 	{token = '', maxLength = '200'})
-- print(result)


print('success!')

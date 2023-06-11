local curlUtil = {}
local strUtil = require('nvim-ai-chat/strUtil')
local curlJsonResponse = require('nvim-ai-chat/api/curlJsonResponse')

curlUtil.command = ''

function curlUtil.init(question, config)

	question = strUtil.escape(question)

	local token = config.token
	local maxLength = config.maxLength
	local temperature = config.temperature

	curlUtil.command = string.format([[curl https://api.openai.com/v1/completions -s \
-H "Content-Type: application/json" \
-H "Authorization: Bearer %s" \
-d '{ "model": "text-ada-001", "prompt": "%s", "temperature": %s, "max_tokens": %s}'
]], token, question, temperature, maxLength)

	return curlUtil
end

function curlUtil.call()

    local handle = assert(io.popen(curlUtil.command, 'r'))
    local output = assert(handle:read('*a'))
    handle:close()

	return curlJsonResponse.init(output).getAnswer()
end


return curlUtil

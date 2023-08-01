local curlUtil = {}
local strUtil = require('nvim-ai-chat/strUtil')
local curlJsonResponse = require('nvim-ai-chat/api/curlJsonResponse')

curlUtil.command = ''

function curlUtil.init(question, config)

	local question = strUtil.escape(question)

	local token = config.token
	local model = config.model

	curlUtil.command = string.format([[curl https://api.openai.com/v1/chat/completions -s \
-H "Content-Type: application/json" \
-H "Authorization: Bearer %s" \
-d '{ "model": "%s", "messages": [{"role": "user", "content": "%s"}]}'
]], token, model, question)

	return curlUtil
end

function curlUtil.call()

    local handle = assert(io.popen(curlUtil.command, 'r'))
    local output = assert(handle:read('*a'))
    handle:close()

	return curlJsonResponse.init(output).getAnswer()
end


return curlUtil

local api = {}

local strUtil = require('nvim-ai-chat/strUtil')
api.client = {}

function api.call(question, client, config)
	local answer = client
		.init(question, config)
		.call()
	return answer
end

return api

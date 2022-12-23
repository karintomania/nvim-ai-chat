local api = {}

local strUtil = require('nvim-ai-chat/strUtil')

function api.call(question, client, config)
	local answer = client
		.init(question, config)
		.call()
	return answer
end

return api

local curlJsonResponse = {}
local strUtil = require('nvim-ai-chat/strUtil')

curlJsonResponse.json = ''

function curlJsonResponse.init(json)

	-- check if the json includes error
	local index = string.find(json, "\"error\":")

	if index ~= nil then 
		local _, _, errorMessage = string.find(json, "\"message\": \"(.-)\",")
		error(errorMessage)
	end

	curlJsonResponse.json = json

	return curlJsonResponse
end

function curlJsonResponse.getAnswer()
	
	local _, _, text = string.find(curlJsonResponse.json, "\"text\":\"(.-)\",\"index")
	text = string.gsub(text, '^\\n\\n', "")

	return strUtil.unescape(text)
end

return curlJsonResponse

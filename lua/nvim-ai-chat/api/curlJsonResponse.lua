local curlJsonResponse = {}
local strUtil = require('nvim-ai-chat/strUtil')

curlJsonResponse.json = ''

function curlJsonResponse.init(json)

	-- check if the json includes error
	local index = string.find(json, "\"error\":")

	if index ~= nil then 
		-- local _, _, errorMessage = string.find(json, "\"code\": \"(.-)\"")
        error(json)
	end

	curlJsonResponse.json = json

	return curlJsonResponse
end

function curlJsonResponse.getAnswer()
	
    local start_index = string.find(curlJsonResponse.json, "\"text\": \"")
    local end_index = string.find(curlJsonResponse.json, ',\n', start_index + 8)
    local text = string.sub(curlJsonResponse.json, start_index + 9, end_index - 2)
    text = string.gsub(text, '^\\n\\n', "")

	return strUtil.unescape(text)
end

return curlJsonResponse

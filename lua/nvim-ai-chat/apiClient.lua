local client = {}

function client.call(question, config)

	local json = client.curl(question, config)

	local isValid, errorMessage = client.validateJson(json)
	if not isValid then return errorMessage end

	local answer = client.getAnswerFromJson(json)

	return client.formatQA(question, answer)

end

function client.curl(question, config)
	local cmd = client.makeCurlCommand(question, config)

    local handle = assert(io.popen(cmd, 'r'))
    local output = assert(handle:read('*a'))
    handle:close()

	return output

end

function client.validateJson(json)
	local index = string.find(json, "\"error\":")

	if index ~= nil then 
		local _, _, errorMessage = string.find(json, "\"message\": \"(.-)\",")
		return false, 'Error: ' .. errorMessage
	else
		return true, ''
	end

end

function client.makeCurlCommand(question, config)

	local token = config.token
	local maxLength = config.maxLength
	local temperature = config.temperature

	local cmd = string.format([[
curl https://api.openai.com/v1/completions -s \
-H "Content-Type: application/json" \
-H "Authorization: Bearer %s" \
-d '{ "model": "text-davinci-003", "prompt": "%s", "temperature": %s, "max_tokens": %s}'
]], token, question, temperature, maxLength)
	return cmd;

end

function client.getAnswerFromJson(json)
	_, _, text = string.find(json, "\"text\":\"\\n\\n(.-)\",\"index")
	return text;

end

function client.formatQA(question, answer)
	return 'Q: ' .. question .. '\nA: ' .. answer .. '\n'

end

return client

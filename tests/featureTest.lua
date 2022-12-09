package.loaded['lua/nvim-ai-chat/apiClient'] = nil
local apiClient = require('lua/nvim-ai-chat/apiClient')
package.loaded['tests/secret'] = nil
local token = require('tests/secret')

-- test to see the actual result
local result = apiClient.call(
	[[what is a conway's law?]],
	{token = token, maxLength = '200', temperature = 0.1})
print(result)

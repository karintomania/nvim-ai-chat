package.loaded['lua/nvim-ai-chat'] = nil
local plugin = require('lua/nvim-ai-chat')

package.loaded['lua/nvim-ai-chat/api/curlClient'] = nil
package.loaded['lua/nvim-ai-chat/api/curlJsonResponse'] = nil
local client = require('lua/nvim-ai-chat/api/curlClient')

package.loaded['tests/secret'] = nil
local secret = require('tests/secret')

config = {token = secret}

plugin.setup(config)

local result = plugin.chat([[what is a conway's law?]])

package.loaded['lua/nvim-ai-chat/display/windowDisplay'] = nil
local windowDisplay = require('lua/nvim-ai-chat/display/windowDisplay')

package.loaded['lua/nvim-ai-chat/display/resultBuffer'] = nil
local resultBuffer = require('lua/nvim-ai-chat/display/resultBuffer')

local handle = resultBuffer.create('test question' ,"test result\nsecond line")

windowDisplay.display(handle)

require('lua/nvim-ai-chat/util').test('windowDisplayTest')

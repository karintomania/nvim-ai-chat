package.loaded['lua/nvim-ai-chat/display/tabDisplay'] = nil
local tabDisplay = require('lua/nvim-ai-chat/display/tabDisplay')

package.loaded['lua/nvim-ai-chat/display/resultBuffer'] = nil
local resultBuffer = require('lua/nvim-ai-chat/display/resultBuffer')

local handle = resultBuffer.create('test question' ,"test result\nsecond line")

tabDisplay.display(handle)



require('lua/nvim-ai-chat/util').test('tabDisplayTest')

package.loaded['lua/nvim-ai-chat/display/openTab'] = nil
local openTab = require('lua/nvim-ai-chat/display/openTab')

package.loaded['lua/nvim-ai-chat/display/Buffer'] = nil
require('lua/nvim-ai-chat/display/Buffer')

local chatBuffer = Buffer:new({bufferName="chat"})
chatBuffer:append("chat!")
local inputBuffer = Buffer:new({bufferName="input"})
inputBuffer:append("input!")

openTab.open(chatBuffer.handle, inputBuffer.handle)

chatWinNum = vim.fn.bufwinnr(chatBuffer.handle)
inputWinNum = vim.fn.bufwinnr(inputBuffer.handle)
vim.fn.assert_notequal(-1, chatWinNum)
vim.fn.assert_notequal(-1, inputWinNum)

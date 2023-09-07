package.loaded['nvim-ai-chat/display/openTab'] = nil
local openTab = require('nvim-ai-chat/display/openTab')

package.loaded['nvim-ai-chat/display/Buffer'] = nil
local buffer = require('nvim-ai-chat/display/Buffer')

_G.config = {inputHeight = 10}

local chatBuffer = buffer("chat")
chatBuffer.append({"chat!"})
local inputBuffer = buffer("input")
inputBuffer.append({"input!"})

openTab.open(chatBuffer.getHandle(), inputBuffer.getHandle())

chatWinNum = vim.fn.bufwinnr(chatBuffer.getHandle())
inputWinNum = vim.fn.bufwinnr(inputBuffer.getHandle())
vim.fn.assert_notequal(-1, chatWinNum)
vim.fn.assert_notequal(-1, inputWinNum)

require('lua/nvim-ai-chat/util').test('openTabTest')

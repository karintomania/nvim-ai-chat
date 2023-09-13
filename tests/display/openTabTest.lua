package.loaded['nvim-ai-chat/display/openTab'] = nil
local openTab = require('nvim-ai-chat/display/openTab')

package.loaded['nvim-ai-chat/display/Buffer'] = nil
local Buffer = require('nvim-ai-chat/display/Buffer')

package.loaded['nvim-ai-chat/api/Config'] = nil
local Config = require('nvim-ai-chat/Config')

Config.init({inputHeight = 10})

local chatBuffer = Buffer:new({bufferName = "chat"})
chatBuffer:append({"chat!"})
local inputBuffer = Buffer:new({bufferName = "input"})
inputBuffer:append({"input!"})

openTab.open(chatBuffer.handle, inputBuffer.handle)

chatWinNum = vim.fn.bufwinnr(chatBuffer.handle)
inputWinNum = vim.fn.bufwinnr(inputBuffer.handle)
vim.fn.assert_notequal(-1, chatWinNum)
vim.fn.assert_notequal(-1, inputWinNum)

require('nvim-ai-chat/util').test('openTabTest')

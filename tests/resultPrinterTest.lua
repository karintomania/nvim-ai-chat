package.loaded['lua/nvim-ai-chat/resultPrinter'] = nil
local resultPrinter = require('lua/nvim-ai-chat/resultPrinter')

package.loaded['lua/nvim-ai-chat/util'] = nil
local util = require('lua/nvim-ai-chat/util')

resultPrinter.print('test question' ,'test result\nsecond line')

local handle = vim.fn.bufnr('Chat_Result')
assert(handle ~= -1)

local lastLines = vim.api.nvim_buf_get_lines(handle, -7, -1, true)
assert(lastLines[1] == 'Q: test question')
assert(lastLines[2] == 'A: test result')
assert(lastLines[3] == 'second line')
assert(lastLines[4] == '')
assert(lastLines[5] == '-------------')
assert(lastLines[6] == '')

print('success!')

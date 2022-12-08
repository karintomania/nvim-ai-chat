package.loaded['lua/nvim-ai-chat/resultPrinter'] = nil
local resultPrinter = require('lua/nvim-ai-chat/resultPrinter')

package.loaded['lua/nvim-ai-chat/util'] = nil
local util = require('lua/nvim-ai-chat/util')

resultPrinter.print('test result\nsecond line')

local handle = vim.fn.bufnr('Chat_Result')
assert(handle ~= -1)

local lastLines = vim.api.nvim_buf_get_lines(handle, -6, -1, true)
assert(lastLines[1] == 'test result')
assert(lastLines[2] == 'second line')
assert(lastLines[3] == '')
assert(lastLines[4] == '-------------')
assert(lastLines[5] == '')

print('success!')

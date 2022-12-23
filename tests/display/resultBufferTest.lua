package.loaded['lua/nvim-ai-chat/display/resultBuffer'] = nil
local resultBuffer = require('lua/nvim-ai-chat/display/resultBuffer')

local handle = resultBuffer.create('test question' ,"test result\nsecond line")

-- test handle is created (-1 means error)
vim.fn.assert_notequal(handle, -1)

local lastLines = vim.api.nvim_buf_get_lines(handle, -7, -1, true)
vim.fn.assert_equal(lastLines[1], 'Q: test question')
vim.fn.assert_equal(lastLines[2], 'A: test result')
vim.fn.assert_equal(lastLines[3], 'second line')
vim.fn.assert_equal(lastLines[4], '')
vim.fn.assert_equal(lastLines[5], '-------------')
vim.fn.assert_equal(lastLines[6], '')

require('lua/nvim-ai-chat/util').test('resultBufferTest')

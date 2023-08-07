package.loaded['lua/nvim-ai-chat/display/InputManager'] = nil
package.loaded['lua/nvim-ai-chat/display/Buffer'] = nil
require('lua/nvim-ai-chat/display/InputManager')

local im = InputManager:new()

-- test the header is set
vim.fn.assert_equal(im.header, im.buffer:read()[1])

local testInput = "test input"
vim.print(im.buffer:read())
im.buffer:append(testInput)
vim.print(im.buffer:read())

vim.fn.assert_equal(1, #im:getQuestion())
vim.fn.assert_equal(testInput, im:getQuestion()[1])

require('lua/nvim-ai-chat/util').test('InputManager')

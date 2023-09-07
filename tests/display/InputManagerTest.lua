package.loaded['nvim-ai-chat/display/InputManager'] = nil
package.loaded['nvim-ai-chat/display/Buffer'] = nil
require('nvim-ai-chat/display/InputManager')

local function test_new_sets_header()
    local im = InputManager:new()
    -- test the header is set
    vim.fn.assert_equal(im.header, im.buffer.read()[1])
end

local function test_getQuestion()
    local im = InputManager:new()
    local testInput = {"test input"}

    im.buffer.append(testInput)

    local question = im:getQuestion()
    vim.fn.assert_equal(1, #question)
    vim.fn.assert_equal(testInput[1], question[1])
end

test_new_sets_header()
test_getQuestion()

require('lua/nvim-ai-chat/util').test('InputManager')

package.loaded['lua/nvim-ai-chat/display/Buffer'] = nil
local Buffer = require('lua/nvim-ai-chat/display/Buffer')

-- test init()
local function testInit()

    local bName = "test_name"
    local bufferNew = Buffer(bName)

    -- test the buffer is created
    local handle = vim.fn.bufnr(bName)
    vim.fn.assert_notequal(-1, handle)

    -- test if the existing buffer is used
    local bufferExist = Buffer(bName)
    vim.fn.assert_equal(handle, bufferExist.getHandle())

    -- clear up buffers
    bufferNew.delete()
end

-- test delete()
local function testDelete()
    local bName = "test_delete"
    local b = Buffer(bName)
    b.delete()

    -- test the buffer is removed
    local handle = vim.fn.bufnr(bName)
    vim.fn.assert_equal(-1, handle)

    -- test the handle property is set to -1
    vim.fn.assert_equal(-1, b.getHandle())

end

-- test append()
local function testAppendAndRead()
    local bName = "test_append"
    local b = Buffer(bName)

    local lines = {"test 1", "test 2"}
    b.append(lines)

    -- test the buffer is removed
    local bufferLines = b.read()
    vim.fn.assert_equal(lines[1], bufferLines[1])
    vim.fn.assert_equal(lines[2], bufferLines[2])

    b.append({"test 3"})

    bufferLines = b.read()
    vim.fn.assert_equal("test 3", bufferLines[3])
    -- clear up buffers
    b.delete()
end

-- -- test empty
local function testEmpty()
    local bName = "test_empty"
    local b = Buffer(bName)
    local str = {"test 1"}
    b.append(str)

    -- make sure the buffer is not empty
    local bufferStr = b.read()
    vim.fn.assert_equal(1, #bufferStr)

    b.empty()

    -- test if the buffer is empty
    bufferStr = b.read()
    vim.fn.assert_equal(1, #bufferStr)
    vim.fn.assert_equal("", bufferStr[1])

    -- clear up buffer
    b.delete()
end

testInit()
testDelete()
testAppendAndRead()
testEmpty()

require('lua/nvim-ai-chat/util').test('BufferTest')

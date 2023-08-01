package.loaded['lua/nvim-ai-chat/strUtil'] = nil
local strUtil = require('lua/nvim-ai-chat/strUtil')

-- unescape() replaces \'
local result = strUtil.unescape([[\'test\']])
vim.fn.assert_equal(result, [['test']])

-- unescape() replaces \"
local result = strUtil.unescape([[\"test\"]])
vim.fn.assert_equal(result, [["test"]])

-- unescape() replaces \n
local result = strUtil.unescape([[test\ntest]])
vim.fn.assert_equal(result, [[test
test]])

-- unescape() replaces \t
local result = strUtil.unescape([[test\ttest]])
vim.fn.assert_equal(result, [[test	test]])


-- escape() escapes '
-- ' is replaced to '\'' for curl command: https://stackoverflow.com/questions/32122586/curl-escape-single-quote
local result = strUtil.escape([['test']])
vim.fn.assert_equal(result, [['\''test'\'']])

-- escape() escapes "
local result = strUtil.escape([["test"]])
vim.fn.assert_equal(result, [[\"test\"]])

-- escape() escapes new line
local result = strUtil.escape([[test
second line]])
vim.fn.assert_equal(result, [[test\nsecond line]])

-- escape() escapes tab
local result = strUtil.escape([[test	test]])
vim.fn.assert_equal(result, ([[test\ttest]]))

require('lua/nvim-ai-chat/util').test('strUtilTest')

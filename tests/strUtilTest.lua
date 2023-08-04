package.loaded['lua/nvim-ai-chat/strUtil'] = nil
local strUtil = require('lua/nvim-ai-chat/strUtil')

-- unescape() replaces \'
local result = strUtil.unescape([[\'test\']])
vim.fn.assert_equal(result, [['test']])

-- unescape() replaces \"
local result = strUtil.unescape([[\"test\"]])
vim.fn.assert_equal([["test"]], result)

-- unescape() replaces \n
local result = strUtil.unescape([[test\ntest]])
vim.fn.assert_equal([[test
test]], result)

-- unescape() replaces \t
local result = strUtil.unescape([[test\ttest]])
vim.fn.assert_equal([[test	test]], result)


-- escape() escapes '
-- ' is replaced to '\'' for curl command: https://stackoverflow.com/questions/32122586/curl-escape-single-quote
local result = strUtil.escape([['test']])
vim.fn.assert_equal([['\''test'\'']], result)

-- escape() escapes "
local result = strUtil.escape([["test"]])
vim.fn.assert_equal([[\"test\"]], result)

-- escape() escapes new line
local result = strUtil.escape([[test
second line]])
vim.fn.assert_equal([[test\nsecond line]], result)

-- escape() escapes tab
local result = strUtil.escape([[test	test]])
vim.fn.assert_equal([[test\ttest]], result)

-- escape() escapes bachslash
local result = strUtil.escape([[{
	"\033"
}]])
vim.fn.assert_equal([[{\n\t\"\\033\"\n}]],result)

require('lua/nvim-ai-chat/util').test('strUtilTest')

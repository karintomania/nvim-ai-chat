package.loaded['lua/nvim-ai-chat/strUtil'] = nil
local strUtil = require('lua/nvim-ai-chat/strUtil')

-- unescape() replaces \'
local result = strUtil.unescape([[\'test\']])
assert(result == [['test']])

-- unescape() replaces \"
local result = strUtil.unescape([[\"test\"]])
assert(result == [["test"]])

-- unescape() replaces \n
local result = strUtil.unescape([[test\ntest]])
assert(result == [[test
test]])


-- escape() escapes '
-- ' is replaced to '\'' for curl command: https://stackoverflow.com/questions/32122586/curl-escape-single-quote
local result = strUtil.escape([['test']])
assert(result == [['\''test'\'']])

-- escape() escapes "
local result = strUtil.escape([["test"]])
assert(result == [[\"test\"]])

print('success!')

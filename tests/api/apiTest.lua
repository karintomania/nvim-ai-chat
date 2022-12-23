
package.loaded['tests/api/mockClient'] = nil
local mock = require('tests/api/mockClient')
local answer = 'test answer'
local question = 'test question'
mock.setAnswer(answer)


package.loaded['lua/nvim-ai-chat/api/api'] = nil
local api = require('lua/nvim-ai-chat/api/api')

resultAnswer = api.call(question, mock, config)
resultQuestion = mock.getQuestion()

vim.fn.assert_equal(answer, resultAnswer)
vim.fn.assert_equal(question, resultQuestion)

require('lua/nvim-ai-chat/util').test('apiTest')

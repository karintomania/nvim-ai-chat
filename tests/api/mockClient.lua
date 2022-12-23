local mockClient = {}

local question = ''
local answer = ''

function mockClient.init(question)
	mockClient.question = question
	return mockClient
end

function mockClient.call()
	return mockClient.answer
end

function mockClient.setAnswer(answer)
	mockClient.answer = answer
end

function mockClient.getQuestion()
	return mockClient.question
end

return mockClient

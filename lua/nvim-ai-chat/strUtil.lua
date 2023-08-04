local strUtil = {}

-- escape special string from question for JSON
function strUtil.escape(text)
	text = string.gsub(text, [[\]], [[\\]])
	text = string.gsub(text, [[	]], [[\t]])
	text = string.gsub(text, "\n", [[\n]])
	text = string.gsub(text, [["]], [[\"]])
	text = string.gsub(text, [[']], [['\'']])
	return text
end

-- retrieve original content from JSON response
function strUtil.unescape(text)
	text = string.gsub(text, '\\n', '\n')
	text = string.gsub(text, [[\']], [[']])
	text = string.gsub(text, [[\"]], [["]])
	text = string.gsub(text, [[\t]], [[	]])
	return text
end

return strUtil

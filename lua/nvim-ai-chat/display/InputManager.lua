local Buffer = require('nvim-ai-chat/display/Buffer')

local InputManager = {header = "-- type your question below --"}

function InputManager:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    local bufferName = "Chat_Input"

    o.buffer = Buffer:new({bufferName = bufferName})
    o:reset()
    return o
end

function InputManager:getQuestion()

    local lines = self.buffer:read()
    -- remove header
    table.remove(lines, 1)
    return lines
end

function InputManager:reset()
    self.buffer:empty()
    self.buffer:append({self.header})
end

function InputManager:validateQuestion()
    local questionLines = self:getQuestion()

    if #questionLines == 0 then
        -- when the tab hasn't opened, #questionLines returns 0
        -- as the Go command hasn't excuted, the buffer doesn't have newline after the header.
        return false
    end

    local q = table.concat(questionLines)
    if q == "" then
        vim.api.nvim_err_writeln("question shouldn't be blank!!")
        return false
    end

    return true
end

return InputManager

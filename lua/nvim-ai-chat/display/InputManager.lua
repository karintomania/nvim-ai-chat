require('nvim-ai-chat/display/Buffer')

InputManager = {header = "-- type your question below --"}

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


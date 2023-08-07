Buffer = {bufferName=""}

function Buffer:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    o:init()
    return o
end

function Buffer:init()
    -- bufferName shouldn't be blank
    assert(self.bufferName ~= "")

	-- get buffer handle by name
	local handle = vim.fn.bufnr(self.bufferName)

	-- if the buffer doesn't exist, create a new one
	if handle == -1 then
		handle = vim.api.nvim_create_buf(true, true)
	end
    self.handle = handle
    vim.api.nvim_buf_set_name(handle, self.bufferName)
    vim.api.nvim_buf_set_option(self.handle, "modifiable", true)
end

-- append lines to the buffer
function Buffer:append(lines)

    local currentLines = self:read()

    -- Remove the first new line of empty buffer if it is empty
    if #currentLines <= 1 then
        start = 0
    else
        start = -1
    end

    vim.api.nvim_buf_set_lines(self.handle, start, -1, true, lines)
end

-- return the content of the buffer as array of string
function Buffer:read()
    return vim.api.nvim_buf_get_lines(self.handle, 0, -1, false)
end

-- empty the content of buffer
function Buffer:empty()
    vim.api.nvim_buf_set_lines(self.handle, 0, -1, true, {})
end

-- delete the buffer
function Buffer:delete()
  vim.api.nvim_buf_delete(self.handle, {force = true})
  self.handle = -1
end

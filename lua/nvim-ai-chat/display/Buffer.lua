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
		handle = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(handle, self.bufferName)
	end
    self.handle = handle
end

-- append the string to the buffer
function Buffer:append(str)

	local strAry = {}
	for line in string.gmatch(str, "[^\n]+") do
	  -- insert each line into the table as a new element
	  table.insert(strAry, line)
	end
    vim.api.nvim_buf_set_option(self.handle, "modifiable", true)
    local lines = self:read()

    -- Remove the first new line of empty buffer if it is empty
    if #lines == 0 then
        start = 0
    else
        start = -1
    end

    vim.api.nvim_buf_set_lines(self.handle, 0, -1, true, strAry)
    vim.api.nvim_buf_set_option(self.handle, "modifiable", false)
end

-- return the content of the buffer as array of string
function Buffer:read()
    return vim.api.nvim_buf_get_lines(self.handle, 0, -1, false)
end

-- empty the content of buffer
function Buffer:empty()
    vim.api.nvim_buf_set_option(self.handle, "modifiable", true)
    vim.api.nvim_buf_set_lines(self.handle, 0, -1, true, {})
    vim.api.nvim_buf_set_option(self.handle, "modifiable", false)
end

-- delete the buffer
function Buffer:delete()
  vim.api.nvim_buf_delete(self.handle, {force = true})
  self.handle = -1
end

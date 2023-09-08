local function Buffer(bufferName)

    function init()
        -- bufferName shouldn't be blank
        vim.fn.assert_notequal(bufferName, "")

        -- get buffer handle by name
        local handle = vim.fn.bufnr(bufferName)

        -- if the buffer doesn't exist, create a new one
        if handle == -1 then handle = vim.api.nvim_create_buf(true, true) end
        vim.api.nvim_buf_set_name(handle, bufferName)
        vim.api.nvim_buf_set_option(handle, "modifiable", true)
        return handle
    end

    local handle = init()

    local function read()
        return vim.api.nvim_buf_get_lines(handle, 0, -1, false)
    end

    local function append(lines)
        local currentLines = read()
        -- Remove the first new line of empty buffer if it is empty
        local start
        if #currentLines == 0 or (#currentLines == 1 and currentLines[1] == "") then
            start = 0
        else
            start = -1
        end
        vim.api.nvim_buf_set_lines(handle, start, -1, true, lines)
    end

    local function empty()
        vim.api.nvim_buf_set_lines(handle, 0, -1, true, {})
    end

    local function delete()
        vim.api.nvim_buf_delete(handle, {force = true})
        handle = -1
        bufferName = ""
    end

    return {
        bufferName = bufferName,
        append = append,
        read = read,
        empty = empty,
        delete = delete,
        getHandle = function() return handle end,
        getBufferName = function() return bufferName end,
    }
end

return Buffer

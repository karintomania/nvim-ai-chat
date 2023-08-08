local openTab = {}

function openTab.open(chatHandler, inputHandler)

    -- open (or move to) the tab in which the chat buffer is opening
    local chatBuffName = vim.api.nvim_buf_get_name(chatHandler)
    vim.cmd('tab drop ' .. chatBuffName)

    local winnr = vim.fn.bufwinnr(inputHandler)
    if winnr == -1 then
        -- if input buffer isn't open, open as a new split window
        vim.cmd("split")
        vim.cmd('wincmd j')
        vim.api.nvim_command("buffer " .. inputHandler)
    else
        -- if the buffer is open, move to the window
        vim.cmd('wincmd j')

    end

    -- go to the end of the buffer
    vim.api.nvim_command('normal! Go')
    -- enter insert mode to input question
    vim.api.nvim_command("resize ".._G.config.inputHeight)
    vim.api.nvim_command("startinsert!")
end

return openTab

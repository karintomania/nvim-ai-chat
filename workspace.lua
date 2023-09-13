function FormatLua()
    local file_path = vim.fn.expand('%:p')
    os.execute('lua-format -i ' .. file_path .. ' -c .lua-format.yml')
    print("formatted " .. file_path)
    -- reload the file
    vim.cmd('e')
end

vim.cmd('command! Format lua FormatLua()')

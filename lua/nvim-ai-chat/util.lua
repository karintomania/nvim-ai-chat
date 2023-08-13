local util = {}

function util.test(testName)
    if next(vim.v.errors) then
        print("Fail: " .. testName)
        vim.print(vim.v.errors)
        vim.v.errors = {}
    else
        print("Success: " .. testName)
    end
end
return util

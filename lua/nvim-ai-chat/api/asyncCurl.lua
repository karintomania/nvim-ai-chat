local asyncCurl = {}
function asyncCurl.call(options, callback)
    local uv = vim.loop
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()

    vim.print(options)
    local handle, pid = uv.spawn("curl", {
        args = options, stdio = {nil, stdout, stderr}
    }, function(code, signal) -- on exit
        if code == 0 then
            uv.read_start(stdout, function(err, data)
              assert(not err, err)
              if data then
                -- call the callback fn
                callback(data)
              end
            end)
        else
            -- when exit code isn't 0
            uv.read_start(stderr, function(err, data)
              assert(not err, err)
              if data then
                error("error:" .. data)
              end
            end)
        end
    end)

end

return asyncCurl
-- local body = '{"model": "gpt-3.5-turbo", "messages": [{"role": "user", "content": "Who won the world series in 2020?"}]}'
-- asyncCurl(body, function(res) vim.print(res) end)

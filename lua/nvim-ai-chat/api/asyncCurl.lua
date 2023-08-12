local asyncCurl = {}
function asyncCurl.call(options, callback)
    local uv = vim.loop
    local stdout = uv.new_pipe()
    local stderr = uv.new_pipe()

    local handle, pid = uv.spawn("curl", {
        args = options, stdio = {nil, stdout, stderr}
    }, function(code, signal) -- on exit
        if code == 0 then
            -- on successful curl
            uv.read_start(stdout, function(err, data)
              assert(not err, err)
              if data then
                -- call the callback fn
                callback(data)
              end
            end)
        else
            -- on error (exit code isn't 0)
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

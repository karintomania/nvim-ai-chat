local Config = {}

function Config.init(customConfig)

    local default = {token = '', model = "gpt-3.5-turbo", inputHeight = 10}
    local filled = vim.tbl_deep_extend("keep", customConfig, default)
    _G.NVIM_AI_CHAT_CONFIG = filled
end

function Config.get(key)
    assert(_G.NVIM_AI_CHAT_CONFIG ~= nil, "Config must be initialized first")

    return _G.NVIM_AI_CHAT_CONFIG[key]
end

return Config

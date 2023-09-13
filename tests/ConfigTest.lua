package.loaded['nvim-ai-chat/Config'] = nil

local function config_stores_and_returns_config()

    local Config = require('nvim-ai-chat/Config')
    Config.init({testKey = "test!"})

    local result = Config.get("testKey")

    vim.fn.assert_equal("test!", result)
end

local function config_saves_values_on_global()
    local Config = require('nvim-ai-chat/Config')
    local result = Config.get("testKey")

    vim.fn.assert_equal("test!", result)
end

config_stores_and_returns_config()
config_saves_values_on_global()
require('nvim-ai-chat/util').test('configTest')

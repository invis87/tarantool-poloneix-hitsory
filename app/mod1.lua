local log = require 'log'

local M = {}
local app
local http_client
local json

function M.init(config)
    app = require 'app'
    json = require 'json'
    M.config = config
    http_client = require('http.client').new({5})
end

function M.http(depth)
    local url = 'https://poloniex.com/public?command=returnOrderBook&currencyPair=BTC_NXT&depth='..depth
    local response = http_client:request('GET', url)
    if response.body then
        return json.decode(response.body)
    end
end

function M.sum(accum, n)
    if n > 0 then
        accum.value = accum.value + n
        return M.sum(accum, n-1)
    end
end

function M.tlog()
    local message = 'test message'
    log.error('error lvl '..message)
    log.warn('warn lvl '..message)
    log.info('info lvl '..message)
    log.verbose('verbose lvl '..message)
    log.debug('debug lvl '..message)
end

function M.destroy()
end

return M

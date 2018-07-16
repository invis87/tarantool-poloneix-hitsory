local log = require 'log'
require('libraries.functions')

local M = {}
local app
local http_client
local json
local fiber

function M.init(config)
    app = require 'app'
    json = require 'json'
    fiber = require 'fiber'
    M.config = config
    http_client = require('http.client').new({5})
end

local function get_average_price(bids)
    local multiple_function = function(t) return t[1]*t[2] end
    local amount_on_price = map(multiple_function, bids)
    return reduce(operator.add, amount_on_price)
end

function M.bts_to_usdt_avg_price(depth)
    local url = 'https://poloniex.com/public?command=returnOrderBook&currencyPair=USDT_BTC&depth='..depth
    local response = http_client:request('GET', url)
    if response.body then
        local orders = json.decode(response.body)
        local sells = get_average_price(orders.asks)
        local buys = get_average_price(orders.bids)
        return sells, buys
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

function M.tfiber(channel)
    local function fiber_function(f_object)
        local function work_with_fiber_storage()
            if f_object.f then
                if f_object.f.storage.x == nil then
                    f_object.f.storage.x = 0
                end
                log.info('fiber_object:self() = '..f_object.f.storage.x)
                f_object.f.storage.x = f_object.f.storage.x + 1
            else
                log.info('fiber_object is nil!')
            end
        end

        local running = true
        while running do
            local task = channel:get()
            if task ~= nil then
                log.info('fiber woke up, receive '..task)
                work_with_fiber_storage()
            else
                log.info('channel is close, so stop fiber')
                running = false
            end
        end
    end
    local fiber_object = {f = nil}
    fiber_object.f = fiber.create(fiber_function, fiber_object)
    fiber_object.f:name('test_fiber')
    return fiber_object
end

function M.destroy()
end

return M

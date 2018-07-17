--
-- Created by IntelliJ IDEA.
-- User: pronvis
-- Date: 06/07/2018
-- Time: 21:45
-- To change this template use File | Settings | File Templates.
--

local spacer = require 'spacer'

spacer:space({
    name = 'usdt_btc_orders',
    format = {
        { name = 'id', type = 'unsigned', is_nullable = false },
        { name = 'sells', type = 'number', is_nullable = false },
        { name = 'buys', type = 'number', is_nullable = false },
        { name = 'avg_sell_price', type = 'number', is_nullable = false },
        { name = 'avg_buy_price', type = 'number', is_nullable = false }
    },
    indexes = {
        { name = 'primary', type = 'tree', unique = true, parts = {'id'}, sequence = false }
    }
})
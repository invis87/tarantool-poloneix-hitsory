--
-- Created by IntelliJ IDEA.
-- User: pronvis
-- Date: 06/07/2018
-- Time: 21:45
-- To change this template use File | Settings | File Templates.
--

local spacer = require 'spacer'

spacer:space({
    name = 'object',
    format = {
        { name = 'id', type = 'unsigned' },
        { name = 'name', type = 'string', is_nullable = true },
    },
    indexes = {
        { name = 'primary', type = 'tree', unique = true, parts = {'id'}, sequence = true },
        { name = 'name', type = 'tree', unique = false, parts = {'name', 'id'} },
    }
})


local conf = require 'config'
local log = require 'log'

box.once('access:v1', function()
    box.schema.user.grant('guest', 'read,write,execute', 'universe')

    box.schema.user.create('replicator', {password = 'password'})
    box.schema.user.grant('replicator', 'replication') -- grant replication role

    -- Uncomment this to create user poloneix-hitsory_user
    -- box.schema.user.create('poloneix-hitsory_user', { password = 'poloneix-hitsory_pass' })
    -- box.schema.user.grant('poloneix-hitsory_user', 'read,write,execute', 'universe')
end)

local app = {
    main = require 'main',
    filler = require 'fill_prices',
    spacer = require 'spacer'({
        migrations = 'migrations',
    }),
}
require 'models'

function app.init(config)
    log.info('app "poloneix-hitsory" init')


    for k, mod in pairs(app) do if type(mod) == 'table' and mod.init ~= nil then mod.init(config) end end
end

function app.destroy()
    log.info('app "poloneix-hitsory" destroy')

    for k, mod in pairs(app) do if type(mod) == 'table' and mod.destroy ~= nil then mod.destroy() end end
end

package.reload:register(app)
rawset(_G, 'app', app)
return app

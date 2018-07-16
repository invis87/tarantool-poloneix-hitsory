local bg
local logger
if os.getenv('FG') then
    bg = false
    logger = '| tee'
end

box = {
    listen = os.getenv("LISTEN") or "127.0.0.1:3301",
    memtx_memory = 100 * 1024 * 1024, -- 100 MB
    background = bg,
    log = logger,
    log_level = 5,

    read_only = false,
    --replication = {
    --    'replicator:password@127.0.0.1:3302',
    --    'replicator:password@127.0.0.1:3303',
    --    'replicator:password@127.0.0.1:3304'},
}


app = {
}

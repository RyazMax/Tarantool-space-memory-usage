#!/usr/bin/env tarantool
local fio = require('fio')
local csv = require('csv')

local function cast_to_number(tuple)
    local res = {}
    for i, val in ipairs(tuple) do
        local num = tonumber(val)
        if num then
            res[i] = num
        else
            res[i] = val
        end
    end
    return res 
end

function size_info()
    local space = tonumber(box.space.tester:bsize()) 
    local index = tonumber(box.space.tester.index.primary:bsize()) 
    return {
        space = space,
        index = index,
        total = space + index,
    }
end

-- настроить базу данных
box.cfg {
    listen = 3301,
}

box.schema.space.create('tester')
box.space.tester:create_index('primary',
    { type = 'hash', parts = {1, 'integer'}})
local f = fio.open('/data.csv', {'O_RDONLY'})
for i, tup in csv.iterate(f) do
    box.space.tester:insert(cast_to_number(tup))
end

for key, val in pairs(size_info()) do
    print(key, ": ", val)
end
print("Arena used: ", box.slab.info().arena_used)

box.snapshot()

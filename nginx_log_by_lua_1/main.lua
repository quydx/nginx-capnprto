local logs = require "Logs_capnp"
local capnp = require "capnp"
local cjson = require "cjson"
local util = require "capnp.util"

local data = {
    document = {
        {
            id = 123,
            host = "Alice",
            uri = "alice@example.com",
        },
        {
            id = 456,
            host = "Bob",
            uri = "bob@example.com",
        },
    }
}

local bin = logs.Logs.serialize(data)
local decoded = logs.Logs.parse(bin)

ngx.say(cjson.encode(decoded))

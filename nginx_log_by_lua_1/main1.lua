local logs = require "Logs_capnp"
local capnp = require "capnp"
local cjson = require "cjson"
local util = require "capnp.util"
local socket = require "socket"
local host, port = "127.0.0.1", 12345
local tcp = assert(socket.tcp())
tcp:connect(host, port);

-- local data = {
--     document = {
--         {
--             id = 123,
--             host = "Alice",
--             uri = "alice@example.com",
--         },
--         {
--             id = 456,
--             host = "Bob",
--             uri = "bob@example.com",
--         },
--     }
-- }


-- local bin = logs.Logs.serialize(data)
-- local decoded = logs.Logs.parse(bin)

local client = capnp.TwoPartyClient(tcp)
local tempconv = client.bootstrap().cast_as(tempconv_capnp.TempConv)

local request = tempconv.convert_request()

local request.temp.value = 100
local request.temp.unit = 'c'
local request.target_unit = 'k'

local promise = request.send()

-- tcp:send(bin);

ngx.say('send to server ' + cjson.encode(decoded))

-- while true do
--     local s, status, partial = tcp:receive()
--     print(s or partial)
--     if status == "closed" then break end
-- end
-- tcp:close()
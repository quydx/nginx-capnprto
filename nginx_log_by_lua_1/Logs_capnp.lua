-- Generated by lua-capnproto 0.1.3-1 on Mon Apr 23 06:59:36 2018
-- https://github.com/cloudflare/lua-capnproto.git


local ffi = require "ffi"
local capnp = require "capnp"
local bit = require "bit"

local ceil              = math.ceil
local write_struct_field= capnp.write_struct_field
local read_struct_field = capnp.read_struct_field
local read_text         = capnp.read_text
local write_text        = capnp.write_text
local get_enum_val      = capnp.get_enum_val
local get_enum_name     = capnp.get_enum_name
local get_data_off      = capnp.get_data_off
local write_listp_buf   = capnp.write_listp_buf
local write_structp_buf = capnp.write_structp_buf
local write_structp     = capnp.write_structp
local read_struct_buf   = capnp.read_struct_buf
local read_listp_struct = capnp.read_listp_struct
local read_list_data    = capnp.read_list_data
local write_list        = capnp.write_list
local write_list_data   = capnp.write_list_data
local ffi_new           = ffi.new
local ffi_string        = ffi.string
local ffi_cast          = ffi.cast
local ffi_copy          = ffi.copy
local ffi_fill          = ffi.fill
local ffi_typeof        = ffi.typeof
local band, bor, bxor = bit.band, bit.bor, bit.bxor

local pint8    = ffi_typeof("int8_t *")
local pint16   = ffi_typeof("int16_t *")
local pint32   = ffi_typeof("int32_t *")
local pint64   = ffi_typeof("int64_t *")
local puint8   = ffi_typeof("uint8_t *")
local puint16  = ffi_typeof("uint16_t *")
local puint32  = ffi_typeof("uint32_t *")
local puint64  = ffi_typeof("uint64_t *")
local pbool    = ffi_typeof("uint8_t *")
local pfloat32 = ffi_typeof("float *")
local pfloat64 = ffi_typeof("double *")


local ok, new_tab = pcall(require, "table.new")

if not ok then
    new_tab = function (narr, nrec) return {} end
end

local round8 = function(size)
    return ceil(size / 8) * 8
end

local str_buf
local default_segment_size = 4096

local function get_str_buf(size)
    if size > default_segment_size then
        return ffi_new("char[?]", size)
    end

    if not str_buf then
        str_buf = ffi_new("char[?]", default_segment_size)
    end
    return str_buf
end

-- Estimated from #nodes, not accurate
local _M = new_tab(0, 3)


_M.Log = {
    id = "9230993565969974723",
    displayName = "Logs.capnp:Log",
    dataWordCount = 1,
    pointerCount = 2,
    discriminantCount = 0,
    discriminantOffset = 0,
    field_count = 3,

    fields = {
        { name = "id", default = 0, ["type"] = "uint32" },
        { name = "host", default = "", ["type"] = "text" },
        { name = "uri", default = "", ["type"] = "text" },
    },

    calc_size_struct = function(data)
        local size = 24
        local value
        -- text
        value = data["host"]
        if type(value) == "string" then
            -- size 1, including trailing NULL
            size = size + round8(#value + 1)
        end
        -- text
        value = data["uri"]
        if type(value) == "string" then
            -- size 1, including trailing NULL
            size = size + round8(#value + 1)
        end
        return size
    end,

    calc_size = function(data)
        local size = 16 -- header + root struct pointer
        return size + _M.Log.calc_size_struct(data)
    end,

    flat_serialize = function(data, p32, pos)
        pos = pos and pos or 24 -- struct size in bytes
        local start = pos
        local dscrm
        local value

        value = data["id"]
        local data_type = type(value)
        if (data_type == "number"
                or data_type == "boolean" ) then

            write_struct_field(p32, value, "uint32", 32, 0, 0)
        end

        value = data["host"]
        if type(value) == "string" then
            local data_off = get_data_off(_M.Log, 0, pos)

            local len = #value + 1
            write_listp_buf(p32, _M.Log, 0, 2, len, data_off)

            ffi_copy(p32 + pos / 4, value)
            pos = pos + round8(len)
        end

        value = data["uri"]
        if type(value) == "string" then
            local data_off = get_data_off(_M.Log, 1, pos)

            local len = #value + 1
            write_listp_buf(p32, _M.Log, 1, 2, len, data_off)

            ffi_copy(p32 + pos / 4, value)
            pos = pos + round8(len)
        end
        return pos - start + 24
    end,

    serialize = function(data, p8, size)
        if not p8 then
            size = _M.Log.calc_size(data)

            p8 = get_str_buf(size)
        end
        ffi_fill(p8, size)
        local p32 = ffi_cast(puint32, p8)

        -- Because needed size has been calculated, only 1 segment is needed
        p32[0] = 0
        p32[1] = (size - 8) / 8

        -- skip header
        write_structp(p32 + 2, _M.Log, 0)

        -- skip header & struct pointer
        _M.Log.flat_serialize(data, p32 + 4)

        return ffi_string(p8, size)
    end,

    parse_struct_data = function(p32, data_word_count, pointer_count, header,
            tab)

        local s = tab

        s["id"] = read_struct_field(p32, "uint32", 32, 0, 0)

        -- text
        local off, size, num = read_listp_struct(p32, header, _M.Log, 0)
        if off and num then
            -- dataWordCount + offset + pointerSize + off
            local p8 = ffi_cast(pint8, p32 + (1 + 0 + 1 + off) * 2)
            s["host"] = ffi_string(p8, num - 1)
        else
            s["host"] = nil
        end

        -- text
        local off, size, num = read_listp_struct(p32, header, _M.Log, 1)
        if off and num then
            -- dataWordCount + offset + pointerSize + off
            local p8 = ffi_cast(pint8, p32 + (1 + 1 + 1 + off) * 2)
            s["uri"] = ffi_string(p8, num - 1)
        else
            s["uri"] = nil
        end

        return s
    end,

    parse = function(bin, tab)
        if #bin < 16 then
            return nil, "message too short"
        end

        local header = new_tab(0, 4)
        local p32 = ffi_cast(puint32, bin)
        header.base = p32

        local nsegs = p32[0] + 1
        header.seg_sizes = {}
        for i=1, nsegs do
            header.seg_sizes[i] = p32[i]
        end
        local pos = round8(4 + nsegs * 4)
        header.header_size = pos / 8
        p32 = p32 + pos / 4

        if not tab then
            tab = new_tab(0, 8)
        end
        local off, dw, pw = read_struct_buf(p32, header)
        if off and dw and pw then
            return _M.Log.parse_struct_data(p32 + 2 + off * 2, dw, pw,
                    header, tab)
        else
            return nil
        end
    end,

}

_M.Logs = {
    id = "15054250960931655129",
    displayName = "Logs.capnp:Logs",
    dataWordCount = 0,
    pointerCount = 1,
    discriminantCount = 0,
    discriminantOffset = 0,
    field_count = 1,

    fields = {
        { name = "document", default = "opaque pointer", ["type"] = "list" },
    },

    calc_size_struct = function(data)
        local size = 8
        local value
        -- list
        if data["document"] and type(data["document"]) == "table" then
            size = size + 8
            local num2 = #data["document"]
            for i2=1, num2 do
                size = size + _M.Log.calc_size_struct(data["document"][i2])
            end
        end
        return size
    end,

    calc_size = function(data)
        local size = 16 -- header + root struct pointer
        return size + _M.Logs.calc_size_struct(data)
    end,

    flat_serialize = function(data, p32, pos)
        pos = pos and pos or 8 -- struct size in bytes
        local start = pos
        local dscrm
        local value

        value = data["document"]
        if type(value) == "table" then
            local data_off = get_data_off(_M.Logs, 0, pos)
            pos = pos + write_list(p32 + _M.Logs.dataWordCount * 2 + 0 * 2,
                    value, (data_off + 1) * 8, "list", "struct", _M.Log)
        end
        return pos - start + 8
    end,

    serialize = function(data, p8, size)
        if not p8 then
            size = _M.Logs.calc_size(data)

            p8 = get_str_buf(size)
        end
        ffi_fill(p8, size)
        local p32 = ffi_cast(puint32, p8)

        -- Because needed size has been calculated, only 1 segment is needed
        p32[0] = 0
        p32[1] = (size - 8) / 8

        -- skip header
        write_structp(p32 + 2, _M.Logs, 0)

        -- skip header & struct pointer
        _M.Logs.flat_serialize(data, p32 + 4)

        return ffi_string(p8, size)
    end,

    parse_struct_data = function(p32, data_word_count, pointer_count, header,
            tab)

        local s = tab

        -- list
        local off, size, num = read_listp_struct(p32, header, _M.Logs, 0)
        if off and num then
            -- dataWordCount + offset + pointerSize + off
            s["document"] = read_list_data(p32 + (0 + 0 + 1 + off) * 2, header,
                    num, "struct", _M.Log)
        else
            s["document"] = nil
        end

        return s
    end,

    parse = function(bin, tab)
        if #bin < 16 then
            return nil, "message too short"
        end

        local header = new_tab(0, 4)
        local p32 = ffi_cast(puint32, bin)
        header.base = p32

        local nsegs = p32[0] + 1
        header.seg_sizes = {}
        for i=1, nsegs do
            header.seg_sizes[i] = p32[i]
        end
        local pos = round8(4 + nsegs * 4)
        header.header_size = pos / 8
        p32 = p32 + pos / 4

        if not tab then
            tab = new_tab(0, 8)
        end
        local off, dw, pw = read_struct_buf(p32, header)
        if off and dw and pw then
            return _M.Logs.parse_struct_data(p32 + 2 + off * 2, dw, pw,
                    header, tab)
        else
            return nil
        end
    end,

}

return _M

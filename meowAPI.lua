local socket = require("socket")
local https = require("ssl.https")
local ltn12 = require("ltn12")
local cjson = require("cjson")

local meowAPI = {}
local DEFAULT_TIMEOUT = 30
https.TIMEOUT = DEFAULT_TIMEOUT

local function buildHeaders(extra)
    local headers = {
        ["User-Agent"] = "luaMeowAPILib/2.0",
        ["Cache-Control"] = "no-cache, max-age=0, must-revalidate",
        ["Connection"] = "close",
        ["Date"] = os.date("!%a, %d %b %Y %H:%M:%S GMT"),
        ["Accept-Charset"] = "utf-8"
    }
    if extra then
        for k, v in pairs(extra) do
            headers[k] = v
        end
    end
    return headers
end

local function request(url, extraHeaders)
    local sink = {}
    local code, err = https.request({
        url = url,
        method = "GET",
        headers = buildHeaders(extraHeaders),
        sink = ltn12.sink.table(sink),
        timeout = DEFAULT_TIMEOUT
    })
    if not code then
        return nil, err
    end
    if code < 200 or code >= 300 then
        return nil, "HTTP " .. code .. " for " .. url
    end
    return table.concat(sink)
end

local function requestJSON(url)
    local body, err = request(url, { ["Accept"] = "application/json" })
    if not body then
        return nil, err
    end
    local ok, result = pcall(cjson.decode, body)
    if not ok then
        return nil, "Invalid JSON response: " .. result
    end
    return result
end

local function listHouses(endpoint)
    local start = socket.gettime()
    local result, err = requestJSON("https://api.meow.camera/catHouses/" .. endpoint)
    if not result then
        return nil, err
    end
    result.time = socket.gettime() - start
    return result
end

function meowAPI.getRandom()
    return listHouses("random")
end

function meowAPI.getFeatured()
    return listHouses("featured")
end

function meowAPI.getInfo(target)
    if not target then
        return nil, "target is required"
    end
    local start = socket.gettime()

    local info, err = requestJSON("https://api.meow.camera/catHouse/" .. target)
    if not info then
        return nil, err
    end

    local ping, err2 = requestJSON("https://api.meow.camera/catHouse/" .. target .. "/ping/front")
    if not ping then
        return nil, err2
    end

    info.url = ping.url
    info.time = socket.gettime() - start
    return info
end

function meowAPI.getImg(target)
    if not target or not target.images or not target.images[1] then
        return nil, "target has no images"
    end
    local data, err = request(target.images[1], { ["Accept"] = "image/jpeg" })
    if not data then
        return nil, err
    end
    return data
end

return meowAPI

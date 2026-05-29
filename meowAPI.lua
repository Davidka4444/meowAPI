local socket = require("socket.http")
local https = require("ssl.https")
local ltn12 = require("ltn12")
local cjson = require("cjson")
https.TIMEOUT = 30

local meowAPI = {}

function meowAPI.getRandom()
    local startTime = os.time()
    local response = {}
    https.request({
        url = "https://api.meow.camera/catHouses/random",
        method = "GET",
        headers = {
            ["User-Agent"] = "luaMeowAPILib/1.1",
            ["Cache-Control"] = "no-cache, max-age=0, must-revalidate",
            ["Connection"] = "close",
            ["Date"] = os.date("!%a, %d %b %Y %H:%M:%S GMT"),
            ["Accept"] = "application/json",
            ["Accept-Charset"] = "utf-8"
        },
        sink = ltn12.sink.table(response)
    })
    local result = cjson.decode(table.concat(response))
    result.time = os.time()-startTime

    return result
end

function meowAPI.getFeatured()
    local startTime = os.time()
    local response = {}
    https.request({
        url = "https://api.meow.camera/catHouses/featured",
        method = "GET",
        headers = {
            ["User-Agent"] = "luaMeowAPILib/1.1",
            ["Cache-Control"] = "no-cache, max-age=0, must-revalidate",
            ["Connection"] = "close",
            ["Date"] = os.date("!%a, %d %b %Y %H:%M:%S GMT"),
            ["Accept"] = "application/json",
            ["Accept-Charset"] = "utf-8"
        },
        sink = ltn12.sink.table(response)
    })
    local result = cjson.decode(table.concat(response))
    result.time = os.time()-startTime

    return result
end

function meowAPI.getInfo(target)
    local startTime = os.time()
    local response1 = {}
    local response2 = {}
    
    https.request({
        url = "https://api.meow.camera/catHouse/"..target,
        method = "GET",
        headers = {
            ["User-Agent"] = "luaMeowAPILib/1.1",
            ["Cache-Control"] = "no-cache, max-age=0, must-revalidate",
            ["Connection"] = "close",
            ["Date"] = os.date("!%a, %d %b %Y %H:%M:%S GMT"),
            ["Accept"] = "application/json",
            ["Accept-Charset"] = "utf-8"
        },
        sink = ltn12.sink.table(response1)
    })
    
    https.request({
        url = "https://api.meow.camera/catHouse/"..target.."/ping/front",
        method = "GET",
        headers = {
            ["User-Agent"] = "luaMeowAPILib/1.1",
            ["Cache-Control"] = "no-cache, max-age=0, must-revalidate",
            ["Connection"] = "close",
            ["Date"] = os.date("!%a, %d %b %Y %H:%M:%S GMT"),
            ["Accept"] = "application/json",
            ["Accept-Charset"] = "utf-8"
        },
        sink = ltn12.sink.table(response2)
    })

    local result1 = cjson.decode(table.concat(response1))
    local result2 = cjson.decode(table.concat(response2))
    result1.url = result2.url

    result1.time = os.time()-startTime

    return result1
end

function meowAPI.getImg(target)
    local response = {}

    https.request({
        url = target.images[1],
        method = "GET",
        headers = {
            ["User-Agent"] = "luaMeowAPILib/1.1",
            ["Cache-Control"] = "no-cache, max-age=0, must-revalidate",
            ["Connection"] = "close",
            ["Date"] = os.date("!%a, %d %b %Y %H:%M:%S GMT"),
            ["Accept"] = "image/jpeg",
            ["Accept-Charset"] = "utf-8"
        },
        sink = ltn12.sink.table(response)
    })

    return table.concat(response)
end

return meowAPI

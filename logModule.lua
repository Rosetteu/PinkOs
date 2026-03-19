local log = {}

local modem = peripheral.find("modem")
local debugChannel = 0
if debugChannel == 0 or not modem then
    debugChannel = false
else
    modem.open(debugChannel)
end

if not enum then _G.enum = {} end
if not enum.logType then _G.enum.logType = { debug = { name = "debug", level = 0 }, warn = { name = "warn", level = 1 }, error = { name = "error", level = 2 }, critical = { name = "critical", level = 3 }, unknown = { name = "debug", level = 4 } } end

local timestamp = tostring(os.epoch("utc"))
fs.makeDir("./logs")
local logPath = "./logs/" .. timestamp .. ".log"
local last = "./logs/last.log"

local updateLast = function()
    writeFile(last, readFile(logPath))
end

log.add = function(lType, message, fileName, forceShutdown)
    lType = lType or enum.logType.unknown
    message = message or "No message provided."
    if forceShutdown == nil then forceShutdown = true end

    local info = debug.getinfo(2, "S")
    local caller = info and info.short_src or "unknown"
    fileName = fileName or caller

    local timeStr = string.format("%.2f", os.clock())
    local line = timeStr .. " - " .. fileName .. " : [" .. string.upper(lType.name) .. "] | " .. tostring(message)

    if debugChannel and modem then
        modem.transmit(debugChannel, 0, line)
    end

    addLineToFile(logPath, line)

    if lType.level == 1 then
        local current = term.getTextColor()
        term.setTextColour(colors.red)
        print(message)
        term.setTextColour(current)
    end

    if lType.level == 1 then
        local current = term.getTextColor()
        term.setTextColour(colors.red)
        print(message)
        term.setTextColour(current)
    end

    if forceShutdown and lType.level > 1 then
        local shutdownMsg = timeStr .. " - SYSTEM : [" .. string.upper(lType.name) .. "] | Computer shutdown."
        addLineToFile(logPath, shutdownMsg)
        if debugChannel and modem then modem.transmit(debugChannel, 0, shutdownMsg) end

        updateLast()
        sleep(0.5)

        term.clear()
        term.setCursorPos(1,1)
        term.setTextColor(colors.purple)
        print("critical error. Contact @rosetteu on Discord")
        print("")
        print("Error :")
        term.write(message)
        while true do
            os.pullEvent()
        end
    end
    updateLast()
end

log.clearAll = function()
    local files = fs.list("/logs/")
    for i = 1, #files do
        fs.delete("/logs")
        return true
    end
end

log.add(enum.logType.debug, "Logs enabled")

return log

local drawFrame = function(...)
    term.setBackgroundColor(colors.gray)
    term.clear()
    term.setCursorBlink(false)

    term.setCursorPos(7, 1)
    term.setBackgroundColor(colors.pink)
    term.clearLine()
    term.setTextColor(colors.white)
    term.write(" PinkOs v1.0 ")

    term.setCursorPos(1, 2)
    term.setBackgroundColor(colors.gray)
end

-- Security
_G.log = require("PinkOs.logModule")

if not pocket then
    log.add(enum.logType.warn, "PinkOs can only load on pocket computers.", "PinkOs")
    return
end
if not term.isColor() then
    log.add(enum.logType.warn, "PinkOs is only avalible in Advanced Pocket Computers.", "PinkOs")
    return
end

require("PinkOs/graficModule")

drawFrame()

local success, err = grafic.createButton(" Unlock ", enum.UiPosition.center, enum.UiPosition.center, colors.black, colors.pink)
if not success then log.add(enum.logType.error, err) end


while true do
    local event, button, x, y = os.pullEvent()

    if event == "mouse_click" then
        
    end
end

os.shutdown()
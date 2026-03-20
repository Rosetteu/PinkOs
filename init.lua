local draw = {}

draw.unlockFrame = function()
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

        local success, err = grafic.createButton(draw.mainFrame, "unlockButton",
            " Unlock ",
            enum.UiPosition.center, enum.UiPosition.center, colors.black,
            colors.pink,true)
        if not success then log.add(enum.logType.error, err) end
    end
draw.mainFrame = function()
        term.setBackgroundColor(colors.gray)
        term.clear()

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

draw.unlockFrame()


while true do
    local event, mouseButton, x, y = os.pullEvent()
    --    log.add(enum.logType.debug, "button click : "..event..", "..mouseButton..", "..x..", "..y)
    if event == "mouse_click" and mouseButton == 1 then
        for i, button in pairs(grafic.buttons) do
            if (tonumber(x) >= button.x1 and tonumber(x) <= button.x2) and tonumber(y) == button.y1 then
                log.add(enum.logType.debug, "button \"" .. button.id .. "\" clicked.")
                button.func()
                if button.oneUse then
                    grafic.deletteButton(button.id)
                end
            end
        end
    end
end

os.shutdown()
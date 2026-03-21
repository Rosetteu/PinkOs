require("PinkOs/settings")
require("PinkOs/filesModule")
_G.log = require("PinkOs/logModule")
require("PinkOs/graficModule")

if not pocket then
    log.add(enum.logType.warn, "PinkOs can only load on pocket computers.", "PinkOs")
    return
end
if not term.isColor() then
    log.add(enum.logType.warn, "PinkOs is only avalible in Advanced Pocket Computers.", "PinkOs")
    return
end

local draw = {}

draw.lockFrame = function()
    term.setBackgroundColor(PinkOsSettings.style.backgroundColor)
    term.clear()
    term.setCursorBlink(false)

    term.setBackgroundColor(PinkOsSettings.style.headerColor)
    term.setCursorPos(1, 1)
    term.clearLine()
    grafic.drawString("PinkOs " .. PinkOsSettings.version, enum.UiPosition.center, 1,
        PinkOsSettings.style.headerTextColor)

    term.setCursorPos(1, 2)
    term.setBackgroundColor(PinkOsSettings.style.backgroundColor)

    local success, err = grafic.createButton(draw.mainFrame, "unlockButton",
        " Unlock ",
        enum.UiPosition.center, enum.UiPosition.center, colors.black,
        colors.pink, true)
    if not success then log.add(enum.logType.error, err) end
end

draw.mainFrame = function()
    term.setBackgroundColor(PinkOsSettings.style.backgroundColor)
    term.clear()

    term.setCursorPos(1, 1)
    term.setBackgroundColor(PinkOsSettings.style.headerColor)
    term.clearLine()
    grafic.drawString("PinkOs | Apps", enum.UiPosition.center, 1, PinkOsSettings.style.headerTextColor)

    term.setCursorPos(1, 2)
    term.setBackgroundColor(PinkOsSettings.style.backgroundColor)

    local success, err = grafic.createButton(
        function()
            log.add(enum.logType.debug, "Exit button pressed. Comuter shutting down")
            os.shutdown()
        end, "exitButton", "X", grafic.screenSize[1], 1, PinkOsSettings.style.headerTextColor, PinkOsSettings.style.headerColor, true)
    if not success then
        log.add(enum.logType.error, "Error while creating exitButton :" .. (err or "Unknown"))
    end

    local success, err = grafic.drawSquare(2, 3, grafic.screenSize[1] - 2, grafic.screenSize[2] - 3, colors.cyan)
    if not success then log.add(enum.logType.error, err) end

    for i, value in ipairs(fs.list("PinkOs/apps/")) do
        log.add(enum.logType.debug, "i=" .. i .. ", value=" .. value)
        local app = require("PinkOs/apps/" .. value .. "/init")
        grafic.createButton(function()
            grafic.clearAllButtons()
            app.main(draw.mainFrame())
            draw.mainFrame()
        end, value, app.name, 3, i + 3, colors.white, colors.cyan, false)
    end
end

draw.lockFrame()


while true do
    local event, mouseButton, x, y = os.pullEvent()
    --    log.add(enum.logType.debug, "button click : "..event..", "..mouseButton..", "..x..", "..y)
    if event == "mouse_click" and mouseButton == 1 then
        local pressedButton
        for i, button in pairs(grafic.buttons) do
            if not button.enabled then goto continue end
            if (tonumber(x) >= button.x1 and tonumber(x) <= button.x2) and tonumber(y) == button.y1 then
                pressedButton = button
            end
            ::continue::
        end

        if pressedButton then
            log.add(enum.logType.debug, "button \"" .. pressedButton.id .. "\" clicked.")
            pressedButton.enabled = false
            pressedButton.func()
            if pressedButton.oneUse then pressedButton.destroy() end
        end
    end
end

os.shutdown()

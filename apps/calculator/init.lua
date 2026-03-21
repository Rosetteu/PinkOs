local app = {}
app.name = "Calculator"

app.localStyle = {
    
    headerColor = PinkOsSettings.style.headerColor,
    headerTextColor = PinkOsSettings.style.headerTextColor,

    backgroundColor = PinkOsSettings.style.backgroundColor,
    backgroundTextColor = PinkOsSettings.style.backgroundTextColor,

    divColor = colors.magenta
}

app.localDatas = {
}

app.main = function()
    log.add(enum.logType.debug, "App "..app.name.." started")

    term.setBackgroundColor(app.localStyle.backgroundColor or PinkOsSettings.backgroundColor)
    term.clear()

    term.setCursorPos(1, 1)
    term.setBackgroundColor(app.localStyle.headerColor or PinkOsSettings.style.headerColor)
    term.clearLine()
    grafic.drawString("PinkOs | " .. app.name, enum.UiPosition.center, 1, colors.white)

    term.setCursorPos(1, 2)
    term.setBackgroundColor(colors.gray)

    local exit = false

    local success, err = grafic.createButton(
        function()
            log.add(enum.logType.debug, "Exit button pressed")
            exit = true
        end, "exitButton", "X", grafic.screenSize[1], 1, PinkOsSettings.style.headerTextColor,
        PinkOsSettings.style.headerColor, true)
    if not success then
        log.add(enum.logType.error, "Error while creating exitButton :" .. (err or "Unknown"))
    end

    while true do
        if exit then break end
        local event, mouseButton, x, y = os.pullEvent()
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
    return true
end
return app

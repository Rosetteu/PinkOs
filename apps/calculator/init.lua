local default = nil

local app = {}

app.name = "Calculator"

app.localStyle = {

    headerColor = default,
    headerTextColor = default,

    backgroundColor = default,
    backgroundTextColor = default,

    divColor = default,
    divTextColor = default,

    buttonColor = default,
    buttonTextColor = default
}

app.localDatas = {
    buttons = {
        { input = 7,   x = 4,  y = 8 },
        { input = 8,   x = 8,  y = 8 },
        { input = 9,   x = 12, y = 8 },
        { input = 4,   x = 4,  y = 10 },
        { input = 5,   x = 8,  y = 10 },
        { input = 6,   x = 12, y = 10 },
        { input = 1,   x = 4,  y = 12 },
        { input = 2,   x = 8,  y = 12 },
        { input = 3,   x = 12, y = 12 },
        { input = 0,   x = 8,  y = 14 },
        { input = "<", x = 4,  y = 14 },
        { input = "=", x = 12, y = 14 },
        { input = "+", x = 16, y = 8 },
        { input = "-", x = 20, y = 8 },
        { input = "x", x = 16, y = 10 },
        { input = "/", x = 20, y = 10 },

    }
}

app.main = function()
    local calc = ""

    graphic.clearAllButtons()
    log.add(enum.logType.debug, "App " .. app.name .. " started")

    term.setBackgroundColor((app.localStyle.backgroundColor or PinkOsSettings.style.backgroundColor))
    term.clear()

    term.setCursorPos(1, 1)
    term.setBackgroundColor(app.localStyle.headerColor or PinkOsSettings.style.headerColor)
    term.clearLine()
    graphic.drawString("PinkOs | " .. app.name, enum.UiPosition.center, 1, colors.white)

    graphic.drawSquare(3, 3, graphic.screenSize[1] - 5, 3, app.localStyle.divColor or PinkOsSettings.style.divColor)

    graphic.drawSquare(3, 7, graphic.screenSize[1] - 5, graphic.screenSize[2] - 7,
        app.localStyle.divColor or PinkOsSettings.style.divColor)
    local exit = false

    local success, err = graphic.createButton(
        function()
            log.add(enum.logType.debug, "Exit button pressed")
            exit = true
        end, "exitButton", "X", graphic.screenSize[1], 1, PinkOsSettings.style.headerTextColor,
        PinkOsSettings.style.headerColor, true)
    if not success then
        log.add(enum.logType.error, "Error while creating exitButton :" .. (err or "Unknown"))
    end

    for _, button in ipairs(app.localDatas.buttons) do
        local func
        if button.input == "<" then
            func = function()
                calc = string.sub(calc, 1, -2)
                graphic.drawSquare(3, 3, graphic.screenSize[1] - 5, 3,
                    app.localStyle.divColor or PinkOsSettings.style.divColor)
            end
        end
        graphic.createButton(func or function()
                calc = calc .. button.input or log.add(enum.logType.error, "button has no input")
            end, button.input, " " .. button.input .. " ", button.x, button.y,
            app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
            app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)
    end

    while true do
        if exit then break end

        local event, mouseButton, x, y = os.pullEvent()
        if event == "mouse_click" and mouseButton == 1 then
            local pressedButton

            for i, button in pairs(graphic.buttons) do
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
                if pressedButton.oneUse then
                    pressedButton.destroy()
                else
                    pressedButton.enabled = true
                end
            end


            if string.find(calc, "=") then
                local operation = string.gsub(calc, "=", "")
                operation = string.gsub(operation, "x", "*")
                local func, err = load("return " .. operation)

                if func then
                    local success, result = pcall(func) -- pcall évite que l'OS crash si le calcul est invalide (ex: 5/0)
                    if success then
                        calc = tostring(result)
                    else
                        calc = "Error"
                    end
                else
                    calc = "Error"
                end
                graphic.drawSquare(3, 3, graphic.screenSize[1] - 5, 3,
                    app.localStyle.divColor or PinkOsSettings.style.divColor)
                graphic.drawString(calc, 4, 4, app.localStyle.divTextColor or PinkOsSettings.style.divTextColor,
                    app.localStyle.divColor or PinkOsSettings.style.divColor)
            else
                graphic.drawString(calc, 4, 4, app.localStyle.divTextColor or PinkOsSettings.style.divTextColor,
                    app.localStyle.divColor or PinkOsSettings.style.divColor)
            end
        end
    end
    return true
end
return app

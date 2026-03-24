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

app.localDatas = {}

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

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "7"
            end
        end, "7", " 7 ", 4, 8, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "8"
            end
        end, "8", " 8 ", 8, 8, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "9"
            end
        end, "9", " 9 ", 12, 8, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "4"
            end
        end, "4", " 4 ", 4, 10, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "5"
            end
        end, "5", " 5 ", 8, 10, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "6"
            end
        end, "6", " 6 ", 12, 10, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "1"
            end
        end, "1", " 1 ", 4, 12, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "2"
            end
        end, "2", " 2 ", 8, 12, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "3"
            end
        end, "3", " 3 ", 12, 12, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "0"
            end
        end, "0", " 0 ", 8, 14, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            calc = string.sub(calc, 1, -2)
            graphic.drawSquare(3, 3, graphic.screenSize[1] - 5, 3, app.localStyle.divColor or PinkOsSettings.style
                .divColor)
        end, "<", " < ", 4, 14, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "+"
            end
        end, "+", " + ", 16, 8, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "-"
            end
        end, "-", " - ", 20, 8, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "x"
            end
        end, "x", " x ", 16, 10, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            if string.len(calc) < graphic.screenSize[1] - 7 then
                calc = calc .. "/"
            end
        end, "/", " / ", 20, 10, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)

    graphic.createButton(function()
            calc = calc .. "="
        end, "=", " = ", 12, 14, app.localStyle.buttonTextColor or PinkOsSettings.style.buttonTextColor,
        app.localStyle.buttonColor or PinkOsSettings.style.buttonColor)


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

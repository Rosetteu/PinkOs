local fileName = "graficModule"

if not enum then _G.enum = {} end
if not enum.UiPosition then enum.UiPosition = { middle = "center", center = "center" } end

_G.grafic = {

    buttons = {},

    screenSize = { 26, 20 },

    drawString = function(String, x, y, textColor, backgroundColor)
        log.add(enum.logType.debug,
            "function drawString called with arguments {String=\"" ..
            String ..
            "\", x=" ..
            x ..
            ", y=" ..
            y .. ", textColor=" .. (textColor or 'nil') .. ", backgroundColor=" .. (backgroundColor or 'nil') .. "}")

        if not String then
            log.add(enum.logType.error, "Param #1 String is nil", fileName, false)
            return false, "Param #1 String is nil"
        end
        if type(String) ~= "string" and type(String) ~= "number" and type(String) ~= "boolean" then
            log.add(enum.logType.error, "Param #1 String isn't a string or a number or a boolean", fileName, false)
            return false, "Param #1 String isn't a string or a number or a boolean"
        end

        if not x then
            log.add(enum.logType.error, "Param #2 x is nil", fileName, false)
            return false, "Param #2 x is nil"
        end
        if (type(x) ~= "number" and type(x) ~= "string") and x ~= enum.UiPosition.center then
            log.add(enum.logType.error, "Param #2 x isn't a number or a string", fileName, false)
            return false, "Param #2 x isn't a number or a string"
        end
        if x == enum.UiPosition.center then
            x = math.floor((grafic.screenSize[1] - string.len(String)) / 2) + 1
        end
        if not (x > 0 and x <= grafic.screenSize[1]) then
            log.add(enum.logType.error, "Param #2 x isn't between 0 and " .. grafic.screenSize[1], fileName, false)
            return false, "Param #2 x isn't between 0 and " .. grafic.screenSize[1]
        end

        if not y then
            log.add(enum.logType.error, "Param #3 y is nil", fileName, false)
            return false, "Param #3 y is nil"
        end
        if type(y) ~= "number" and type(y) ~= "string" then
            log.add(enum.logType.error, "Param #3 y isn't a number or a string", fileName, false)
            return false, "Param #3 y isn't a number or a string"
        end
        if y == enum.UiPosition.center then
            y = math.floor(grafic.screenSize[2] / 2 + 1)
        end
        if not (y > 0 and y <= grafic.screenSize[2]) then
            log.add(enum.logType.error, "Param #3 y isn't between 0 and " .. grafic.screenSize[2], fileName, false)
            return false, "Param #3 y isn't between 0 and " .. grafic.screenSize[2]
        end

        term.setCursorPos(tonumber(x), tonumber(y))
        if not textColor then textColor = colors.white end
        term.setTextColor(textColor)
        if not backgroundColor then backgroundColor = term.getBackgroundColor() end
        term.setBackgroundColor(backgroundColor)
        term.write(tostring(String))

        return true
    end,

    createButton = function(Function, id, String, x, y, textColor, backgroundColor, oneUse)
        log.add(enum.logType.debug,
            "function createButton called with arguments {function, id=\"" ..
            id ..
            "\" String=\"" ..
            String ..
            "\", x=" ..
            x ..
            ", y=" ..
            y .. ", textColor=" .. (textColor or 'nil') .. ", backgroundColor=" .. (backgroundColor or 'nil') .. "}")
        if not id then
            log.add(enum.logType.error, "Param #2 id is nil, string or int expexted")
            return false, "Param #2 id is nil, string or int expexted"
        end
        if type(id) ~= "number" and type(id) ~= "string" then
            log.add(enum.logType.error, "Param #2 id isn't a string or a number")
            return false, "Param #2 id isn't a string or a number"
        end

        if x == enum.UiPosition.center then
            x = math.floor(grafic.screenSize[1] / 2 - string.len(String) / 2)
        end
        if y == enum.UiPosition.center then
            y = math.floor(grafic.screenSize[2] / 2 + 1)
        end

        local success, err = grafic.drawString(String, x, y, textColor, backgroundColor)
        if not success then
            log.add(enum.logType.error, "Error while creating the Ui button : " .. (err or "unknown"))
            return false, "Error while creating the Ui button : " .. (err or "unknown")
        end

        grafic.buttons[id] = {
            id = id,
            x1 = x,
            y1 = y,
            x2 = x + string.len(String),
            func = Function,
            oneUse = oneUse,
            enabled = true,
            destroy = function()
                grafic.deletteButton(id)
            end
        }
        return true
    end,

    deletteButton = function(id)
        log.add(enum.logType.debug, "function deletteButton called with arguments {id=\"" .. id .. "\"}")

        if not id then
            log.add(enum.logType.error, "Param #1 id is nil, string or int expexted")
            return false, "Param #1 id is nil, string or int expexted"
        end
        if type(id) ~= "number" and type(id) ~= "string" then
            log.add(enum.logType.error, "Param #1 id isn't a string or a number")
            return false, "Param #1 id isn't a string or a number"
        end

        if not grafic.buttons[id] then
            log.add(enum.logType.error, "No button with id " .. id .. " found", fileName, false)
            return false, "No button with id " .. id .. " found"
        end

        grafic.buttons[id] = nil
        return true
    end,

    clearAllButtons = function()
        log.add(enum.logType.debug, "function clearAllButtons called with arguments")

        grafic.buttons = {}
        return true
    end,

    drawSquare = function(x, y, width, height, color)
        log.add(enum.logType.debug,
            "function drawSquare called with arguments { x=" ..
            x ..
            ", y=" ..
            y .. ", width=" .. width .. ", height=" .. height .. ", Color=" .. color .. "}")

        if not x then
            log.add(enum.logType.error, "Param #2 x is nil", fileName, false)
            return false, "Param #2 x is nil"
        end
        if (type(x) ~= "number" and type(x) ~= "string") and x ~= enum.UiPosition.center then
            log.add(enum.logType.error, "Param #2 x isn't a number or a string", fileName, false)
            return false, "Param #2 x isn't a number or a string"
        end
        if x == enum.UiPosition.center then
            x = math.floor(grafic.screenSize[1] / 2 - width / 2)
        end
        if not (x > 0 and x <= grafic.screenSize[1]) then
            log.add(enum.logType.error, "Param #2 x isn't between 0 and " .. grafic.screenSize[1], fileName, false)
            return false, "Param #2 x isn't between 0 and " .. grafic.screenSize[1]
        end

        if not y then
            log.add(enum.logType.error, "Param #2 y is nil", fileName, false)
            return false, "Param #2 y is nil"
        end
        if type(y) ~= "number" and type(y) ~= "string" then
            log.add(enum.logType.error, "Param #2 y isn't a number or a string", fileName, false)
            return false, "Param #2 y isn't a number or a string"
        end
        if y == enum.UiPosition.center then
            y = math.floor(grafic.screenSize[2] / 2 - height / 2) + 1
        end
        if not (y > 0 and y <= grafic.screenSize[2]) then
            log.add(enum.logType.error, "Param #2 y isn't between 0 and " .. grafic.screenSize[2], fileName, false)
            return false, "Param #2 y isn't between 0 and " .. grafic.screenSize[2]
        end

        if not width then
            log.add(enum.logType.error, "Param #3 width is nil", fileName, false)
            return false, "Param #3 width is nil"
        end
        if type(width) ~= "number" and type(width) ~= "string" then
            log.add(enum.logType.error, "Param #3 width isn't a number or a string", fileName, false)
            return false, "Param #3 width isn't a number or a string"
        end
        if not (width > 0 and tonumber(width) + tonumber(x) <= grafic.screenSize[1]) then
            log.add(enum.logType.error, "Param #3 width is to big for this screen", fileName, false)
            return false, "Param #3 width is to big for this screen"
        end

        if not height then
            log.add(enum.logType.error, "Param #4 height is nil", fileName, false)
            return false, "Param #4 height is nil"
        end
        if type(height) ~= "number" and type(height) ~= "string" then
            log.add(enum.logType.error, "Param #4 height isn't a number or a string", fileName, false)
            return false, "Param #4 height isn't a number or a string"
        end
        if not (height > 0 and tonumber(height) + tonumber(y) <= grafic.screenSize[2]) then
            log.add(enum.logType.error, "Param #4 height is to big for this screen", fileName, false)
            return false, "Param #4 height is to big for this screen"
        end

        if not color then
            log.add(enum.logType.error, "Param #5 color is nil", fileName, false)
            return false, "Param #5 color is nil"
        end
        if type(color) ~= "number" then
            log.add(enum.logType.error, "Param #5 color isn't a number", fileName, false)
            return false, "Param #5 color isn't a number"
        end

        paintutils.drawFilledBox(x, y, x + width - 1, y + height - 1, color)

        return true
    end

}

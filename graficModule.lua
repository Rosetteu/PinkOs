local fileName = "graficModule"

if not enum then _G.enum = {} end
if not enum.UiPosition then enum.UiPosition = { middle = "center" } end

_G.grafic = {

    screenSize = { 26, 20 },

    drawString = function(String, x, y, backgroundColor)
        log.add(enum.logType.debug,
            "function drawString called with arguments {String=" ..
            String .. ", x=" .. x .. ", y=" .. y .. ", backgroundColor=" .. (backgroundColor or 'nil') .. "}")

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
        if (type(x) ~= "number" and type(x) ~= "string") and x ~= "center" then
            log.add(enum.logType.error, "Param #2 x isn't a number or a string", fileName, false)
            return false, "Param #2 x isn't a number or a string"
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
        if not (y > 0 and y <= grafic.screenSize[2]) then
            log.add(enum.logType.error, "Param #3 y isn't between 0 and " .. grafic.screenSize[2], fileName, false)
            return false, "Param #3 y isn't between 0 and " .. grafic.screenSize[2]
        end

        term.setCursorPos(tonumber(x), tonumber(y))
        if backgroundColor then term.setBackgroundColor(backgroundColor) end
        term.write(tostring(String))

        return true
    end
}

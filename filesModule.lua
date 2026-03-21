_G.files = {
    read = function(fileName)
        if not fileName then error("fileName is nil") end
        local file = fs.open(fileName, "r")
        if not file then return false end
        local data = file.readAll()
        file.close()
        return data
    end,

    write = function(fileName, data)
        assert(fileName, "fileName is nil")
        assert(data, "data is nil.")

        local file = fs.open(fileName, "w")
        file.write(data)
        file.close()
        return true
    end,

    readJSON = function(fileName)
        if not fileName then error("fileName is nil") end
        local file = fs.open(fileName, "r")
        if not file then return false end
        local data = textutils.unserialiseJSON(file.readAll())
        file.close()
        return data
    end,

    writeJSON = function(fileName, data)
        assert(fileName, "fileName is nil")
        assert(data, "data is nil.")

        local file = fs.open(fileName, "w")
        file.write(textutils.serialiseJSON(data))
        file.close()
        return true
    end,

    addLine = function(fileName, data)
        assert(fileName, "fileName is nil")
        assert(data, "data is nil.")

        if type(data) == "table" then data = textutils.serialise(data) end

        local file = fs.open(fileName, "a")
        if not file then return false, "file" end
        file.writeLine(tostring(data))
        file.close()
        return true
    end
}

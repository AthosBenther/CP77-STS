local help = {}

function help.contains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function help.split(subject, sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    subject:gsub(pattern, function(c) fields[#fields + 1] = c end)
    return fields
end

function help.capitalize(string)
    return string:sub(1, 1):upper() .. string:sub(2)
end

return help
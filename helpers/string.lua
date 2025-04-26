local _M = {}

function _M.split(s, d)
    local r = {}
    s:gsub(string.format("([^%s]+)", d), function(c) r[#r + 1] = c end)
    return r
end

function _M.contains(s, sub)
    return s:find(sub, 1, true) ~= nil
end

function _M.startswith(s, start)
    return s:sub(1, #start) == start
end

function _M.endswith(s, ending)
    return ending == "" or s:sub(- #ending) == ending
end

return _M

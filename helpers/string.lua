local _M = {}

function _M.split(s, d)
	local r = {}
	s:gsub(string.format("([^%s]+)", d), function(c) r[#r+1] = c end)
	return r
end

return _M

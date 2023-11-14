local _M = {}

_M.contains = function(t, e)
	for i, v in pairs(t) do
		if v == e then
			return true
		end
	end
	return false
end

_M.join = function(t, d)
	local d = d or " "
	local out
	for _, v in ipairs(t) do
		if not out then
			out = tostring(v)
		else
			out = out .. d .. tostring(v)
		end
	end
	return out
end


return _M

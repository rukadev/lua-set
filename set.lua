local function deepcompare(t1,t2,ignore_mt)
	local ty1 = type(t1)
	local ty2 = type(t2)
	if ty1 ~= ty2 then return false end
	if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
	local mt = getmetatable(t1)
	if not ignore_mt and mt and mt.__eq then return t1 == t2 end
	for k1,v1 in pairs(t1) do
		local v2 = t2[k1]
		if v2 == nil or not deepcompare(v1,v2) then return false end
	end
	for k2,v2 in pairs(t2) do
		local v1 = t1[k2]
		if v1 == nil or not deepcompare(v1,v2) then return false end
	end
	return true
end

local Set = {}
Set.__index = Set

function Set.new()
    return setmetatable({
        set = {},
        dicts = {}
    }, Set)
end

-- Returns the union of set a and set b
function Set.union(a, b)
	local res = Set.new()
	for k in pairs(a) do 
		res[k] = true 
	end
	for k in pairs(b) do 
		res[k] = true 
	end
    return res
end

-- Returns the intersection of set a and b
function Set.intersection(a,b)
	local res = Set.new()
	for k in pairs(a) do
		res[k] = b[k]
	end
	return res
end

-- Add key to set
function Set:add(k)
	if type(k) == "table" then
		table.insert(self.dicts, k)
	else
		self.set[k] = true
	end
end

-- Remove key from set
function Set:remove(k)
	self.set[k] = nil
end

-- Returns true if the set contains the key
function Set:contains(k)
	if type(k) == "table" then
		for _, pair in pairs(self.dicts) do
			if deepcompare(k, pair) then
				return true
			end
		end
	else
		return self.set[k]
	end
end

-- Returns array of set items
function Set:get()
	local res = {}
	for key, _ in pairs(self.set) do
		table.insert(res, key)
	end
	for _, val in pairs(self.dicts) do
		table.insert(res, val)
	end
	return res
end

return Set
str = "just a test"
print(getmetatable(str))

--[[
__index
-sub
-upper
-len
-gfind
-rep
-find
-match
-char
-dump
-gmatch
-reverse
-byte
-format
-gsub
-lower
--]]

tbl = {}
t1 = {key = "val"}
setmetatable(tbl, t1)
print(getmetatable(tbl))

t1 = {"a", "b", "c", "d"}
t2 = {5, 6, 7, 8, 9}

mt = {}
mt.__add = function(a, b)
    local tbl = {}
    local ret = {}
    for k, v in pairs(a) do tbl[v] = true end
    for k, v in pairs(b) do tbl[v] = true end
    for k, v in pairs(tbl) do
        table.insert(ret, k)
    end
    return ret
end

setmetatable(t1, mt)
setmetatable(t2, mt)

t = t1 + t2
for k, v in pairs(t) do print(v) end

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

obj_1 = {}
function obj_1:echo()
    print("I am obj 001.")
end

function obj_1:debug()
    print("obj 001 debug");
end

obj = {}
function obj:echo()
    print("I am obj.")
end


obj:echo();

if type(obj.debug) == "function" then
    obj:debug();
else
    print("没有 debug 方法")
end

obj = setmetatable(obj, {__index = obj_1});
obj:echo();
obj:debug();

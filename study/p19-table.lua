-- table

for attr in pairs(table) do
    if 'function' == type(table[attr]) then
        --print(string.format('%s', attr));
        print(attr);
    end
end

--[[
$ lua p19.lua | sort | pbcopy

concat
foreach
foreachi
getn
insert
maxn
remove
setn
sort
--]]

print('------');

local tb = {
    {"abc", "123"},
    {"ABC"},
    doc = "zoom to fit content height",
}

for k, v in pairs(tb) do
    if type(v) == "table" then
        for _k, _v in pairs(v) do
            print(k, _k, _v);
        end
    else
        print(k, v)
    end
end

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


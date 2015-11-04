-- 弱引用 table
-- 弱引用(weak reference)
-- 一个 table 的弱引用类型是通过其元素表中的一个 __mode 字段来决定的.其值为一个字符串.
-- 如果字符串中包含字母 'k',那么这个 table 的 key 是弱引用的;
-- 如果字符串中包含 'v',那么这个 table 的 value 是弱引用的.

a = {};
b = {__mode = 'k'};
setmetatable(a, b);     -- 现在 a 的 key 是弱引用
key = {};               -- 创建第一个 key
a[key] = 1;
key = {};               -- 创建第二个 key
a[key] = 2;
a['t'] = 3;

collectgarbage();       -- 强制进行一次垃圾收集

for k, v in pairs(a) do
    print(v)
end

-- 备忘录(memoize)函数

local defaults = {};
setmetatable(defaults, {__index = 'k'});
local mt = {
    __index = function(t)
        return defaults[t];
    end;
};

function setDefault(t, d)
    defaults[t] = d;
    setmetatable(t, mt);
end


local metals = {};
setmetatable(metals, {__index = 'v'});
function setDefaultV2(t, d)
    local mt = metals[d];
    if mt = nil then
        mt = {__index = function() return d end};
        metals[d] = mt; -- 备忘录
    end

    setmetatable(t, mt);
end;


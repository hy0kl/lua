-- lua 中,函数是一种"第一类值(First-Class Value)",具有特定的词法域(Lexical Scoping)

local network = {
    {name = 'grauna',  ip = '210.26.30.34'},
    {name = 'arraial', ip = '210.26.30.23'},
    {name = 'lua',     ip = '210.26.23.12'},
    {name = 'derain',  ip = '210.26.23.20'}
};
table.sort(network, function(a, b)
    -- 字母升序
    return (a.name < b.name);
    -- 字母降序
    --return (a.name > b.name);
end);

for k, v in pairs(network) do
    print(v.name, v.ip);
end

-- closure(闭合函数)闭包
-- 一个 closure 是一个函数加上该函数所需访问的所有"非局部的变量(upvalue)".
-- 和 js 一样,利用闭包特性可以实现私有成员变量,并且保持住内存.
print('测试闭包');
function counter()
    local count = 0;
    return function () -- 匿名函数
        count = count + 1;
        return count;
    end
end
c1 = counter();
print(c1()); -- 1
print(c1()); -- 2
c2 = counter();
print(c2()); -- 1
print(c1()); -- 3
print(c2()); -- 2

--[[
使用闭包技术来创建一个安全运行环境,即所谓的"沙盒(sandbox)".
do
    local old_open = io.open;
    local check_access = function(filename, mode)
        <检查访问权限>
    end

    io.open = function(filename, mode)
        if check_access(filename, mode)
            return old_open(filename, mode);
        else
            return nil, 'access denied';
        end
    end
end
--]]


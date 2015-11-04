-- 迭代器与泛型 for
-- 一个 closure 结构通过涉及到两个函数: closure 本身和一个用于创建该 closure 的工厂(factory)函数

local values = function(t)
    local i = 0;

    return function()
        i = i + 1;
        return t[i];
    end
end

local t = {10, 20, 30, 'string is ok.'};

-- while 的迭代
print('while 的迭代');
local iter = values(t); -- 创建迭代器
-- c 语言中常见的迭代风格
local element = iter(); -- 调用迭代器
while element do
    print(element);
    element = iter();   -- 下一轮迭代
end

-- for 泛型迭代
print('for 泛型迭代');
for element in values(t) do
    print(element);
end

-- 无状态迭代器
-- lua 代码实现的 ipairs() 迭代器
local ns = {};
ns.iter = function(array, index)
    index = index + 1;
    local value = array[index] or nil;
    if value then
        return index, value;
    end

    return nil
end

ns.ipairs = function(array)
    return ns.iter, array, 0;
end

local a = {'a', 'b', '110'};
for k, v in ns.ipairs(a) do
    print(k, v);
end

-- 一个典型的精彩的例子
-- 这个例子每次迭代都要创建一个新的闭包,在某些场景下不一定适用
local allwords = function()
    local line = io.read(); -- 当前行
    local pos = 1;          -- 一行中的当前位置

    return function()       -- 迭代函数
        while line do       -- 若有效的行内容进入循环
            local s, e = string.find(line, '%w+', pos);
            if s then       -- 是否找到下一个单词
                pos = e + 1;-- 该单词的下一个位置
                return string.sub(line, s, e); -- 返回该单词
            else
                line = io.read();   -- 没有找到单词,尝试一行
                pos = 1;    -- 迭代复位
            end
        end

        return nil;         -- 没有其余行,迭代结束
    end
end

for word in allwords() do
    print(word);
end


-- 多重赋值
local x = 10;
local y = 33;
x, y = y, x; -- 交换 x 与 y
print(x .. ' <-> ' .. y);

--print(math.huge);

-- 尽可能的使用局部变量
-- 局部变量可以避免将一些无用的名称引入全局环境(global environment)
-- lua 不支持 switch 语句
-- while condition do do-something end
-- repeat do-something untile condition
-- for var = exp1, exp2, exp3 do do-something end
-- 不要在循环过程中修改控制变量的值,否则会导致不可预知的效果
-- 各种循环中都可以使用 break 退出

-- io.lines 迭代文件
-- pairs 迭代 table 元素
-- ipairs 迭代数组元素
-- string.gmatch 迭代字符串中的单词

local days = {'Sunday', 'Monday', 'Tuesday', 'Wednesday',
              'Thursday', 'Friday', 'Saturday'};
local rev_days = {};
for key, value in  pairs(days) do
    print(key .. ' => ' .. value);
    rev_days[value] = key;
end

for k, v in pairs(rev_days) do
    print(k .. ' => ' .. v);
end


print(os.date());

print(8 * 9, 9 / 8);

-- 一个函数若只有一个参数,且此参数是一个字面字符串或 table 构造式,那么圆括号可有可无.
-- 强烈建议函数调用始终使用 ()
-- type{} 等价于 type({})

-- lua 冒号操作符
-- 表达式 obj.foo(obj, arg) 的另一种写法是 obj:foo(arg),冒号操作符调用 obj.foo 时将 obj 隐含地作为函数的第一个参数

-- lua 会自动调整实参的数量,以匹配参数表的要求.与多重赋值(multiple assignment)相似: "若实参多余,则舍弃多余的实参;若实参不足,则多余的形参初始化为 nil"

-- 多重返回值(multiple results)
local s, e = string.find('Hello lua users.', 'lua');
print(s, e);

-- lua 会调整一个函数的返回值数量以适应不同的调用情况.
-- 若将函数调用作为一条单独语句时, lua 会丢弃函数的所有返回值.
-- 若将函数作为表达式的一部分来调用时, lua 只保留函数的第一个返回值.
-- 只有当一个函数调用是一系列表达式中的最后一个元素(或仅有一个元素)时,才能获得它的所有返回值.
-- "一系列表达式"的4种情况: 多重赋,函数调用时传入的实参列表, table 的构造式和 return 语句.
-- 将一个函数调用放入一对圆括号中,迫使它只返回一个结果.
-- return 语句后面的内容是不需要圆括号的,在该位置上书写圆括号会导致不同的行为.
-- unpack() 函数接受一个数组作为参数,并从下标 1 开始返回该数组的所有元素.

-- unpack 的一项重要用途体现在"泛型调用(generic call)"机制中.泛型调用机制可以动态地以任何实参来调用任何函数
strpos = string.find;
find = {'Hello', 'll'};
print(strpos(unpack(find)));

-- 不能声明为 local, 否则报错: attempt to call global 'c_unpack' (a nil value)
c_unpack = function(t, i)
    i = i or 1;
    if t[i] then
        return t[i], c_unpack(t, i + 1);
    end
end

print(strpos(c_unpack(find)));

-- 变长参数(variable number of arguments)
local add = function(...)
    local s = 0;
    -- 此处用 pairs 和 ipairs 效果一样
    --for k, v in ipairs({...}) do
    for k, v in pairs({...}) do
        s = s + v;
    end

    return s;
end

print(add(1, 2, 3, 4));

function fwrite(fmt, ...)
    return io.write(string.format(fmt, ...));
end
fwrite('abc %d\n', 120);

-- select('#', ...) 会返回所有变长参数的总数,其中包括 nil.
test_args = function(...)
    for i = 1, select('#', ...) do
        local arg = select(i, ...); -- 得到第 i 个参数
        print(arg);
    end
end
test_args(110, 'This is a string', 'hi', {'I am table'}, test_args);

-- 具名实参(named arguments)
function mv(arg)
    return os.rename(arg.old, arg.new);
end
-- 如果文件存在,会正确重命令
-- 否则不报错,所以需要关心返回值: nil   tmp.lua: No such file or directory  2
print(mv({old = 'tmp.lua', new = 'tmp_new.lua'}));


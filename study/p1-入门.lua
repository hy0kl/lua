-- 实测貌似 " ' 没有大的区别
-- 应该避免使用一个下画线开头并跟着一个或多个大写字母的标识符
-- lua 大小写敏感
-- 全局变量(Global Variables)不需要声明,赋值即可创建
-- 删除全局变量,将赋值为 nil 即可

--[[
    这里是多行注释
--]]

print('Hello World!');

function fact(n)
    if 0 == n then
        return 1;
    else
        return n * fact(n - 1);
    end
end

print('Enter a number: \a');

number = io.read('*number'); -- read an number
print( number .. ' fact is: ' .. fact(number));

-- lua 里面并不是非0即真,0也是真值.
if 0 then
    print("I am 0");
end

os.exit();

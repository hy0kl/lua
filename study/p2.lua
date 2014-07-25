print(type(3.1415 * 2));
print(type('type'));
print(type(type));
print(type(print));
print(type(nil));
print(type(true));
print(type(xyz));
print(type(type(xyz)));

-- lua 的数据类型
-- nil 空
-- boolean 布尔
-- number 数字,表示实数, lua 没有整数类型.重新编译 lua 可以使用其他类型数字,参见发行版中的 luaconf.h
-- string 字符串
-- lua 中数字与字符串计算时与 c 语言的精度提升机制一致
-- 若要将一个数字转换成字符,可用用函数 tostring(), 或将数字空字符串 .. 操作
-- 在 lua5.1 中,字符串前放置操作符 # 来获得该字符串长度
-- lua table, associative array,是对象,通过 {} 构造
-- table 永远是"匿名的(anonymous)",一个持有 table 的变量与 table 自身之前没有固定的关联性
-- 在 lua5.1 中,长度操作符 # 用于返回一个数组或线性表的最后一个索引值(或为其大小)

a = 'one string';
-- 修改字符串的一部分,不会影响原始字符串
b = string.gsub(a, 'one', 'another');
print(a);
print(b);

html = [[
<html>
    <title>lua study</title>
    <body>
    </body>
</html>
]];
print(html);

-- 转义冲突情况的处理
sp = [==[
html = [[
<html>
    <title>lua study</title>
    <body>
    </body>
</html>
]];
print(html);
]==];
print(sp);

print(tostring(11) == '11');

print('strlen(sp) = ' .. #sp);


-- 字符串库

for attr in pairs(string) do
    if 'function' == type(string[attr]) then
        print(attr);
    end
end

--[[
$ lua p20.lua | sort | pbcopy

byte
char
dump
find
format
gfind
gmatch
gsub
len
lower
match
rep
reverse
sub
upper
--]]

local st = {
    'xyz',
    'apple',
    'linux',
    'windows',
    'ubuntu',
    'freebsd',
};

table.sort(st, function(a, b)
    return string.lower(a) < string.lower(b); -- 字典序
end);

for k, v in pairs(st) do
    print(k, v);
end

-- 不同于其他脚本语言, lua 既没有使用 POSIX(regexp),也没有使用 perl 正则表达式来进行模式匹配.

local s = 'Hello world.';
local pos, len = string.find(s, 'wor');
print(pos, len);
print(string.sub(s, pos, len));

local date = 'Tody is 2014-07-31';
local match= string.match(date, '%d+-%d+-%d+');
print(match);

---

local s = '';

s = string.gsub('Lua is so cute.', 'cute', 'great');
print(s);

s = string.gsub('all girls.', 'l', 'x');
print(s);

s = string.gsub('Hello word, I am tester.', 'l', 'z', 1);
print(s);

--[[
字符分类
.   所有字符
%a  字母
%c  控制字符
%d  数字
%p  标点符号
%s  空白字符
%u  大写字母
%w  字母和数字字符
%x  十六进制数字
%z  内部表示为 0 的字符
以上分类的大写形式表示它们的补集.例如: %A 表示所有非字母字符

修饰符
+   重复 1 次或多次
*   重复 0 次或多次
-   也是重复 0 次或多次
?   可选部分(出现 0 次或 1 次)
--]]


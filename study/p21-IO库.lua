-- I/O 库

for attr in pairs(io) do
    if 'function' == type(io[attr]) then
        print(attr);
    end
end

--[[
$ lua p21.lua | sort | pbcopy

close
flush
input
lines
open
output
popen
read
tmpfile
type
write

函数 io.read 参数说明
'*all'      读取整个文件
'*line'     读取下一行
'*number'   读取一个数字
<num>       读取一个不超过 <num> 个字符的字符串
--]]

---- $ cat curl.lua | lua p21.lua
--local t = io.read('*all');
--io.write(t, '\n');

-- 在 termianl 下将注释标为蓝色
-- $ cat curl.lua | lua p21.lua
-- 按颜色输出无法使用普通的 \e 或者 \033 来进行输出,
-- 原因是在lua中 \nnn 是按照十进制来解释的,因此改成 \27 就可以了.
for line in io.lines() do
    if '-' == string.sub(line, 1, 1) then
        --line = '\e[1;34m' .. line;
        line = string.format('\27[1;34m%s\27[0m', line);
    end

    print(line);
end

-- I/O 库提供了3个预定义C语言流的句柄: io.stdin, io.stdout, io.stderr.


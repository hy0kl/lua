-- 数学库

--print(type(math.sin));

for attr in pairs(math) do
    if 'function' == type(math[attr]) then
        print(string.format('%s', attr))
    end
end

--[[
$ lua p18.lua | sort | pbcopy
abs
acos
asin
atan
atan2
ceil
cos
cosh
deg
exp
floor
fmod
frexp
ldexp
log
log10
max
min
mod
modf
pow
rad
random
randomseed
sin
sinh
sqrt
tan
tanh
--]]

-- 播种随机种子
math.randomseed(os.time());


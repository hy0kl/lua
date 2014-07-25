-- -(负号)可做一元操作符
-- ^ 指数, x ^ 0.5 计算 x 的平方要, x ^ (-1/3) 计算 x 立方根的倒数
-- 取模操作符的定义: a % b == a - floor(a / b) * b
-- x % 1 的结果是 x 的小数部分; x - x % 1 的结果就是其整数部分
-- x - x % 0.001 则是 x 精确到小数点后两位的结果

print(math.pi);
print(2 ^ 3);
print(9 ^ 0.5);
print(8 ^ (- 1 / 3));

pi = math.pi;
print(pi - pi % 0.01);

-- 例子: 检查一辆车是否在旋转了一定角度后开始往回开
local tolerance = 10;
function is_turnback(angle)
    angle = angle % 360;
    return (math.abs(angle - 180) < tolerance);
end
print(is_turnback(-180));

-- 以弧度代替角度
-- angle % (2 * math.pi) 是将任意角度规范化区间 [0, 2pi]
local to_lerance = 0.17;
function is_turnback_v2(angle)
    angle = angle % (2 * math.pi);
    return (math.abs(angle - math.pi) < to_lerance);
end

-- ~= 不等于
-- 只能对两个数字或两个字符作大小性比较. lua 按照字母次序(alphabetical order)比较字符串,具体的字母次序取决于对 lua 的区域设置
-- 避免类型不一致的比较
-- 逻辑操作符 and, or, not
-- 所有的逻辑操作符将 false 和 nil 视为假,而将其他的任何东西视为真
-- and 和 or 都使用"短路求值(short-cut evaluation)"
-- x = x or v 等价于 if not x then x = v end
-- and 优先级高于 or
-- (a and b) or c 等价于 C 语言中的 a ? b : c,前提是 b 不为假值
function max(x, y)
    return (x > y) and x or y;
end

print(max(5, 11));
print(max('abc', 'xyz'));

-- lua 中字符串是不可变的值(immutable value),连接操作符只会创建一个新字符串,不会对原操作数进行任何个性
-- 在二元操作符中,除了指数操作符 ^ 和连接操作符 .. 是"右"结合的,其他都 是"左结合"(left associative)

-- table 构造式 table constructor
local days = {'Sunday', 'Monday', 'Tuesday', 'Wednesday',
              'Thursday', 'Friday', 'Saturday'};
print(days[6]);

local point = {x = 20, y = 86}; -- 等价于 point = {}; point.x = 20; point.y = 86;
print(point.x);
print(point['y']);

-- 下面这行会报错,与 js 稍有区别
--local test = {'t' = 'abc'};
-- js 中 var t = {a: 'bac'}; 与 var t = {'a': 'bac'}; 是等价的
-- lua  允许在方括号之间,显式地用一个表达式来初始化索引值
-- table 未必元素后面的 , 可有可无,与 php 相似,加上有助于代码维护
local opnames = {['+'] = 'add', ['-'] = 'sub',
                 ['*'] = 'mul', ['/'] = 'div', };
local op = '*';
print(opnames[op]);
-- 构造式 {x = 0, y = 0} 等价于 {['x'] = 0, ['y'] = 0}
-- 构造式 {'x', 'y', 'z'} 等价于 {[1] = 'x', [2] = 'y', [3] = 'z'}

-- lua 中不推荐以 0 作为数组的起始索引.大多数内建函数都假设数组起始索引为 1
-- 在一个构造式中可以用分号代替逗号





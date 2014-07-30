-- 面向对象编程
-- 使用 self 参数是所有面向对象语言的一个核心.
-- 大多数面向对象语言都能对程序员隐藏部分 self 参数,从而舍不得程序员不必显式地声明这个参数.
-- lua 只需要使用冒号 ":",则能隐藏参数.
-- 冒号的作用是在一个方法定义中添加一个额外的隐藏参数,以及在一个方法调用中添加一个额外的实参.
-- 冒号只是一种语法便利.
-- 用点语法来定义一个函数,并用冒号语法调用它,反之亦然,只要能正确的处理额外的参数即可.

-- 类
local person = {
    name = '',
    age  = 0,
};

person.new = function(self, name, age)
    self.name = name;
    self.age  = age;
end;

function person:dump()
    print(self.name, self.age);
end;

tom = {};
setmetatable(tom, {__index = person});
tom:new('tom', 22);
tom:dump();

person:dump();
person.dump(tom);


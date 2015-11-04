-- 编译
-- dofile 函数是一种内置的操作,用于运行 lua 代码块
-- 实际上 dofile 是一个辅助函数, loadfile 才做了真正核心的工作.

local dofile = function(filename)
    local f = assert(loadfile(filename));
    return f();
end

-- loadstring('i = i + 1');
-- loadstring 总是在全局环境中编译它的字符串.

-- lua 通常不会包含任何无法通过 ANSI C 来实现的机制.

-- lua 提供的所有关于动态链接的功能都聚集在一个函数中,即 package.loadlib.
local path   = '/usr/local/lib/lua/5.1/socket.so';
local socket = package.loadlib(path, 'luaopen_socket');

-- 错误 error
-- assert 函数检查其第一个参数是否为 true.若为 true, 则简单地返回该参数;否则(为 false 或 nil)就引发一个错误.
-- assert 抛异常会终止程序
print('Enter a number: ');
local num = assert(io.read('*number'), 'Invalid input!');
--local fp = assert(io.open('no-file', 'r'));

-- pcall 函数以一种"保护模式(protected mode)"来调用它的第一个参数,
-- 因此 pcall 可以捕获函数执行中的任何错误.
local status, err = pcall(function() error({code = 121}) end);
print(status);
print(err.code);

-- 错误消息与追溯(traceback)
local status, err = pcall(function() local a = "a" + 1 end);
print(err);

local status, err = pcall(function() error('test error') end);
print(err);
print(debug.traceback());


-- 模块与包
-- require 用于使用模块
-- module 用于创建模块
-- 术语: 规则(policy)
-- 从用户观点来看,一个模块就是一个程序库,可以通过 require 来加载.
--[[
1. 最简单的例子
require 'mod';
mod.foo();

2. 设置局名称
local m = require 'mod';
m.foo();
--]]

local m = require 'io';
m.write('Just hi.\n');

-- require 采用的路径是一连串的模式(pattern),其中每项都是一种将模块名转换为文件名的方式.
-- require 会用模块名来替换每个 "?",然后根据替换的结果来检查文件是否存在.如果不存在,尝试下一项.
-- 路径的每项以分号隔开.与 linux 的 : 规范不一致.
-- 常见路径例子:
-- ?;?.lua;/usr/local/lua/?/?.lua;/usr/local/lua/?.lua;

-- require 用于搜索 lua 文件的路径存放在变量 package.path 中.对应的环境变量是: LUA_PATH
-- 如果 require 无法找到与模块名相符的 lua 文件,会找 C 程序库.搜索会从变量 package.cpath 获取路径.对应的环境变量: LUA_CPATH
-- 常见的路径:
-- ./?.so;/usr/local/lib/lua/5.1/?.so;

-- 经过测试, require 的文件,多次 require 只会被加载一次.

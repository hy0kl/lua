-- nginx 中的设置搜索路径
--lua_package_path "/usr/local/lua/lib/lua/5.1/?.lua;;";
--lua_package_cpath "/usr/local/lib/lua/5.1/?.so;;";

-- lua 脚本中设置搜索路径
package.path  = "/home/baihe/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?.lua;";
package.cpath = "/home/baihe/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;";

local cjson = require "cjson"
local cjson2 = cjson.new()
local cjson_safe = require "cjson.safe"

local json = {};
json['key'] = 'value';
json[0] = '这是一个key为0的元素';

print(cjson.encode(json))

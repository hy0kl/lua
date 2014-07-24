-- nginx 中的设置搜索路径
--lua_package_path "/usr/local/lua/lib/lua/5.1/?.lua;;";
--lua_package_cpath "/usr/local/lib/lua/5.1/?.so;;";

-- lua 脚本中设置搜索路径
package.path  = "/home/work/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?.lua;";
package.cpath = "/home/work/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;";

curl = require("luacurl")

function get_html(url, c)
--{
    local result = { }
    if c == nil then
        -- 有说 new() 过时,要用 easy_init()
        -- 但查看最新源码时发现 easy_init() 并没有被包装
        c = curl.new()
    end

    c:setopt(curl.OPT_URL, url)
    c:setopt(curl.OPT_WRITEDATA, result)
    c:setopt(curl.OPT_WRITEFUNCTION, function(tab, buffer)     --call back函数，必须有
        table.insert(tab, buffer)                      --tab参数即为result，参考http://luacurl.luaforge.net/

        -- 带 # 返回,不明觉厉
        return #buffer
    end);

    local ok = c:perform()
    return ok, table.concat(result)             --此table非上一个table，作用域不同
--}
end

ok, html = get_html("http://www.baidu.com/")
if ok then
    print (html)
else
    print ("Error" )
end

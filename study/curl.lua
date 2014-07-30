package.path  = "/home/work/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?.lua;./?.lua;";
package.cpath = "/home/work/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;./?.so;";

require("cURL");

-- open output file
-- 用 table 代替写文件,明显性能要好很多
--f = io.open("baidu.com", "w")
local f = {};

c = cURL.easy_init();
-- setup url
c:setopt_url("http://www.baidu.com/");
-- perform, invokes callbacks
c:perform({writefunction = function(str)
    --f:write(str)
    f[#f + 1] = str;
end});

-- close output file
--f:close()
print("Done");
print(table.concat(f));


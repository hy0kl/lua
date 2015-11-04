-- 操作系统库

for attr in pairs(os) do
    if 'function' == type(os[attr]) then
        print(attr);
    end
end
--[[
$ lua p22.lua | sort | pbcopy

clock
date
difftime
execute
exit
getenv
remove
rename
setlocale
time
tmpname

-- 日期和时间
os.time() 的 table 参数
year    一个完整的年份
month   01~12
day     01~31
hour    00~23
min     00~59
sec     00~59
isdst   一个布尔值,true 表示夏令时

os.date() 转义参数的有效范围
%a  一星期中天数的简写(Wed)
%A  一星期中天数的全称(Wednesday)
%b  月份的简写(Sep)
%A  月份的全称(September)
%c  日期和时间(09/16/14 22:10:33)
%d  一个月中的第几天[01~31]
%H  24小时制中的小时数[00~23]
%I  12小时制中的小时数[01~12]
%j  一年中的第几天[00~366]
%M  分钟数[00~59]
%m  月份数[01~12]
%p  "上午(am)"或"下午(pm)"
%S  秒数[00~59]
%w  一星期中的第几天[0~6 星期天~星期六]
%x  日期(09/16/14)
%X  时间(23:32:22)
%y  两位数的年份[00~99]
%Y  完整的年份(2014)
%%  字符%

--]]


print(os.time());

print(os.getenv('HOME'));


-- dbg mean custom debug.
local dbg = {};
dbg.prefix = '';
dbg.indent = '    ';
dbg.print_r = function(array, arg_prefix)
    local prefix = '';
    if arg_prefix then
        dbg.prefix = dbg.prefix .. arg_prefix;
    end;
    prefix = dbg.prefix;

    if 'table' ~= type(array) then
        print('It is NOT table: ' .. array);
        return 0;
    end; -- end if

    for key, value in pairs(array) do
        if 'table' == type(value) then
            print(prefix .. key .. ': is a table =>');
            dbg.print_r(value, dbg.indent);
        else
            print(prefix .. key .. ' = ' .. value);
        end;    -- end if
    end;    -- end for

    return 0;
end;

t_table = {'one', 'two', 'there',};
t_array = {'one', 'two', 'there', ['array'] = {['test-1'] = 'QQ', ['test-2'] = 'baidu'}};

--print(table.getn);
print('------\n' .. _VERSION .. ' table method: ');
print(table.concat);
for k, v in pairs(table) do
    print(k, ' = ', v)
end
print('End \n------');

dbg.print_r('test function...');
dbg.print_r(t_array);


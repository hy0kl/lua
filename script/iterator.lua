local debug = {};
debug.prefix = '';
debug.indent = '    ';
debug.print_r = function(array, arg_prefix)
    local prefix = '';
    if arg_prefix then
        debug.prefix = debug.prefix .. arg_prefix;
    end;
    prefix = debug.prefix;

    if 'table' ~= type(array) then
        print('It is NOT table: ' .. array);
        return 0;
    end; -- end if

    for key, value in pairs(array) do
        if 'table' == type(value) then
            print(prefix .. key .. ': is a table =>');
            debug.print_r(value, debug.indent);
        else
            print(prefix .. key .. ' = ' .. value);
        end;    -- end if
    end;    -- end for

    return 0;
end;

t_table = {'one', 'two', 'there',};
t_array = {'one', 'two', 'there', ['array'] = {['test-1'] = 'QQ', ['test-2'] = 'baidu'}};

--print(table.getn);
print('------\nLua5.2 table method: ');
print(table.concat);
for k, v in pairs(table) do
    print(k, ' = ', v)
end
print('End \n------');

debug.print_r('test function...');
debug.print_r(t_array);


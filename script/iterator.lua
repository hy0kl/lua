debug = {};
debug.prefix = '';
debug.print_r = function(array, ...)
    local prefix = '';
    local arg_prefix = '';
    if arg[1] then
        arg_prefix = arg[1];
    end;
    debug.prefix = debug.prefix .. arg_prefix;
    prefix = debug.prefix;

    if 'table' ~= type(array) then
        print('It is NOT table: ' .. array);
        return 0;
    end; -- end if

    for key, value in pairs(array) do
        if 'table' == type(value) then
            print(prefix .. key .. ' is a table =>');
            debug.print_r(value, '$$$');
        else
            print(prefix .. key .. ' = ' .. value);
        end;    -- end if
    end;    -- end for

    return 0;
end;

t_table = {'one', 'two', 'there',};
t_array = {'one', 'two', 'there', ['array'] = {['test-1'] = 'QQ', ['test-2'] = 'baidu'}};

print(table.getn);
print(table.concat);

for k, v in pairs(t_table) do
    print(k .. ' = ' .. v)
end

debug.print_r('test function...');
debug.print_r(t_array);


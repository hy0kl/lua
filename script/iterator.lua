print_r = function(array)
    if 'table' ~= type(array) then
        print('It is NOT table.');
        return 0;
    end; -- end if

    for key, value in pairs(array) do
        if 'table' == type(value) then
            print(key .. ' is a table =>');
            print_r(value);
        else
            print(key .. ' = ' .. value);
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

print_r('test function...');
print_r(t_array);


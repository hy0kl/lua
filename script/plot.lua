#!/Users/hy0kl/local/bin/lua

-- clean screen
erase_terminal = function()
    return io.write("\27[2J");
end;

-- writes an `*' at clumn `x', row `y'
mark = function(x, y)
    io.write(string.format("\27[%d;%dH*", y, x));
end;

-- Terminal size
terminal_size = {w = 80, h = 24,};

-- plot a function
-- (assume that domain and image are in the range [-1, 1])
plot = function(f)
    erase_terminal();
    for i = 1, terminal_size.w do
        local x = (i / terminal_size.w) * 2 - 1;
        local y = (f(x) + 1) /2 * terminal_size.h;
        mark(i, y);
    end;
    
    io.read();  -- wait berfor spoiling the screen
end;

plot(function (x) return math.sin(x * 2 * math.pi) end);

-- 协同程序(coroutine)
local co = coroutine.create(function()
   print('Hi, this is coroutine programe.');
end);
print(co);

-- 一个协同程序可以处于4种不同的状态: 挂起(suspended),运行(running),死亡(dead)和正常(normal)
-- 当创建一个协同程序时,它处于挂起状态.
-- 协同程序不会在创建时自动执行.
print(coroutine.status(co)); -- 检查协同程序的状态

-- 函数 coroutine.resume() 用于启动或再次启动一个协同程序的执行,并将其状态由挂起改为运行
coroutine.resume(co);
print(coroutine.status(co));

-- 协同程序的真正强大之处在于函数 yield 的使用上,它可让一个运行的协同程序挂起,而之后可以再恢复它的运行.

local cor = coroutine.create(function()
    for i = 1, 10 do
        print('coroutine', i);
        coroutine.yield();
    end
end);

for k = 1, 11 do
    print('call times: ' .. k);
    coroutine.resume(cor);
    print(coroutine.status(cor));
end

-- 管道(pipe)与过滤器(filter)
-- 协同程序被称为一匹配生产者和消费者的理想工具,一对 resume-yield 完全一改典型的调用者被调用者之前的关系.
local pc = {};
-- 程序通过调用消费者来启动.
-- 当消费者需要一个新值时,它会唤醒生产者.
-- 生产者返回一个新值后停止运行,并等待消费者的再次唤醒.
-- 典型的"消费者驱动(consumer-driven)"

-- 生产者
pc.producer = function ()
    return coroutine.create(function()
        while true do
            local x = io.read();    -- 产生新值
            pc.send(x);
        end
    end);
end;

-- 发送
pc.send = function(x)
    coroutine.yield(x);
end;

-- 接收
pc.receive = function(prod)
    local status, value = coroutine.resume(prod);
    return value;
end;

-- 过滤器
pc.filter = function(prod)
    return coroutine.create(function()
        --for line = 1, math.huge do -- 在我的开发环境中跑不通
        for line = 1, 100 do
            local x = pc.receive(prod); -- get new produce
            x = string.format('%5d %s', line, x);
            pc.send(x);
        end
    end);
end;

-- 消费者
pc.consumer = function(prod)
    while true do
        local x = pc.receive(prod); -- get produce
        io.write(x .. '\n'); -- 消费值
    end
end;

-- 启动
local p = pc.producer();
local f = pc.filter(p);
pc.consumer(f);
-- pc.consumer(pc.filter(pc.producer()));
-- 有点不明觉厉,需要反复的读


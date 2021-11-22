local a='__lsn_'local b=#a;local Events={defaultMaxListeners=10}setmetatable(Events,{__call=function(c,...)return Events:new(...)end})
local function d(e,f)local g,h=0,#e;for i=1,h do local j,k=false,i-g;if type(f)=='function'then j=f(e[k])else j=e[k]==f end;if e[k]~=nil and j then e[k]=nil;table.remove(e,k)g=g+1 end end;return e end;
function Events:new(l)l=l or{}self.__index=self;setmetatable(l,self)l._on={}return l end;function Events:evTable(m)if type(self._on[m])~='table'then self._on[m]={}end;return self._on[m]end;
function Events:getEvTable(m)return self._on[m]end;function Events:addListener(m,n)local o=a..tostring(m)local p=self:evTable(o)local q=self.currentMaxListeners or self.defaultMaxListeners;
local r=self:listenerCount(m)table.insert(p,n)if r>q then print('WARN: Number of '..string.sub(o,b+1).." event listeners: "..tostring(r))end;return self end;
function Events:emit(m,...)local o=a..tostring(m)local p=self:getEvTable(o) if p~=nil then for c,s in ipairs(p)do local t,u=pcall(s,...)if not t then print(string.sub(c,b+1).." emit error: "..tostring(u))end end end;
o=o..':once'p=self:getEvTable(o)if p~=nil then for c,s in ipairs(p)do local t,u=pcall(s,...)if not t then print(string.sub(c,b+1).." emit error: "..tostring(u))end end;
d(p,function(v)return v~=nil end)self._on[o]=nil end;return self end;function Events:getMaxListeners()return self.currentMaxListeners or self.defaultMaxListeners end;
function Events:listenerCount(m)local w=0;local o=a..tostring(m)local p=self:getEvTable(o)if p~=nil then w=w+#p end;o=o..':once'p=self:getEvTable(o)if p~=nil then w=w+#p end;return w end;
function Events:listeners(m)local o=a..tostring(m)local p=self:getEvTable(o)local x={}if p~=nil then for i,s in ipairs(p)do table.insert(x,s)end end;
o=o..':once'p=self:getEvTable(o)if p~=nil then for i,s in ipairs(p)do table.insert(x,s)end end;return x end;Events.on=Events.addListener;
function Events:once(m,n)local o=a..tostring(m)..':once'local p=self:evTable(o)local q=self.currentMaxListeners or self.defaultMaxListeners;
local r=self:listenerCount(m)if r>q then print('WARN: Number of '..m.." event listeners: "..tostring(r))end;table.insert(p,n)return self end;
function Events:removeAllListeners(m)if m~=nil then local o=a..tostring(m)local p=self:evTable(o)d(p,function(v)return v~=nil end)o=o..':once'
p=self:evTable(o)d(p,function(v)return v~=nil end)self._on[o]=nil else for y,z in pairs(self._on)do self:removeAllListeners(string.sub(y,b+1))end end;
for y,z in pairs(self._on)do if#z==0 then self._on[y]=nil end end;return self end;function Events:removeListener(m,n)local o=a..tostring(m)local p=self:evTable(o)local A=0;
assert(n~=nil,"listener is nil")d(p,n)if#p==0 then self._on[o]=nil end;o=o..':once'p=self:evTable(o)d(p,n)if#p==0 then self._on[o]=nil end;return self end;
function Events:setMaxListeners(B)self.currentMaxListeners=B;return self end;return Events
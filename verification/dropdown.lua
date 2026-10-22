-- Execute the actual patched dropdown renderer, not a reimplementation.
local report=io.write
local environment={}
setmetatable(environment,{__index=_G})
local e=environment
e.clamp=function(n,a,b) return math.max(a,math.min(b,n)) end
e.mix=function() return 0 end
e.ease=function(_,target) return target end
e.fitText=function(text) return text end
e.box=function() end e.label=function() end e.icon=function() end
e.black=0 e.white=0 e.tint=0 e.accent=0 e.ink=0 e.muted=0
e.x=0 e.y=0 e.S=1 e.H=500 e.mx=0 e.my=0
e.hit=function(px,py,w,h) return e.mx>=px and e.mx<=px+w and e.my>=py and e.my<=py+h end
if not table.find then function table.find(t,value) for i,v in ipairs(t) do if v==value then return i end end end end
local renderer=assert(load(DROPDOWN_SOURCE.."\nreturn renderDropdownPopup","@dropdown-renderer","t",e))()
local function popup(count)
    local c={Options={},Value="Option 1",Multi=false}
    for i=1,count do c.Options[i]="Option "..i end
    function c:SetValue(value) self.Value=value end
    function c:GetValue() return self.Value end
    return {control=c,x=100,y=50,w=150,offset=0,Closing=false}
end
local function reset()
    e.ui={Wheel=0,PageKey=0,DropKey=0,Press={moved=false}}
    e.mx,e.my,e.click,e.tap,e.down=0,0,false,false,false
end
local passed=0
local function check(name,fn)
    reset() fn() passed=passed+1 report("PASS dropdown "..name.."\n")
end
check("Page Down reaches later options and consumes the modal key",function()
    local p=popup(15) e.ui.PageKey=1 renderer(p,1)
    assert(p.offset==7 and e.ui.PageKey==0 and not p.Closing)
    e.ui.PageKey=1 renderer(p,1) assert(p.offset==8)
    e.ui.PageKey=-1 renderer(p,1) assert(p.offset==1)
end)
check("arrow navigation clamps at both ends",function()
    local p=popup(15) e.ui.DropKey=1 renderer(p,1) assert(p.offset==1)
    p.scroll=8 e.ui.DropKey=1 renderer(p,1) assert(p.offset==8)
    p.scroll=0 e.ui.DropKey=-1 renderer(p,1) assert(p.offset==0)
end)
check("wheel input still works when the host supplies it",function()
    local p=popup(15) e.mx,e.my=120,80 e.ui.Wheel=-2 renderer(p,1)
    assert(p.offset==2 and e.ui.Wheel==0)
end)
check("footer buttons change options without selecting or closing",function()
    local p=popup(15)
    e.mx,e.my,e.click,e.down=220,236,true,true
    renderer(p,1)
    assert(p.offset==1 and not p.Closing and not e.click and e.ui.Press.moved)
    e.mx,e.my,e.click=120,236,true renderer(p,1) assert(p.offset==0)
end)
check("dragging the scrollbar reaches the final item",function()
    local p=popup(15)
    e.mx,e.my,e.click,e.down=243,64,true,true renderer(p,1)
    assert(e.ui.Drag.kind=="dropdownbar" and e.ui.Press.moved)
    e.click=false e.my=220 renderer(p,1)
    assert(p.offset==8 and not p.Closing)
    e.ui.Drag=nil e.down=false e.tap=false renderer(p,1)
    assert(p.control.Value=="Option 1")
end)
check("list dragging remains available",function()
    local p=popup(15)
    e.mx,e.my,e.click,e.down=120,100,true,true renderer(p,1)
    e.click=false e.my=28 renderer(p,1) assert(p.offset==3)
end)
check("the last visible option selects the final value",function()
    local p=popup(15) p.scroll=8 e.mx,e.my,e.tap=120,205,true
    renderer(p,1) assert(p.control.Value=="Option 15" and p.Closing)
end)
check("short lists have no unnecessary scrolling",function()
    local p=popup(3) e.ui.PageKey=1 renderer(p,1)
    assert(p.offset==0 and p.scroll==0 and not p.Closing)
end)
check("a dropdown near the bottom remains inside the window",function()
    local p=popup(15) p.y=490
    local bottom=0
    e.box=function(id,px,py,w,h) if id=="dd" then bottom=py+h end end
    renderer(p,1) assert(bottom<=490)
end)
report(passed.." dropdown checks passed.\n")

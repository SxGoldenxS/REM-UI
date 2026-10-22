local function renderDropdownPopup(p,reveal)
 local c=p.control
 local count=#c.Options;local shown=math.min(7,count)
 local rowH=24;local listH=shown*rowH+8
 local maxOff=math.max(0,count-shown)
 local height=listH+(maxOff>0 and 26 or 0)
 local py=clamp(p.y+(1-reveal)*-6,10,math.max(10,H-height-10))
 p.scroll=clamp(p.scroll or p.offset or 0,0,maxOff)
 if ui.Wheel~=0 and hit(p.x,py,p.w,height,true) then
  p.scroll=clamp(p.scroll-ui.Wheel,0,maxOff);ui.Wheel=0
 end
 -- The modal owns navigation; do not scroll the content underneath it.
 if ui.PageKey~=0 then p.scroll=clamp(p.scroll+ui.PageKey*shown,0,maxOff);ui.PageKey=0 end
 if (ui.DropKey or 0)~=0 then p.scroll=clamp(p.scroll+ui.DropKey,0,maxOff);ui.DropKey=0 end
 local trackX,trackY,trackH=p.x+p.w-12,py+4,listH-8
 local thumbH=maxOff>0 and math.max(18,trackH*shown/count) or trackH
 local thumbY=trackY+(trackH-thumbH)*(maxOff>0 and p.scroll/maxOff or 0)
 local function consumePress()
  click=false;tap=false
  if ui.Press then ui.Press.moved=true end
 end
 if maxOff>0 then
  if click and hit(trackX,trackY,12,trackH,true) then
   local pointerY=(my-y)/S
   local inside=pointerY>=thumbY and pointerY<=thumbY+thumbH
   ui.Drag={kind="dropdownbar",popup=p,offset=inside and pointerY-thumbY or thumbH/2}
   consumePress()
  end
  if ui.Drag and ui.Drag.popup==p and ui.Drag.kind=="dropdownbar" and down then
   local ratio=((my-y)/S-ui.Drag.offset-trackY)/math.max(1,trackH-thumbH)
   p.scroll=clamp(ratio,0,1)*maxOff
  end
  local footerY=py+listH
  if click and hit(p.x+4,footerY,34,24,true) then
   p.scroll=clamp(p.scroll-1,0,maxOff);consumePress()
  elseif click and hit(p.x+p.w-42,footerY,38,24,true) then
   p.scroll=clamp(p.scroll+1,0,maxOff);consumePress()
  end
 end
 if click and maxOff>0 and hit(p.x,py,p.w-14,listH,true) then
  ui.Drag={kind="dropdown",y0=my,s0=p.scroll,popup=p}
 end
 if ui.Drag and ui.Drag.popup==p and ui.Drag.kind=="dropdown" and down then
  p.scroll=clamp(ui.Drag.s0-((my-ui.Drag.y0)/S)/rowH,0,maxOff)
 end
 p.offset=math.floor(p.scroll+.5)
 box("ddShadow",p.x-3,py+3,p.w+6,height+4,black,.35*reveal,10,68)
 box("ddRim",p.x-1,py-1,p.w+2,height+2,accent,.28*reveal,9,69)
 box("dd",p.x,py,p.w,height,mix(tint,white,.05),.98*reveal,8,70)
 local itemW=p.w-(maxOff>0 and 20 or 8)
 for j=1,shown do
  local value=c.Options[p.offset+j];local ry=py+4+(j-1)*rowH
  local over=hit(p.x+4,ry,itemW,rowH-2,true)
  local chosen=c.Multi and table.find(c.Value,value)~=nil or (not c.Multi and c.Value==value)
  local hv=ease("ddo"..j,over and 1 or 0,18)
  box("ddr"..j,p.x+4,ry,itemW,rowH-2,accent,(chosen and .2 or 0)*reveal+hv*.1*reveal,5,71)
  label("ddt"..j,fitText(value,11,p.w-34),p.x+12+hv*3,ry+5,11,chosen and accent or mix(muted,ink,.6+hv*.4),reveal,chosen,72)
  if chosen then icon("ddc"..j,"check",p.x+p.w-25,ry+1,accent,reveal,73,0,.8) end
  if over and tap then
   tap=false
   if c.Multi then
    local list=c:GetValue();local at=table.find(list,value)
    if at then table.remove(list,at) else list[#list+1]=value end
    c:SetValue(list)
   else c:SetValue(value);p.Closing=true end
  end
 end
 if maxOff>0 then
  thumbY=trackY+(trackH-thumbH)*(p.scroll/maxOff)
  box("ddTrack",trackX,trackY,10,trackH,ink,.08*reveal,4,72)
  box("ddBar",trackX+1,thumbY,8,thumbH,accent,.7*reveal,4,73)
  local footerY=py+listH
  box("ddUp",p.x+4,footerY+1,34,22,ink,.09*reveal,4,72)
  box("ddDown",p.x+p.w-42,footerY+1,38,22,ink,.09*reveal,4,72)
  label("ddUpText","Up",p.x+12,footerY+6,10,ink,reveal,false,73)
  label("ddDownText","Down",p.x+p.w-36,footerY+6,10,ink,reveal,false,73)
  label("ddRange",string.format("%d-%d/%d",p.offset+1,p.offset+shown,count),p.x+42,footerY+6,9,muted,reveal,false,73)
 end
 if click and not hit(p.x,py,p.w,height,true) then p.Closing=true;click=false end
end

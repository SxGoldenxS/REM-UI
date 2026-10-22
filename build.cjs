const fs = require('fs');
const path = require('path');
const base = __dirname;
const original = fs.readFileSync(path.join(base, 'rem_v6.lua'), 'utf8');
const dropdownStart = original.indexOf('local function renderDropdownPopup(p,reveal)');
const dropdownEnd = original.indexOf('local function renderColorPopup(p,reveal)', dropdownStart);
if (dropdownStart < 0 || dropdownEnd < 0) throw new Error('Pinned REM dropdown not found');
const oldDropdown = original.slice(dropdownStart, dropdownEnd);
const newDropdown = fs.readFileSync(path.join(base, 'dropdown-scroll.lua'), 'utf8').trimEnd() + '\n';
const wheelStart = original.indexOf('pcall(function()\n local uis=game:GetService("UserInputService")');
const wheelEnd = original.indexOf('local function renderSidebar()', wheelStart);
if (wheelStart < 0 || wheelEnd < 0) throw new Error('Pinned REM wheel handler not found');
const oldWheel = original.slice(wheelStart, wheelEnd);
const newWheel = `pcall(function()
 local uis=game:GetService("UserInputService")
 local changed=uis.InputChanged
 app.MouseWheelSupported=changed~=nil
 if changed then
  ui.WheelConn=changed:Connect(function(input)
   if tostring(input.UserInputType):find("MouseWheel") then
    local z=0;pcall(function() z=input.Position.Z end)
    if z~=0 then ui.Wheel=ui.Wheel+(z>0 and 1 or -1) end
   end
  end)
 end
end)
`;
const replacements = [
  [oldDropdown, newDropdown],
  ['if ui.PageKey~=0 then ui.ScrollTarget[tab]', 'if ui.PageKey~=0 and not popup then ui.ScrollTarget[tab]'],
  [' ui.PageKey=0\n', ' ui.PageKey=0;ui.DropKey=0\n'],
  ['  ui.PrevPU,ui.PrevPD=pu,pd\n', `  ui.PrevPU,ui.PrevPD=pu,pd
   local up,dn=iskeypressed(0x26),iskeypressed(0x28)
   if up and not ui.PrevDropUp then ui.DropKey=-1 elseif dn and not ui.PrevDropDown then ui.DropKey=1 end
   ui.PrevDropUp,ui.PrevDropDown=up,dn
`],
  [oldWheel, newWheel],
  ['app.Version="6.1"', 'app.Version="6.1-scrollfix.1"'],
];
let patched = original;
for (const [before, after] of replacements) {
  if (!before || patched.indexOf(before) < 0 || patched.indexOf(before) !== patched.lastIndexOf(before)) {
    throw new Error('Patch is not unique: ' + before.slice(0, 80));
  }
  patched = patched.replace(before, after);
}
fs.writeFileSync(path.join(base, 'rem_v6-matcha.lua'), patched);
console.log('Built REM Matcha compatibility edition.');


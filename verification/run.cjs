const fs = require('fs');
const path = require('path');
const { lua, lauxlib, lualib, to_luastring, to_jsstring } = require('fengari');
const state = lauxlib.luaL_newstate();
lualib.luaL_openlibs(state);
lua.lua_pushstring(state, to_luastring(fs.readFileSync(path.join(__dirname, '..', 'dropdown-scroll.lua'), 'utf8')));
lua.lua_setglobal(state, to_luastring('DROPDOWN_SOURCE'));
function run(code, name) {
  const status = lauxlib.luaL_loadbuffer(state, to_luastring(code), null, to_luastring(name));
  if (status !== lua.LUA_OK || lua.lua_pcall(state, 0, 0, 0) !== lua.LUA_OK) {
    throw new Error(to_jsstring(lua.lua_tostring(state, -1)));
  }
}
// Compile the actual reviewed REM source too; its rendering needs the live Matcha VM.
const rem = fs.readFileSync(path.join(__dirname, '..', 'rem_v6-matcha.lua'), 'utf8');
if (lauxlib.luaL_loadbuffer(state, to_luastring(rem), null, to_luastring('@rem_v6.lua')) !== lua.LUA_OK) {
  throw new Error(to_jsstring(lua.lua_tostring(state, -1)));
}
lua.lua_pop(state, 1);
run(fs.readFileSync(path.join(__dirname, 'dropdown.lua'), 'utf8'), '@dropdown.lua');

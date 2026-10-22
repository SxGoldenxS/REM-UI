# REM UI

REM v6.1, with a Matcha compatibility edition that fixes dropdown navigation.

```lua
loadstring(game:HttpGet("https://gitlab.com/ellijahheath/rem-ui/-/raw/main/loader.lua"))()
```

The loader opens the Matcha edition. Right Shift toggles the menu. Library API remains available through `getfenv().Rem`.

Dropdowns support a draggable scrollbar, Up/Down buttons, arrow keys, and Page Up/Page Down. Mouse wheel input works on hosts that expose wheel events; Matcha currently does not expose them. Dropdown navigation consumes modal keys so the page underneath stays still.

- `rem_v6.lua`: original REM v6.1 source from [your original repository](https://github.com/daddysxgold/Blade-Ball-is-Easy/blob/2163c68ac2197a1a88f8b844e91c1d60583710b3/rem_v6.lua).
- `rem_v6-matcha.lua`: generated compatibility edition.
- `dropdown-scroll.lua`: authoritative replacement dropdown renderer.
- `build.cjs`: applies six exact compatibility changes and fails if the baseline differs.

## Verify

Node.js 18 or later:

```sh
npm ci
node build.cjs
npm test
```

Nine dropdown behavior checks run the actual replacement renderer; the complete library is syntax checked. Native rendering was also verified in Matcha.

if _G._genToken then pcall(function() _G._genToken.unload() end) end

do
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local hs = game:GetService("HttpService")
local lp = Players.LocalPlayer
local remyCodes = { 70 }
local remyHasMouse = false
local remyLabel = "F"
local abilityCodes = { 81 }
local abilityReadyAt = 0
local ymerAutoT = 0
local lalaPrev = false
local CFG_FILE = "remybb-config.json"
local TAU = math.pi * 2
local DM = 12
local DN = 18
local POOL = 16
local VIS_SEG = 12
local C_TXT_A = Color3.fromRGB(235, 235, 240)
local C_TXT_B = Color3.fromRGB(160, 200, 255)

local realKeypress = _G.__apRealKeypress or keypress
local realKeyrelease = _G.__apRealKeyrelease or keyrelease
_G.__apRealKeypress = realKeypress
_G.__apRealKeyrelease = realKeyrelease
pcall(function() _G.keypress = function() end end)
pcall(function() _G.keyrelease = function() end end)

_G.__apGen = (_G.__apGen or 0) + 1
local bob = _G.__apGen

_G.__apTapState = _G.__apTapState or {}
local remy = _G.__apTapState
remy.recentlyTapped = remy.recentlyTapped or {}
remy.tapping = remy.tapping or false
remy.lastTap = remy.lastTap or 0

_G.__apUserF = _G.__apUserF or 0

_G.autoParry = _G.autoParry or {}
local lala = _G.autoParry
lala.enabled = false
lala.v2 = true
lala.leadTime = 0.22
lala.pingComp = true
lala.pingTiers = { 30, 50, 70, 120, 170 }
lala.pingLead = { 0.34, 0.38, 0.44, 0.52, 0.58, 0.64 }
lala.pingMax = 0.5
lala.customLeadMode = false
lala.customLeadValue = 0.10
lala.minDist = 16
lala.maxDist = 400
lala.panicBase = 28
lala.panicSpeedMul = 0.08
lala.cooldown = 0.05
lala.perBallCooldown = 0
lala.userSuppress = 0
lala.maxSpeed = 2000
lala.accelLead = true
lala.fastFrame1 = true
lala.fastBallThreshold = 120
lala.closeRangeDist = 14
lala.facingMin = -0.35
lala.customFacingMinMode = false
lala.customFacingMinValue = -0.35
lala.showVis = true
    lala.dome = false

lala.cone = false
lala.clash = false
lala.keyP = lala.keyP or 80
lala.keyV = lala.keyV or 86
lala.keyC = lala.keyC or 67
lala.keyX = lala.keyX or 88
lala.keyL = lala.keyL or 76
lala.keyB = lala.keyB or 66
lala.keyR = lala.keyR or 82
lala.keyN = lala.keyN or 78
lala.keyG = lala.keyG or 71
lala.keyT = lala.keyT or 84
lala.keySmart = lala.keySmart or 77
lala.keyPanic = lala.keyPanic or 75
lala.accuracy = 100
lala.randomize = false
lala.randMin = 20
lala.randMax = 100
lala.bvLen = 100
lala.bvThick = 6
lala.bvDist = true
lala.bvSpeed = false
lala.bvTarget = true
lala.bvRadar = false
lala.bvExtras = true
lala.infinityAvoid = true
lala.apWalk = true
lala.apJump = true
lala.apAim = true
lala.accHead = true
lala.keybindsHud = false
lala.autoplay = false
lala.abilityEsp = false
lala.abilityParry = true
lala.smartParry = false
lala.panicParry = true
lala.trainingBall = false
lala.triggerbot = false
lala.triggerOnce = false
lala.hudEnabled = false
lala.apColor = { r = 0, g = 255, b = 120 }
lala.apThick = 2
lala.apTrans = 5
lala.pdColor = { r = 255, g = 0, b = 0 }
lala.pdThick = 3
lala.pdTrans = 15
lala.bvColor = { r = 0, g = 255, b = 0 }
lala.bvEnd = { r = 255, g = 0, b = 0 }

local function buildSaveData()
    return {
        keyP = lala.keyP or 0, keyV = lala.keyV or 0, keyC = lala.keyC or 0, keyX = lala.keyX or 0, keyL = lala.keyL or 0, keyB = lala.keyB or 0, keyR = lala.keyR or 0, keyN = lala.keyN or 0,
        v2 = lala.v2, showVis = lala.showVis, dome = lala.dome, cone = lala.cone, clash = lala.clash,
        triggerbot = lala.triggerbot,
        triggerOnce = lala.triggerOnce,
        remyCodes = remyCodes, remyHasMouse = remyHasMouse, remyLabel = remyLabel,
        abilityEsp = lala.abilityEsp,
        abilityParry = lala.abilityParry,
        smartParry = lala.smartParry,
        panicParry = lala.panicParry,
        trainingBall = lala.trainingBall,
        hudEnabled = lala.hudEnabled,
        customLeadMode = lala.customLeadMode,
        customLeadValue = lala.customLeadValue,
        customFacingMinMode = lala.customFacingMinMode,
        customFacingMinValue = lala.customFacingMinValue,
        accuracy = lala.accuracy,
        randomize = lala.randomize,
        accHead = lala.accHead,
        keybindsHud = lala.keybindsHud,
        minDist = lala.minDist, maxDist = lala.maxDist, closeRangeDist = lala.closeRangeDist,
        panicBase = lala.panicBase, panicSpeedMul = lala.panicSpeedMul,
            randMin = lala.randMin, randMax = lala.randMax,
        bvLen = lala.bvLen, bvThick = lala.bvThick,
            bvExtras = lala.bvExtras, bvRadar = lala.bvRadar,
        infinityAvoid = lala.infinityAvoid,
        singularityDetect = lala.singularityDetect,
        apWalk = lala.apWalk, apJump = lala.apJump, apAim = lala.apAim,
        autoplay = lala.autoplay,
        keyG = lala.keyG or 0,
        keyT = lala.keyT or 0,
        keySmart = lala.keySmart or 0,
        keyPanic = lala.keyPanic or 0,
        apColor = lala.apColor, apThick = lala.apThick, apTrans = lala.apTrans,
        pdColor = lala.pdColor, pdThick = lala.pdThick, pdTrans = lala.pdTrans,
        bvColor = lala.bvColor, bvEnd = lala.bvEnd,
    }
end

local function saveConfig()
    pcall(function()
        writefile(CFG_FILE, hs:JSONEncode(buildSaveData()))
    end)
end

local function applyConfig(data)
    if type(data) ~= "table" then return end
        if data.keyP ~= nil then lala.keyP = data.keyP == 0 and nil or data.keyP end
        if data.keyV ~= nil then lala.keyV = data.keyV == 0 and nil or data.keyV end
        if data.keyC ~= nil then lala.keyC = data.keyC == 0 and nil or data.keyC end
        if data.keyX ~= nil then lala.keyX = data.keyX == 0 and nil or data.keyX end
        if data.keyL ~= nil then lala.keyL = data.keyL == 0 and nil or data.keyL end
        if data.keyB ~= nil then lala.keyB = data.keyB == 0 and nil or data.keyB end
        if data.keyR ~= nil then lala.keyR = data.keyR == 0 and nil or data.keyR end
        if type(data.accuracy) == "number" then lala.accuracy = math.clamp(data.accuracy, 1, 100) end
        if type(data.randomize) == "boolean" then lala.randomize = data.randomize end
        if type(data.accHead) == "boolean" then lala.accHead = data.accHead end
        if type(data.keybindsHud) == "boolean" then lala.keybindsHud = data.keybindsHud end
        if type(data.minDist) == "number" then lala.minDist = math.clamp(data.minDist, 1, 100) end
        if type(data.maxDist) == "number" then lala.maxDist = math.clamp(data.maxDist, 50, 2000) end
        if type(data.panicBase) == "number" then lala.panicBase = math.clamp(data.panicBase, 5, 100) end
        if type(data.panicSpeedMul) == "number" then lala.panicSpeedMul = math.clamp(data.panicSpeedMul, 0.001, 0.2) end
        if type(data.randMin) == "number" then lala.randMin = math.clamp(data.randMin, 1, 99) end
        if type(data.randMax) == "number" then lala.randMax = math.clamp(data.randMax, 2, 100) end
        if type(data.bvLen) == "number" then lala.bvLen = math.clamp(data.bvLen, 20, 100) end
        if type(data.bvThick) == "number" then lala.bvThick = math.clamp(data.bvThick, 1, 14) end
        if type(data.bvDist) == "boolean" then lala.bvDist = data.bvDist end
        if type(data.bvSpeed) == "boolean" then lala.bvSpeed = data.bvSpeed end
        if type(data.bvTarget) == "boolean" then lala.bvTarget = data.bvTarget end
        if type(data.bvExtras) == "boolean" then lala.bvExtras = data.bvExtras end
        if type(data.bvRadar) == "boolean" then lala.bvRadar = data.bvRadar end
        if type(data.infinityAvoid) == "boolean" then lala.infinityAvoid = data.infinityAvoid end
        if type(data.singularityDetect) == "boolean" then lala.singularityDetect = data.singularityDetect end
        if type(data.apWalk) == "boolean" then lala.apWalk = data.apWalk end
        if type(data.apJump) == "boolean" then lala.apJump = data.apJump end
        if type(data.apAim) == "boolean" then lala.apAim = data.apAim end
        if type(data.v2) == "boolean" then lala.v2 = data.v2 end
        if type(data.showVis) == "boolean" then lala.showVis = data.showVis end
        if type(data.dome) == "boolean" then lala.dome = data.dome end
        if type(data.cone) == "boolean" then lala.cone = data.cone end
        if type(data.clash) == "boolean" then lala.clash = data.clash end
        if type(data.hudEnabled) == "boolean" then lala.hudEnabled = data.hudEnabled end
        if type(data.apColor) == "table" then
            lala.apColor.r = tonumber(data.apColor.r) or 0
            lala.apColor.g = tonumber(data.apColor.g) or 255
            lala.apColor.b = tonumber(data.apColor.b) or 120
        end
        if type(data.apThick) == "number" then lala.apThick = math.clamp(data.apThick, 1, 8) end
        if type(data.apTrans) == "number" then lala.apTrans = math.clamp(data.apTrans, 0, 100) end
        if type(data.pdColor) == "table" then
            lala.pdColor.r = tonumber(data.pdColor.r) or 255
            lala.pdColor.g = tonumber(data.pdColor.g) or 0
            lala.pdColor.b = tonumber(data.pdColor.b) or 0
        end
        if type(data.pdThick) == "number" then lala.pdThick = math.clamp(data.pdThick, 1, 8) end
        if type(data.pdTrans) == "number" then lala.pdTrans = math.clamp(data.pdTrans, 0, 100) end
        if type(data.bvColor) == "table" and type(data.bvColor.r) == "number" then lala.bvColor = { r = data.bvColor.r, g = data.bvColor.g or 255, b = data.bvColor.b or 0 } end
        if type(data.bvEnd) == "table" and type(data.bvEnd.r) == "number" then lala.bvEnd = { r = data.bvEnd.r, g = data.bvEnd.g or 0, b = data.bvEnd.b or 0 } end
        if type(data.remyHasMouse) == "boolean" then remyHasMouse = data.remyHasMouse end
        if type(data.remyCodes) == "table" then
            local good = true
            for _, c in ipairs(data.remyCodes) do if type(c) ~= "number" then good = false break end end
            if good then remyCodes = data.remyCodes end
        elseif remyHasMouse then
            remyCodes = {}
        end
        if type(data.remyLabel) == "string" then remyLabel = data.remyLabel end
        if type(data.abilityEsp) == "boolean" then lala.abilityEsp = data.abilityEsp end
        if type(data.abilityParry) == "boolean" then lala.abilityParry = data.abilityParry end
        if type(data.smartParry) == "boolean" then lala.smartParry = data.smartParry end
        if type(data.panicParry) == "boolean" then lala.panicParry = data.panicParry end
        if type(data.trainingBall) == "boolean" then lala.trainingBall = data.trainingBall end
        if type(data.customLeadMode) == "boolean" then lala.customLeadMode = data.customLeadMode end
        if type(data.customLeadValue) == "number" then lala.customLeadValue = data.customLeadValue end
        if data.keyN ~= nil then lala.keyN = data.keyN == 0 and nil or data.keyN end
        if data.keyG ~= nil then lala.keyG = data.keyG == 0 and nil or data.keyG end
        if type(data.customFacingMinMode) == "boolean" then lala.customFacingMinMode = data.customFacingMinMode end
        if type(data.customFacingMinValue) == "number" then lala.customFacingMinValue = math.clamp(data.customFacingMinValue, -1, 1) end
        if type(data.autoplay) == "boolean" then lala.autoplay = data.autoplay end
        if type(data.triggerbot) == "boolean" then lala.triggerbot = data.triggerbot end
        if type(data.triggerOnce) == "boolean" then lala.triggerOnce = data.triggerOnce end
        if data.keyT ~= nil then lala.keyT = data.keyT == 0 and nil or data.keyT end
        if data.keySmart ~= nil then lala.keySmart = data.keySmart == 0 and nil or data.keySmart end
        if data.keyPanic ~= nil then lala.keyPanic = data.keyPanic == 0 and nil or data.keyPanic end
end

local function loadConfig()
    pcall(function()
        if not isfile(CFG_FILE) then return end
        local okd, dd = pcall(hs.JSONDecode, hs, readfile(CFG_FILE))
        if okd and type(dd) == "table" then applyConfig(dd) end
    end)
end
do
    local snap = {}
    for k, v in pairs(lala) do
        local tv = type(v)
        if tv == "number" or tv == "string" or tv == "boolean" then
            snap[k] = v
        elseif tv == "table" then
            local c = {}
            for k2, v2 in pairs(v) do
                if type(v2) == "number" or type(v2) == "string" or type(v2) == "boolean" then c[k2] = v2 end
            end
            snap[k] = c
        end
    end
    _G.remybbDefaults = snap
end
loadConfig()
_G.remybbSaveConfig = saveConfig
_G.remybbProfiles = {
    slots = { "1", "2", "3", "4", "5" },
    fileOf = function(slot) return "remybb_profile_" .. tostring(slot) .. ".json" end,
    save = function(slot)
        local ok = false
        pcall(function()
            writefile(_G.remybbProfiles.fileOf(slot), hs:JSONEncode(buildSaveData()))
            ok = true
        end)
        return ok
    end,
    load = function(slot)
        local applied = false
        pcall(function()
            local f = _G.remybbProfiles.fileOf(slot)
            if isfile(f) then
                local okd, dd = pcall(hs.JSONDecode, hs, readfile(f))
                if okd and type(dd) == "table" then
                    applyConfig(dd)
                    applied = true
                end
            end
        end)
        return applied
    end,
}
lala.abilityLockout = { "Singularity", "Slashes of Fury", "Infinity" }
lala.abilityKey = 81

local TOGGLE_NAMES = { "P", "V", "C", "X", "B", "L", "R", "N", "G" }
local TOGGLE_LINES = { 2, 3, 5, 4, 8, 13, 15, 14, 9 }
local function keyHeld(k)
    if not k then return false end
    return iskeypressed(k) and true or false
end
local function keyLabel(k)
    if not k then return "NONE" end
    if k >= 65 and k <= 90 then return string.char(k) end
    if k >= 48 and k <= 57 then return string.char(k) end
    return "K" .. tostring(k)
end
local REBIND_CANCEL = 36
local BANNED_KEYS = { 87, 65, 83, 68, 304 }
local function isBannedKey(code)
    for _, b in ipairs(BANNED_KEYS) do
        if b == code then return true end
    end
    return false
end
local function isParryKey(code)
    for _, c in ipairs(remyCodes) do
        if c == code then return true end
    end
    return false
end
local function otherToggleWith(code, excludeIdx)
    for i, nm in ipairs(TOGGLE_NAMES) do
        if i ~= excludeIdx and lala["key" .. nm] == code then return nm end
    end
    return nil
end
local function freeToggleKey(excludeIdx)
    for c = 65, 90 do
        if not isParryKey(c) and not isBannedKey(c) then
            local used = false
            for i, nm in ipairs(TOGGLE_NAMES) do
                if i ~= excludeIdx and lala["key" .. nm] == c then used = true break end
            end
            if not used then return c end
        end
    end
    return nil
end
local rebindIdx = nil
local rebindConn = nil
local rebindCooldown = 0
local function startRebind(i)
    if rebindConn then pcall(rebindConn.Disconnect, rebindConn) end
    rebindIdx = i
    rebindConn = uis.InputBegan:Connect(function(inp)
        if bob ~= _G.__apGen then return end
        local kc = inp and inp.KeyCode
        if kc and kc > 2 then
            if kc >= 97 and kc <= 122 then kc = kc - 32 end
            if kc == REBIND_CANCEL then
                rebindIdx = nil
                pcall(rebindConn.Disconnect, rebindConn)
                rebindConn = nil
                return
            end
            local name = TOGGLE_NAMES[rebindIdx]
            if isParryKey(kc) then
                return
            end
            if isBannedKey(kc) then
                return
            end
            local taken = otherToggleWith(kc, rebindIdx)
            if taken then
                return
            end
            lala["key" .. name] = kc
            saveConfig()
            rebindCooldown = tick() + 0.4
            rebindIdx = nil
            pcall(rebindConn.Disconnect, rebindConn)
            rebindConn = nil
        end
    end)
end

local function readText(obj)
    if not obj then return "" end
    local ok, v = pcall(function() return obj.Text end)
    if ok and type(v) == "string" then return v end
    return ""
end

local function refreshParryBindings()
    local codes = {}
    local hasMouse = false
    local acodes = {}
    pcall(function()
        local pg = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
        local st = pg and pg:FindFirstChild("Settings")
        local f1 = st and st:FindFirstChild("Frame")
        local f2 = f1 and f1:FindFirstChild("Frame")
        local function parseFrame(kb, out, withMouse)
            if not kb then return end
            for _, b in ipairs(kb:GetChildren()) do
                if b.ClassName == "ImageButton" and string.sub(b.Name, 1, 7) == "Keybind" then
                    local txt = string.upper(readText(b:FindFirstChild("TextBox")))
                    if txt:match("FAILED TO FETCH") or txt == "" then
                    elseif txt == "MOUSE 1" then
                        if withMouse then hasMouse = true end
                    else
                        local ch = txt:match("^%s*([A-Z0-9])")
                        if ch then
                            local code = string.byte(ch)
                            local dup = false
                            for _, c in ipairs(out) do if c == code then dup = true break end end
                            if not dup then out[#out + 1] = code end
                        end
                    end
                end
            end
        end
        parseFrame(f2 and f2:FindFirstChild("Keybinds/Block"), codes, true)
        parseFrame(f2 and f2:FindFirstChild("Keybinds/Ability"), acodes, false)
    end)
    if #acodes > 0 then abilityCodes = acodes end
    if #codes > 0 or hasMouse then
        remyCodes = codes
        remyHasMouse = hasMouse
    end
    if #remyCodes == 0 and not remyHasMouse then remyCodes = { 70 } end
    local lbl = {}
    for _, c in ipairs(remyCodes) do lbl[#lbl + 1] = string.char(c) end
    if remyHasMouse then lbl[#lbl + 1] = "M1" end
    remyLabel = table.concat(lbl, "/")
    lala.parryKeys = remyLabel
    if _G.__apParryLabel ~= remyLabel then
        _G.__apParryLabel = remyLabel
        saveConfig()
    end
    for i, nm in ipairs(TOGGLE_NAMES) do
        local tk = lala["key" .. nm]
        if isParryKey(tk) or isBannedKey(tk) then
            local free = freeToggleKey(i)
            if free then
                lala["key" .. nm] = free
                saveConfig()
            end
        end
    end
end

local function parryHeld()
    for _, c in ipairs(remyCodes) do
        if iskeypressed(c) then return true end
    end
    return false
end

local AP_ABILITIES = { ["Raging Deflection"] = true, ["Rapture"] = true }
local function getEquippedAbility()
    local n = lp:GetAttribute("CurrentlyEquippedAbility")
    if type(n) ~= "string" then return nil end
    return n
end
local function getAbilityLevel(name)
    local up = lp:FindFirstChild("Upgrades")
    local iv = up and up:FindFirstChild(name)
    if iv then return iv.Value or 0 end
    return 0
end
local function getAbilityCooldown(name)
    if name == "Raging Deflection" then
        local lvl = getAbilityLevel(name)
        if lvl >= 2 then return 22 end
        if lvl == 1 then return 27 end
        return 32
    end
    if name == "Rapture" then return 32 end
    return 0
end
local function abilityReady()
    if not lala.abilityParry then return false end
    if #abilityCodes == 0 then return false end
    local n = getEquippedAbility()
    if not n or not AP_ABILITIES[n] then return false end
    return tick() >= abilityReadyAt
end

local function pressParry()
    if abilityReady() then
        local n = getEquippedAbility()
        abilityReadyAt = tick() + getAbilityCooldown(n)
        local c = abilityCodes[1]
        pcall(realKeypress, c)
        return function() pcall(realKeyrelease, c) end
    end
    for _, c in ipairs(remyCodes) do
        pcall(realKeypress, c)
        return function() pcall(realKeyrelease, c) end
    end
    if remyHasMouse then
        ymerAutoT = tick()
        mouse1press()
        return function() mouse1release() end
    end
    pcall(realKeypress, 70)
    return function() pcall(realKeyrelease, 70) end
end

local nextParryRoll = nil
local function rollNextParry()
    if not lala.randomize then nextParryRoll = nil return lala.accuracy end
    local lo = math.min(tonumber(lala.randMin) or 20, tonumber(lala.randMax) or 100)
    local hi = math.max(lo + 1, tonumber(lala.randMax) or 100)
    local rolled = lo + math.random() * (hi - lo)
    nextParryRoll = rolled
    return rolled
end
local function nextParryAccuracy()
    if not lala.randomize then return lala.accuracy end
    if nextParryRoll == nil then rollNextParry() end
    return nextParryRoll or lala.accuracy
end
local function currentParryAcc()
    if not lala.randomize then return math.clamp(lala.accuracy or 100, 1, 100) end
    if nextParryRoll == nil then rollNextParry() end
    return nextParryRoll or 100
end
local function doHumanParry()
    nextParryRoll = nil
    pcall(function()
        local tb = lastScanState.tapBest
        local b = tb and tb.addr and workspace:FindFirstChild("Balls") and workspace.Balls:FindFirstChild(tostring(tb.addr))
        if not b then for _, v in ipairs(workspace:FindFirstChild("Balls"):GetChildren()) do if v.Address == tb.addr then b=v break end end end
        if b then pcall(function() b.AssemblyLinearVelocity = b.AssemblyLinearVelocity + Vector3.new(0,80,0) end) end
    end)
    local rel = pressParry()
    if rel then pcall(rel) end
end

do
    local fired = false
    task.spawn(function()
        while bob == _G.__apGen do
            if lala.triggerbot then
                pcall(function()
                    local balls = workspace:FindFirstChild("Balls")
                    if not balls then fired = false return end
                    local ch2 = lp.Character
                    if ch2 and ch2:FindFirstChild("SingularityCape") then fired = false return end
                    local myInf = false
                    pcall(function()
                        for _, b in ipairs(balls:GetChildren()) do
                            if (b:FindFirstChild("InfinityFX") or b:FindFirstChild("TrueInfinityFX")) and remy.recentlyTapped[b.Address or b.Name] and tick() - remy.recentlyTapped[b.Address or b.Name] < 2 then
                                myInf = true
                                break
                            end
                        end
                    end)
                    if myInf then fired = false return end
                    local me = lp.Name
                    local targeting = false
                    for _, b in ipairs(balls:GetChildren()) do
                        local tgt = b:GetAttribute("target")
                        if tgt and tostring(tgt) == me then
                            targeting = true
                            break
                        end
                    end
                    if targeting and not fired then
                        fired = true
                        doHumanParry()
                        if lala.triggerOnce then
                            lala.triggerbot = false
                            saveConfig()
                        end
                    elseif not targeting then
                        fired = false
                    end
                end)
            else
                fired = false
            end
            task.wait()
        end
    end)
end

refreshParryBindings()
task.spawn(function()
    task.wait(0.5)
    while bob == _G.__apGen do
        refreshParryBindings()
        task.wait(3)
    end
end)

local pingSec = 0.03
local pingEma = 0
local function pingSample()
    local ok, p = pcall(GetPingValue)
    if ok and type(p) == "number" and p > 0 then
        local s = math.min(p / 1000, lala.pingMax)
        if pingEma <= 0 then pingEma = s else pingEma = pingEma * 0.85 + s * 0.15 end
        pingSec = pingEma
    end
end
local function leadForPing(pingMs)
    local tiers = lala.pingTiers
    local leads = lala.pingLead
    for i = 1, #tiers do
        if pingMs <= tiers[i] then return leads[i] end
    end
    return leads[#leads]
end
local function getEffectiveLeadTime()
    if lala.customLeadMode then
        return lala.customLeadValue
    end
    return lala.pingComp and leadForPing(pingSec * 1000) or lala.leadTime
end
local function getEffectiveFacingMin()
    if lala.customFacingMinMode then
        return lala.customFacingMinValue
    end
    return lala.facingMin
end
pingSample()
local pingLoop = task.spawn(function()
    while bob == _G.__apGen do
        pingSample()
        task.wait(0.5)
    end
end)

local ymer = { active = false, speed = 0, lastSpeed = 0, leadDist = 21, ballPos = nil, centerPos = nil, headPos = nil, flash = 0, ballList = {} }
_G.__apState = ymer
local genPrev = {}
local genSeen = {}
local genRet = {}
local genLock = {}
local spdSm = {}
local clashSawMine = false
local clashLastMine = 0
local clashNoBallT = tick()
local clashPartner = nil
local genPrune = 0
local genHp = 0
local meId = tostring(lp and lp.UserId or 0)
local genWatch = {}
local recentlyPanic = {}
local ballParriedOnce = {}
local ballSpawnedAt = {}
local NEW_BALL_GRACE = 0.5
local lastSingularityRelease = 0
local singularityTracking = {}
local visSm = {}
local lastMineT = 0
local aeroStates = {}
local InfinityDetection = {
    Enabled = true,
    Active = false
}
do
local function IsInstance(Object)
    return Object ~= nil and type(Object) == "userdata"
end
function InfinityDetection:IsActive()
    local Runtime = workspace:FindFirstChild("Runtime")
    if IsInstance(Runtime) then
        if Runtime:FindFirstChild("InfinityFX") or Runtime:FindFirstChild("TrueInfinityFX") then
            return true
        end
    end
    local Balls = workspace:FindFirstChild("Balls")
    if IsInstance(Balls) then
        for _, Ball in ipairs(Balls:GetChildren()) do
            if IsInstance(Ball) and (Ball.ClassName == "Part" or Ball.ClassName == "MeshPart") then
                local Body = Ball:FindFirstChild("Body")
                if IsInstance(Body) and Body:FindFirstChild("WEMAZOOKIEGO") then
                    return true
                end
            end
        end
    end
    local Character = lp and lp.Character
    if IsInstance(Character) and Character:FindFirstChild("Parry") then
        return true
    end
    return false
end
function InfinityDetection:Update()
    if not self.Enabled or not lala.infinityAvoid then
        self.Active = false
        return false
    end
    self.Active = self:IsActive()
    return self.Active
end
end
local PANIC_GRACE = 0.5
_G.__apStats = _G.__apStats or { taps = 0, parries = 0, misses = 0, hits = 0 }
local stats = _G.__apStats
stats.hits = stats.hits or 0
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude

local function getBallMotion(b, now, dt, pos)
    local a = b.Address or b.Name
    local e = genPrev[a]
    local accel = 0
    local curve = 0
    local dpos, dT
    if e then
        local ref = e.p2 and { p = e.p2, t = e.t2 } or { p = e.p1, t = e.t1 }
        dpos = pos - ref.p
        dT = now - ref.t
        e.p2, e.t2, e.p1, e.t1 = e.p1, e.t1, pos, now
    else
        genPrev[a] = { p1 = pos, t1 = now }
    end
    local bestV, bestSpeed = nil, 0
    if dpos and dT and dT > 0.0001 then
        local v = dpos / dT
        local s = v.Magnitude
        if s > bestSpeed then bestV, bestSpeed = v, s end
        if e.p1 then
            local dT1 = now - e.t1
            if dT1 > 0.0001 then
                local v1 = (pos - e.p1) / dT1
                local s1 = v1.Magnitude
                if s1 > bestSpeed then bestV, bestSpeed = v1, s1 end
            end
        end
        if e.sv then
            accel = math.min((v - e.sv).Magnitude / dT, 1500)
            local dUnit = v.Unit
            local pUnit = e.sv.Unit
            local dot = math.clamp(dUnit:Dot(pUnit), -1, 1)
            local angle = math.acos(dot)
            local rawCurve = angle / math.pi
            e.curve = (e.curve or 0) * 0.4 + rawCurve * 0.6
            curve = e.curve
        end
        if e.p1 and e.sv then
            local dtPred = now - e.t1
            local predicted = e.p1 + e.sv * dtPred
            local deviation = (pos - predicted).Magnitude
            local devCurve = math.clamp(deviation / 3, 0, 1)
            curve = math.max(curve, devCurve)
        end
        e.sv = v
    end
    if bestSpeed <= 8 then
        local rep = b.AssemblyLinearVelocity
        if rep then
            local rs = rep.Magnitude
            if rs > 5 and rs > bestSpeed then bestV, bestSpeed = rep, rs end
        end
        if bestSpeed <= 8 then
            local rep2 = b.Velocity
            if rep2 then
                local rs2 = rep2.Magnitude
                if rs2 > 5 and rs2 > bestSpeed then bestV, bestSpeed = rep2, rs2 end
            end
        end
    end
    if bestV and bestSpeed > 8 then
        local turn = nil
        if e and e.p1 and e.sv then
            local dtPred = now - e.t1
            if dtPred > 0.0001 then
                local dev = pos - (e.p1 + e.sv * dtPred)
                local par = dev:Dot(bestV.Unit)
                local lat = dev - bestV.Unit * par
                if lat.Magnitude > 0.1 then turn = lat.Unit end
            end
        end
        return bestV.Unit, math.min(bestSpeed, lala.maxSpeed), a, accel, curve, turn
    end
    return nil, 0, a, 0, curve, nil
end

if _G.__apConn then pcall(_G.__apConn.Disconnect, _G.__apConn) end
_G.__apConn = nil
if _G.__apHB then pcall(_G.__apHB.Disconnect, _G.__apHB) end
_G.__apHB = nil
if _G.__apRS then pcall(_G.__apRS.Disconnect, _G.__apRS) end
_G.__apRS = nil
if _G.__apCleanup then pcall(_G.__apCleanup) end
_G.__apCleanup = nil
if _G.__apPool then
    local old = _G.__apPool
    for i = 1, #old do
        local e = old[i]
        if e and e.seg then
            for s = 1, #e.seg do
                local l = e.seg[s]
                if l and l.Remove then pcall(l.Remove, l) end
            end
        end
    end
    _G.__apPool = nil
end

local mouseBlocked = false
local function mousePos()
    local mo = lp:GetMouse()
    if not mo then return 0, 0 end
    return mo.X or 0, mo.Y or 0
end
local hudHitAt

local clashGate = { ok = false, clos = 0, tgt = "", me = "" }
local lastScanState = {}

local scan
scan = function(dt)
    if bob ~= _G.__apGen then return end
    local v2on = lala.v2 and true or false
    local char = lp.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local me = char and char.Name or ""
    local balls = workspace:FindFirstChild("Balls")
    local ballKids = balls and balls:GetChildren() or {}
    if lala.trainingBall then
        local tb = workspace:FindFirstChild("TrainingBalls") or workspace:FindFirstChild("TrainingBall") or workspace:FindFirstChild("Training")
        if tb then for _, v in ipairs(tb:GetChildren()) do ballKids[#ballKids+1]=v end end
    end
    local now = tick()
    local leadTime = getEffectiveLeadTime()
    ymer.lead = leadTime
    local m1Now = ismouse1pressed()
    local fDown = parryHeld()
    if remyHasMouse and m1Now and not lalaPrev and not mouseBlocked and lala.hudEnabled then
        local mx, my = mousePos()
        if hudHitAt(mx, my) then
            mouseBlocked = true
            pcall(setrobloxinput, "BlockUserInput", true)
        else
            fDown = true
        end
    end
    lalaPrev = m1Now
    if fDown and not remy.tapping and now - remy.lastTap > 0.1 then
        _G.__apUserF = now
    end
    local uf = _G.__apUserF
    local abilityActive = false
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local isIdle = not hum or hum.Health <= 0 or #ballKids == 0
    if (not hum or hum.Health <= 0) and not ymer.idle then
        abilityReadyAt = 0
    end
    ymer.idle = isIdle
    if isIdle then
        ymer.ballList = {}
        ymer.active = false
        ymer.speed = 0
        ymer.leadDist = 0
        ymer.ballPos = nil
        ymer.impDist = nil
        ymer.bAddr = nil
        return
    end
    if root then
        local p = root.Position
        abilityActive = lala.singularityDetect ~= false and root:FindFirstChild("SingularityCape") ~= nil
        ymer.abilityActive = abilityActive
        rayParams.FilterDescendantsInstances = { char }
        local hit = workspace:Raycast(p + Vector3.new(0, 2, 0), Vector3.new(0, -200, 0), rayParams)
        local floorY = hit and hit.Position.Y or (p.Y - 3)
        ymer.centerPos = Vector3.new(p.X, floorY + 0.1, p.Z)
        ymer.headPos = Vector3.new(p.X, p.Y + 3, p.Z)
        local hum = char:FindFirstChildOfClass("Humanoid")
        genHp = hum and hum.Health or genHp
    else
        ymer.centerPos = nil
        ymer.headPos = nil
    end
    if now - genPrune > 1 then
        genPrune = now
        for k in pairs(remy.recentlyTapped) do
            if now - remy.recentlyTapped[k] > 2 then remy.recentlyTapped[k] = nil end
        end
        for k, w in pairs(genWatch) do
            if now - w.t > 4 then genWatch[k] = nil end
        end
        for k, v in pairs(recentlyPanic) do
            if now - v > PANIC_GRACE + 0.5 then recentlyPanic[k] = nil end
        end
    end
    local vis = {}
    local best, genScore, bestVi = nil, 0, nil
    local rBest, genTime, rBestVi = nil, math.huge, nil
    local nBest, nBestDist = nil, math.huge
    local nearestMine, nearestMineDist = nil, math.huge
    local wasTargeted = false
    local maxTrack = 0
    local seen = {}
    local realClos = nil
    local realTgt = ""
    local singularityReleased = false
    if lala.singularityDetect == false then
        lastSingularityRelease = -1e18
    else
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lp then
                local ch = plr.Character
                local hadCape = singularityTracking[plr.UserId]
                local hasCape = ch and ch:FindFirstChild("SingularityCape") ~= nil
                if hadCape and not hasCape then
                    lastSingularityRelease = now
                    singularityReleased = true
                end
                singularityTracking[plr.UserId] = hasCape
            end
        end
    end
    if root and balls then
        local rootPos = root.Position
        local infActive = false
        pcall(function() infActive = InfinityDetection:Update() end)
        local infBallDist = nil
        local aeroAny = false
        local needVis = lala.bvExtras ~= false or lala.showVis or lala.clash
        for _, b in ipairs(ballKids) do
            local a = b.Address or b.Name
            seen[a] = true
            local pos = b.Position
            if pos then
                local dir, speed, a2, accel, curve, turn = getBallMotion(b, now, dt, pos)
                local dposRoot = rootPos - pos
                local dist = dposRoot.Magnitude
                local closing = 0
                if dir and dist > 0.5 then
                    closing = dir:Dot(dposRoot / dist)
                    if speed > 1 then
                        if not genSeen[a2] then ballSpawnedAt[a2] = now end
                        genSeen[a2] = (genSeen[a2] or 0) + 1
                    end
                end
                local tgt = b:GetAttribute("target")
                local realBall = b:GetAttribute("realBall")
                if b:FindFirstChild("AeroDynamicSlashVFX") then
                    local st = aeroStates[a2]
                    if not st then
                        st = { t = now }
                        aeroStates[a2] = st
                    end
                    local vs = dir and dir.Y or 0
                    if (now - st.t) < 0.2 or vs > 10 then
                        aeroAny = true
                    end
                else
                    aeroStates[a2] = nil
                end
                local tgtPos = nil
                if needVis and tgt then
                    local tp = Players:FindFirstChild(tostring(tgt))
                    if not tp then
                        for _, pl in ipairs(Players:GetPlayers()) do
                            if tostring(pl.UserId) == tostring(tgt) then tp = pl break end
                        end
                    end
                    local ch = tp and tp.Character
                    local rp = ch and ch:FindFirstChild("HumanoidRootPart")
                    if rp then tgtPos = rp.Position end
                end
                local vi = needVis and 0 or nil
                if needVis and realBall ~= false then
                    local sm = visSm[a2]
                    local sk = 0.3
                    if sm then
                if dir then
                            sm.dir = sm.dir and sm.dir:Lerp(dir, sk) or dir
                        end
                        if turn then
                            sm.turn = sm.turn and sm.turn:Lerp(turn, sk) or turn
                        end
                        sm.curve = sm.curve + ((curve or 0) - sm.curve) * sk
                        sm.speed = sm.speed + ((speed or 0) - sm.speed) * sk
                    else
                        sm = { dir = dir, turn = turn, curve = curve or 0, speed = speed or 0 }
                        visSm[a2] = sm
                    end
                    if tgtPos then
                        sm.tgtPos = sm.tgtPos and sm.tgtPos:Lerp(tgtPos, sk) or tgtPos
                    end
                    vis[#vis + 1] = { pos = pos, dist = dist, speed = sm.speed or speed, addr = a2, closing = closing, best = false, dir = sm.dir or dir, curve = sm.curve or 0, turn = sm.turn, tgtPos = sm.tgtPos }
                    vi = #vis
                end
                clashNoBallT = now
                local isMine = (tgt == me or tgt == meId)
                local isInfBall = isMine and (
                    b:FindFirstChild("WEMAZOOKIEGO") ~= nil
                    or b:FindFirstChild("InfinityFX") ~= nil
                    or (b:FindFirstChild("Body") and b.Body:FindFirstChild("WEMAZOOKIEGO") ~= nil)
                )
                if isInfBall and (infBallDist == nil or dist < infBallDist) then
                    infBallDist = dist
                end
                if isMine then wasTargeted = true end
                if not isMine then
                    ballParriedOnce[a2] = nil
                end
                if not isMine and abilityActive then
                    local equipped = lp:GetAttribute("CurrentlyEquippedAbility") or ""
                    if equipped == "Slashes of Fury" then
                        abilityActive = false
                        ymer.abilityActive = false
                    end
                end
                if realBall then
                    local tgtStr = tostring(tgt or "")
                    realClos = closing
                    realTgt = tgtStr
                    if isMine then
                        clashSawMine = true
                        clashLastMine = now
                        lastMineT = now
                    elseif lala.clash then
                        if clashSawMine and now - clashLastMine > 1.2 then
                            lala.clash = false
                            ymer.clash = false
                            clashSawMine = false
                            clashPartner = nil
                        elseif tgtStr ~= "" then
                            if clashPartner == nil then
                                clashPartner = tgtStr
                            elseif tgtStr ~= clashPartner then
                                lala.clash = false
                                ymer.clash = false
                                clashSawMine = false
                                clashPartner = nil
                            end
                        end
                    end
                end
                if closing < -0.3 then
                    genRet[a2] = (genRet[a2] or 0) + 1
                else
                    genRet[a2] = 0
                end
                local eng = genLock[a2]
                if eng then
                    local lockTime = 0.6
                    local dynamicPanicLock = lala.panicBase + speed * lala.panicSpeedMul
                    local wasRecentPanicLock = recentlyPanic[a2] and (now - recentlyPanic[a2] < PANIC_GRACE)
                    if dist <= lala.closeRangeDist or (dist < dynamicPanicLock and speed > 30) or wasRecentPanicLock then
                        lockTime = 0.08
                    end
                    if now - eng > lockTime then
                        genLock[a2] = nil
                    end
                end
                local w = genWatch[a2]
                if w then
                    if genHp < (w.hp or 0) - 1 then
                        stats.hits = stats.hits + 1
                        genWatch[a2] = nil
                    elseif closing < -0.3 then
                        w.re = (w.re or 0) + 1
                        if w.re >= 2 then
                            stats.parries = stats.parries + 1
                            genWatch[a2] = nil
                        end
                    elseif now - w.t > 2.5 then
                        stats.misses = stats.misses + 1
                        genWatch[a2] = nil
                    end
                end
                local sm = speed
                if speed > 1 then
                    local o = spdSm[a2]
                    if o then
                        local blend = speed > o and 0.4 or 0.05
                        sm = o + (speed - o) * blend
                    end
                    spdSm[a2] = sm
                end
                local isDeco = realBall == false
                local mine = (not isDeco and isMine) and not infActive and not aeroAny
                if mine and dist > 0.5 and dist < nearestMineDist then
                    nearestMineDist = dist
                    nearestMine = { dist = dist, speed = sm, pos = pos, addr = a2, closing = closing, accel = accel, curve = curve }
                end
                if not isDeco and dist > 0.5 then
                    if dist < nBestDist then
                        nBestDist = dist
                        nBest = { dist = dist, speed = sm, pos = pos, addr = a2, closing = closing, accel = accel, curve = curve }
                    end
                end
                local closingMin = dist < lala.closeRangeDist and -0.1 or 0.15
                local hasMotion = dir and speed > 1
                local dynamicPanic = lala.panicBase + sm * lala.panicSpeedMul
                local isPanicClose = mine and dist < dynamicPanic and not isDeco
                if isPanicClose or (mine and dist > 0.5) then
                    local useSpeed = hasMotion and sm or 50
                    if useSpeed > maxTrack then maxTrack = useSpeed end
                    local score = hasMotion and (closing * sm / dist) or (100 / dist)
                    if score > genScore then
                        genScore = score
                        best = { dist = dist, speed = useSpeed, pos = pos, addr = a2, closing = closing or 1, accel = accel, curve = curve }
                        bestVi = vi
                    end
                    local isFast = useSpeed >= lala.fastBallThreshold
                    local isClose = dist <= lala.closeRangeDist
                    local isAccel = accel > 200
                    local adjustedLead = leadTime
                    if isFast then adjustedLead = adjustedLead * 1.05 end
                    if isClose then adjustedLead = adjustedLead * 1.1 end
                    if isAccel then adjustedLead = adjustedLead * 1.15 end
                    local curveFactor = 1 - (curve or 0) * 0.75
                    adjustedLead = adjustedLead * math.clamp(curveFactor, 0.25, 1)
                    local leadNow = math.clamp(useSpeed * adjustedLead, lala.minDist, lala.maxDist)
                    if isClose then leadNow = math.max(leadNow, lala.closeRangeDist) end
                    if isFast and isClose then leadNow = math.max(leadNow, 30) end
                    if isPanicClose then leadNow = math.max(leadNow, 35) end
                    local dynamicPanic2 = lala.panicBase + useSpeed * lala.panicSpeedMul
                    if dist <= leadNow or dist < dynamicPanic2 then
                        local impact = isPanicClose and 0 or (dist / math.max(closing * sm, 1))
                        if impact < genTime then
                            genTime = impact
                            rBest = { dist = dist, speed = useSpeed, pos = pos, addr = a2, closing = closing or 1, accel = accel, fast = isFast, close = isClose, highAccel = isAccel, curve = curve }
                            rBestVi = vi
                        end
                    end
                end
            end
        end
        for k in pairs(genPrev) do
            if not seen[k] then
                genPrev[k] = nil
                genSeen[k] = nil
                genRet[k] = nil
                genLock[k] = nil
                spdSm[k] = nil
                visSm[k] = nil
                ballParriedOnce[k] = nil
                ballSpawnedAt[k] = nil
                aeroStates[k] = nil
            end
        end
        if lala.clash and now - clashNoBallT > 5 then
            lala.clash = false
            ymer.clash = false
            clashSawMine = false
            clashPartner = nil
        end
    elseif lala.clash and now - clashNoBallT > 5 then
        lala.clash = false
        ymer.clash = false
        clashSawMine = false
        clashPartner = nil
    end
    if rBest and rBestVi and vis[rBestVi] then vis[rBestVi].best = true elseif best and bestVi and vis[bestVi] then vis[bestVi].best = true end
    ymer.ballList = vis
    local tapBest = rBest or best
    if nearestMine and (not tapBest or nearestMine.dist < tapBest.dist) and nearestMine.dist <= lala.maxDist then
        tapBest = nearestMine
    end
    local trackSpeed = 0
    if tapBest then
        trackSpeed = tapBest.speed
    elseif nBest then
        trackSpeed = nBest.speed
    elseif maxTrack > 0 then
        trackSpeed = maxTrack
    end
    local lead = math.clamp(
        tapBest and tapBest.speed * leadTime
            or nBest and nBest.speed * leadTime
            or maxTrack * leadTime,
        lala.minDist, lala.maxDist)
    if tapBest and tapBest.curve and tapBest.curve > 0.05 then
        local cf = 1 - tapBest.curve * 0.75
        lead = lead * math.clamp(cf, 0.25, 1)
    end
    lead = math.clamp(lead, lala.minDist, lala.maxDist)
    ymer.active = trackSpeed > 0
    ymer.speed = trackSpeed
    ymer.lastSpeed = trackSpeed
    ymer.leadDist = lead
    ymer.ping = math.floor(pingSec * 1000)
    ymer.clash = lala.clash or false
    local t2 = tick()
    if v2on and (realTgt == me or realTgt == meId) and (t2 - lastSingularityRelease) < 1.5 and not remy.tapping and t2 - remy.lastTap > 0.001 then
        remy.lastTap = t2
        ymer.flash = t2
        if tapBest then
            genLock[tapBest.addr] = t2
            ballParriedOnce[tapBest.addr] = t2
        end
        stats.taps = stats.taps + 1
        local rel = pressParry()
        if rel then pcall(rel) end
    end
    if v2on and tapBest and infBallDist and infBallDist <= 36 and (realTgt == me or realTgt == meId) and not ballParriedOnce[tapBest.addr] and (now - (ballSpawnedAt[tapBest.addr] or 0)) >= NEW_BALL_GRACE and not remy.tapping and t2 - remy.lastTap > 0.001 then
        remy.lastTap = t2
        ymer.flash = t2
        genLock[tapBest.addr] = t2
        ballParriedOnce[tapBest.addr] = t2
        stats.taps = stats.taps + 1
        local rel = pressParry()
        if rel then pcall(rel) end
    end
    if lala.clash then
        local cBest = nil
        for _, v in ipairs(vis) do
            if not cBest or v.dist < cBest.dist then cBest = v end
        end
        if cBest then
            ymer.ballPos = cBest.pos
            ymer.impDist = cBest.dist
            ymer.bAddr = cBest.addr
        end
        clashGate.clos = realClos or 0
        clashGate.tgt = realTgt
        clashGate.me = me
        if clashGate.lastTgt ~= realTgt then
            clashGate.lastTgt = realTgt
            clashGate.tgtSince = tick()
        end
        clashGate.ok = (realClos ~= nil and realClos > 0.05)
            and (realTgt == me or realTgt == meId or realTgt == clashPartner)
    else
        clashGate.ok = false
    end
    if tapBest then
        ymer.ballPos = tapBest.pos
        ymer.impDist = tapBest.dist
        ymer.bAddr = tapBest.addr
        local readyLead = lead
        local parryAcc = currentParryAcc()
        local curving = (tapBest.closing or 0) <= getEffectiveFacingMin()
        if parryAcc >= 90 then
            if not curving then
                if parryAcc >= 100 then
                    readyLead = lead * 1.08 + 1
                elseif parryAcc >= 95 then
                    readyLead = lead * (0.58 + (parryAcc / 100) * 0.5)
                else
                    readyLead = lead * (0.55 + (parryAcc / 100) * 0.5)
                end
            end
        elseif parryAcc >= 50 and parryAcc < 80 then
            readyLead = lead * (0.5 + (parryAcc / 100) * 0.57)
        elseif parryAcc >= 80 and parryAcc < 90 then
            readyLead = lead * (0.55 + (parryAcc / 100) * 0.48)
        else
            readyLead = lead * (0.45 + (parryAcc / 100) * 0.55)
        end
        local minLead = math.max(lala.closeRangeDist, lala.panicBase + tapBest.speed * lala.panicSpeedMul * 0.5) * 0.85
        if readyLead < minLead then readyLead = minLead end
        if lala.smartParry then
            if lala.randomize then lala.randomize = false end
            local smartAcc = math.clamp(20 + tapBest.speed * 0.04, 20, 35)
            ymer.smartAcc = smartAcc
            ymer.parryDist = nil
            local smartLead = lead * (0.45 + (smartAcc / 100) * 0.65)
            if tapBest.dist > smartLead then
                -- outside smart window
            else
                local curvingSmart = (tapBest.closing or 0) <= getEffectiveFacingMin()
                local isMyAbility = abilityActive
                local isMyInfinity = false
                pcall(function()
                    if tapBest.addr and remy.recentlyTapped[tapBest.addr] and tick() - remy.recentlyTapped[tapBest.addr] < 2 then
                        local b = workspace:FindFirstChild("Balls") and workspace.Balls:FindFirstChild(tapBest.addr)
                        if b and (b:FindFirstChild("InfinityFX") or b:FindFirstChild("TrueInfinityFX")) then
                            isMyInfinity = true
                        end
                    end
                end)
                if isMyAbility or isMyInfinity then
                elseif not curvingSmart and not genLock[tapBest.addr] and not ballParriedOnce[tapBest.addr] and (now - (ballSpawnedAt[tapBest.addr] or 0)) >= NEW_BALL_GRACE then
                    if t2 - remy.lastTap > lala.cooldown then
                        remy.lastTap = t2
                        ymer.flash = t2
                        genLock[tapBest.addr] = t2
                        ballParriedOnce[tapBest.addr] = t2
                        stats.taps = stats.taps + 1
                        doHumanParry()
                    end
                end
            end
            -- when smart parry on it skips normal/panic/visuals entirely PLEASeworkd dfcwsaglfjvkmawgn
        else
            ymer.smartAcc = nil
            ymer.parryDist = readyLead
            local ready = (tapBest.dist <= readyLead)
        local dynamicPanic3 = lala.panicBase + tapBest.speed * lala.panicSpeedMul
        local isPanic = tapBest.dist < dynamicPanic3 and tapBest.dist <= lead
        local isFastBall = tapBest.speed >= lala.fastBallThreshold
        local isCloseRange = tapBest.dist <= lala.closeRangeDist
        local isHighAccel = tapBest.highAccel or false
        local threshold = 0
        local readyToParry = v2on and ready and ((genSeen[tapBest.addr] or 0) >= threshold
            and not genLock[tapBest.addr] and not abilityActive
            and not ballParriedOnce[tapBest.addr]
            and (tapBest.closing or 0) > getEffectiveFacingMin()
            and (now - (ballSpawnedAt[tapBest.addr] or 0)) >= NEW_BALL_GRACE)
        if readyToParry then
            local w0 = genWatch[tapBest.addr]
            local speedCooldown = lala.cooldown
            local isFastTrigger = tapBest.speed >= lala.fastBallThreshold
            local isCloseTrigger = tapBest.dist <= lala.closeRangeDist
            local dynamicPanic4 = lala.panicBase + tapBest.speed * lala.panicSpeedMul
            local isPanicTrigger = lala.panicParry ~= false and tapBest.dist < dynamicPanic4 and tapBest.speed > 60
            if isPanicTrigger then recentlyPanic[tapBest.addr] = t2 end
            local wasRecentPanic = recentlyPanic[tapBest.addr] and (t2 - recentlyPanic[tapBest.addr] < PANIC_GRACE)
            local curvingPanic = (tapBest.closing or 0) <= getEffectiveFacingMin()
            if lala.panicParry ~= false and not curvingPanic and (isCloseTrigger or isPanicTrigger or wasRecentPanic) then
                speedCooldown = 0.001
            end
            if t2 - remy.lastTap > speedCooldown then
                remy.lastTap = t2
                ymer.flash = t2
                remy.recentlyTapped[tapBest.addr] = t2
                genLock[tapBest.addr] = t2
                ballParriedOnce[tapBest.addr] = t2
                if w0 then
                    w0.t = t2
                    w0.ntap = (w0.ntap or 0) + 1
                    w0.spd = tapBest.speed
                    w0.dist = tapBest.dist
                else
                    genWatch[tapBest.addr] = { t = t2, hp = genHp, spd = tapBest.speed, dist = tapBest.dist, ntap = 1 }
                end
                stats.taps = stats.taps + 1
                doHumanParry()
            end
        end
        end
    else
        if nBest then
            ymer.ballPos = nBest.pos
            ymer.impDist = nBest.dist
            ymer.bAddr = nBest.addr
        else
            ymer.ballPos = nil
            ymer.impDist = nil
            ymer.bAddr = nil
        end
    end
    lastScanState.tapBest = tapBest
    lastScanState.abilityActive = abilityActive
    lastScanState.lead = lead
    lastScanState.parryDist = ymer.parryDist or lead
    lastScanState.now = t2
end
_G.__apHB = RunService.Heartbeat:Connect(function(dt)
    local okS, errS = pcall(scan, dt)
    if not okS then _G.__scanErr = tostring(errS) end
end)
local clashRunning = true
local clashLoop
clashLoop = task.spawn(function()
    while clashRunning do
        if bob == _G.__apGen and lala.v2 and not ymer.idle and lala.clash and clashGate.ok then
            local c = tick()
            local tgtStable = clashGate.tgtSince and (c - clashGate.tgtSince > 0.05)
            if tgtStable and c - remy.lastTap > 0.001 and not remy.tapping then
                local uf = _G.__apUserF
                if uf == 0 or c - uf > lala.userSuppress then
                    remy.lastTap = c
                    ymer.flash = c
                    stats.taps = stats.taps + 1
                    remy.tapping = true
                    local rel = pressParry()
                    task.spawn(function()
                        task.wait(0.00001)
                        if rel then pcall(rel) end
                        remy.tapping = false
                    end)
                end
            end
        end
        task.wait(lala.clash and 0.00001 or 0.05)
    end
end)
_G.__apClashLoop = clashLoop

local panicRunning = true
local panicParryAt = 0
local panicReason = ""
local panicLoop
panicLoop = task.spawn(function()
    while panicRunning do
        if bob == _G.__apGen and lala.v2 and not ymer.idle and not lala.clash then
            local st = lastScanState
            local tb = st.tapBest
            if tb and tb.addr and not st.abilityActive then
                local c = tick()
                local dynamicPanic = lala.panicBase + tb.speed * lala.panicSpeedMul
                local isPanic = lala.panicParry ~= false and tb.dist < dynamicPanic and tb.speed > 60
                local isClose = tb.dist <= lala.closeRangeDist
                local inLead = tb.dist <= (st.parryDist or st.lead or 0)
                local facingOk = (tb.closing or 0) > getEffectiveFacingMin()
                if (isPanic or isClose or (inLead and facingOk)) and c - remy.lastTap > 0.00003 then
                    if not genLock[tb.addr] and not ballParriedOnce[tb.addr]
                        and (c - (ballSpawnedAt[tb.addr] or 0)) >= NEW_BALL_GRACE then
                        local w0 = genWatch[tb.addr]
                        remy.lastTap = c
                        ymer.flash = c
                        remy.recentlyTapped[tb.addr] = c
                        genLock[tb.addr] = c
                        ballParriedOnce[tb.addr] = c
                        if w0 then
                            w0.t = c
                            w0.ntap = (w0.ntap or 0) + 1
                            w0.spd = tb.speed
                            w0.dist = tb.dist
                        else
                            genWatch[tb.addr] = { t = c, hp = genHp, spd = tb.speed, dist = tb.dist, ntap = 1 }
                        end
                        stats.taps = stats.taps + 1
                        panicParryAt = c
                        if isPanic then panicReason = "panic"
                        elseif isClose then panicReason = "close"
                        else panicReason = "lead" end
                        local rel = pressParry()
                        if rel then pcall(rel) end
                    end
                end
            end
        end
        task.wait(0.00003)
    end
end)
_G.__apPanicLoop = panicLoop

local triPool = {}
for i = 1, DM * DN * 2 do
    local tr = Drawing.new("Triangle")
    tr.Filled = true
    tr.Color = Color3.fromRGB(0, 255, 120)
    tr.Transparency = 0.72
    tr.Visible = false
    triPool[i] = tr
end
local function vidx(i, j) return i * (DN + 1) + j end
local triTops = {}
for i = 0, DM - 1 do
    for j = 0, DN - 1 do
        triTops[#triTops + 1] = { vidx(i, j), vidx(i + 1, j), vidx(i, j + 1) }
        triTops[#triTops + 1] = { vidx(i + 1, j), vidx(i + 1, j + 1), vidx(i, j + 1) }
    end
end
local rText = {}
for i = 1, 16 do
    local t = Drawing.new("Text")
    t.Size = 13
    t.Font = 8
    t.Center = true
    t.Outline = true
    t.Visible = true
    rText[i] = t
end
local hudBg = Drawing.new("Square")
hudBg.Filled = true
hudBg.Color = Color3.fromRGB(0, 0, 0)
hudBg.Transparency = 0.35
hudBg.ZIndex = -1
hudBg.Visible = false
local hudBg2 = Drawing.new("Square")
hudBg2.Filled = true
hudBg2.Color = Color3.fromRGB(0, 0, 0)
hudBg2.Transparency = 0.35
hudBg2.ZIndex = -1
hudBg2.Visible = false
rText[1].Color = Color3.fromRGB(255, 255, 255)
local lastHud = 0
local hudHidden = false
local lastTriFlash = false
local espPool = {}
for i = 1, POOL do
    local seg = {}
    for s = 1, VIS_SEG do
        local l = Drawing.new("Line")
        l.Thickness = 2
        l.Visible = false
        seg[s] = l
    end
    espPool[i] = { seg = seg, segV = {} }
end
local bvPool = {}
for i = 1, POOL do
    local dtxt = Drawing.new("Text")
    dtxt.Size = 12
    dtxt.Font = 8
    dtxt.Center = true
    dtxt.Outline = true
    dtxt.Color = C_TXT_A
    dtxt.Visible = false
    local stxt = Drawing.new("Text")
    stxt.Size = 12
    stxt.Font = 8
    stxt.Center = true
    stxt.Outline = true
    stxt.Color = C_TXT_B
    stxt.Visible = false
    local tline = Drawing.new("Line")
    tline.Thickness = 1
    tline.Visible = false
    tline.Color = Color3.fromRGB(255, 60, 60)
    tline.Transparency = 0.5
    bvPool[i] = { dtxt = dtxt, stxt = stxt, tline = tline }
end
local function hideBv(e)
    e.dtxt.Visible = false
    e.stxt.Visible = false
    e.tline.Visible = false
end
local radarBg = Drawing.new("Circle")
radarBg.Filled = true
radarBg.Color = Color3.fromRGB(10, 10, 12)
radarBg.Transparency = 0.35
radarBg.NumSides = 40
radarBg.Visible = false
local radarRing = Drawing.new("Circle")
radarRing.Filled = false
radarRing.Thickness = 1
radarRing.NumSides = 40
radarRing.Color = Color3.fromRGB(84, 101, 255)
radarRing.Visible = false
local radarCenter = Drawing.new("Circle")
radarCenter.Filled = true
radarCenter.Radius = 2.5
radarCenter.NumSides = 8
radarCenter.Color = Color3.fromRGB(255, 255, 255)
radarCenter.Visible = false
local radarDots = {}
for i = 1, POOL do
    local d = Drawing.new("Circle")
    d.Filled = true
    d.Radius = 3.5
    d.NumSides = 10
    d.Color = Color3.fromRGB(255, 60, 60)
    d.Visible = false
    radarDots[i] = d
end
local radarPlrs = {}
for i = 1, POOL do
    local d2 = Drawing.new("Circle")
    d2.Filled = true
    d2.Radius = 3
    d2.NumSides = 10
    d2.Color = Color3.fromRGB(255, 255, 255)
    d2.Visible = false
    radarPlrs[i] = d2
end
_G.__apPool = espPool
local hitDot = Drawing.new("Line")
hitDot.Thickness = 3
hitDot.Color = Color3.fromRGB(255, 0, 0)
hitDot.Transparency = 0.15
hitDot.Visible = false
local abilPool = {}
for i = 1, POOL do
    local bg = Drawing.new("Square")
    bg.Filled = true
    bg.Color = Color3.fromRGB(0, 0, 0)
    bg.Transparency = 0.35
    bg.Visible = false
    local txt = Drawing.new("Text")
    txt.Size = 13
    txt.Font = 8
    txt.Center = true
    txt.Outline = true
    txt.Color = Color3.fromRGB(255, 255, 255)
    txt.Visible = false
    abilPool[i] = { bg = bg, txt = txt }
end
local accBg = Drawing.new("Square")
accBg.Filled = true
accBg.Color = Color3.fromRGB(0, 0, 0)
accBg.Transparency = 0.35
accBg.Visible = false
local accTxt = Drawing.new("Text")
accTxt.Size = 13
accTxt.Font = 8
accTxt.Center = true
accTxt.Outline = true
accTxt.Visible = false
local kbBg = Drawing.new("Square")
kbBg.Filled = true
kbBg.Color = Color3.fromRGB(15, 16, 22)
kbBg.Transparency = 0.25
kbBg.Rounding = 6
kbBg.Visible = false
local kbBorder = Drawing.new("Square")
kbBorder.Filled = false
kbBorder.Thickness = 1
kbBorder.Rounding = 6
kbBorder.Visible = false
local kbBar = Drawing.new("Square")
kbBar.Filled = true
kbBar.Color = Color3.fromRGB(84, 101, 255)
kbBar.Visible = false
local kbTitle = Drawing.new("Text")
kbTitle.Size = 13
kbTitle.Font = 8
kbTitle.Outline = true
kbTitle.Color = Color3.fromRGB(255, 255, 255)
kbTitle.Text = "Keybinds"
kbTitle.Visible = false
local KB_ROWS = {
    { name = "Auto Parry", key = "keyP", get = function() return lala.v2 end },
    { name = "Ball Visuals", key = "keyV", get = function() return lala.bvExtras end },
    { name = "Clash", key = "keyX", get = function() return ymer.clash end },
    { name = "Ability Parry", key = "keyB", get = function() return lala.abilityParry end },
    { name = "Autoplay", key = "keyG", get = function() return lala.autoplay end },
    { name = "Smart Parry", key = "keySmart", get = function() return lala.smartParry end },
    { name = "Triggerbot", key = "keyT", get = function() return lala.triggerbot end },
    { name = "Randomize", key = "keyR", get = function() return lala.randomize end },
    { name = "Custom Lead", key = "keyL", get = function() return lala.customLeadMode end },
    { name = "Anti-Curve", key = "keyN", get = function() return lala.customFacingMinMode end },
    { name = "Panic Parry", key = "keyPanic", get = function() return lala.panicParry end },
}
local kbRow = {}
for i = 1, #KB_ROWS do
    local t = Drawing.new("Text")
    t.Size = 12
    t.Font = 8
    t.Outline = true
    t.Visible = false
    kbRow[i] = t
end
local kbx, kby = 20, 220
local kbDragging = false
local kbDragWas = false
local kbOffX, kbOffY = 0, 0
local abilTargets = {}
local abilRunning = true
task.spawn(function()
    while abilRunning do
        if bob == _G.__apGen then pcall(function()
        local out = {}
            for _, plr in ipairs(Players:GetPlayers()) do
                local char = plr.Character
                local hum = char and char:FindFirstChild("Humanoid")
                local head = char and char:FindFirstChild("Head")
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if char and char.Parent and head and root and hum and hum.Health > 0 then
                    local abl = plr:GetAttribute("CurrentlyEquippedAbility") or ""
                    local lvl = 0
                    if abl ~= "" then
                        local up = plr:FindFirstChild("Upgrades")
                        local iv = up and up:FindFirstChild(abl)
                        if iv then lvl = iv.Value or 0 end
                    end
                    local lbl = ""
                    if lala.abilityEsp then lbl = (abl ~= "" and abl or "?") end
                    if lala.abilityUpgradeEsp then lbl = (lbl == "" and "" or lbl .. "  ") .. "V" .. tostring(lvl + 1) end
                    out[#out + 1] = {
                        name = plr.Name,
                        head = head,
                        root = root,
                        abl = abl,
                        lvl = lvl,
                        self = plr == lp,
                        label = lbl,
                    }
                end
            end
            abilTargets = out
        end) end
        task.wait(0.4)
    end
end)
local rimLines = {}
for i = 1, DN do
    local l = Drawing.new("Line")
    l.Thickness = 2
    l.Color = Color3.fromRGB(0, 255, 120)
    l.Visible = false
    rimLines[i] = l
end
local coneTri = Drawing.new("Triangle")
coneTri.Filled = true
coneTri.Color = Color3.fromRGB(0, 255, 120)
coneTri.Transparency = 0.1
coneTri.ZIndex = -1
coneTri.Outline = true
coneTri.Visible = false
_G.__apCleanup = function()
    pcall(setrobloxinput, "BlockUserInput", false)
    clashRunning = false
    panicRunning = false
    abilRunning = false
    _G.__apClashLoop = nil
    _G.__apPanicLoop = nil
    if _G.__apWalk then
        if _G.__apWalk.moveConn then pcall(_G.__apWalk.moveConn.Disconnect, _G.__apWalk.moveConn) end
        if _G.__apWalk.aimConn then pcall(_G.__apWalk.aimConn.Disconnect, _G.__apWalk.aimConn) end
        _G.__apWalk.running = false
        _G.__apWalk = nil
    end
    if rebindConn then pcall(rebindConn.Disconnect, rebindConn) end
    rebindConn = nil
    for i = 1, DM * DN * 2 do pcall(triPool[i].Remove, triPool[i]) end
    for i = 1, #rText do pcall(rText[i].Remove, rText[i]) end
    pcall(hudBg.Remove, hudBg)
pcall(hudBg2.Remove, hudBg2)
    for i = 1, DN do
        pcall(rimLines[i].Remove, rimLines[i])
    end
    pcall(coneTri.Remove, coneTri)
    pcall(hitDot.Remove, hitDot)
    for i = 1, POOL do
        for s = 1, VIS_SEG do pcall(espPool[i].seg[s].Remove, espPool[i].seg[s]) end
    end
    for i = 1, POOL do
        pcall(abilPool[i].bg.Remove, abilPool[i].bg)
        pcall(abilPool[i].txt.Remove, abilPool[i].txt)
    end
    for i = 1, POOL do
        local b = bvPool[i]
        if b then
            pcall(b.dtxt.Remove, b.dtxt)
            pcall(b.stxt.Remove, b.stxt)
            pcall(b.tline.Remove, b.tline)
        end
    end
    pcall(accBg.Remove, accBg)
    pcall(accTxt.Remove, accTxt)
    pcall(kbBg.Remove, kbBg)
    pcall(kbBorder.Remove, kbBorder)
    pcall(kbBar.Remove, kbBar)
    pcall(kbTitle.Remove, kbTitle)
    for i = 1, #kbRow do pcall(kbRow[i].Remove, kbRow[i]) end
    pcall(radarBg.Remove, radarBg)
    for i = 1, #radarPlrs do pcall(radarPlrs[i].Remove, radarPlrs[i]) end
    pcall(radarRing.Remove, radarRing)
    pcall(radarCenter.Remove, radarCenter)
    for i = 1, #radarDots do pcall(radarDots[i].Remove, radarDots[i]) end
    _G.__apPool = nil
end

local CUSTOM_LEAD_PRESETS = { 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45, 0.50, 0.55, 0.60 }
local lastToggleKey, lastToggleT = nil, 0
local function doToggle(key)
    local t = tick()
    if key == lastToggleKey and t - lastToggleT < 0.25 then return end
    lastToggleKey, lastToggleT = key, t
    if key == "P" then
        lala.v2 = not lala.v2
    elseif key == "V" then
        lala.bvExtras = not lala.bvExtras
    elseif key == "X" then
        lala.clash = not lala.clash
        if lala.clash then
            clashSawMine = false
            clashLastMine = 0
            clashNoBallT = tick()
            clashPartner = nil
            ymer.clash = true
        end
    elseif key == "A" then
        lala.abilityEsp = not lala.abilityEsp
    elseif key == "B" then
        lala.abilityParry = not lala.abilityParry
    elseif key == "G" then
        lala.autoplay = not lala.autoplay
    elseif key == "T" then
        lala.triggerbot = not lala.triggerbot
    elseif key == "Smart" then
        lala.smartParry = not lala.smartParry
    elseif key == "Panic" then
        lala.panicParry = not lala.panicParry
    elseif key == "R" then
        if lala.smartParry then return end
        lala.randomize = not lala.randomize
    elseif key == "ACCPLUS" then
        lala.accuracy = math.clamp(lala.accuracy + 5, 1, 100)
    elseif key == "ACCMINUS" then
        lala.accuracy = math.clamp(lala.accuracy - 5, 1, 100)
    elseif key == "L" then
        lala.customLeadMode = not lala.customLeadMode
    elseif key == "LBRACKET" then
        lala.customLeadValue = math.clamp(lala.customLeadValue + 0.01, 0.05, 1.0)
        lala.customLeadMode = true
    elseif key == "RBRACKET" then
        lala.customLeadValue = math.clamp(lala.customLeadValue - 0.01, 0.05, 1.0)
        lala.customLeadMode = true
    elseif key == "Llabel" then
        lala.customLeadMode = not lala.customLeadMode
    elseif key == "Lnum" then
        local cur = lala.customLeadValue
        local nxt = CUSTOM_LEAD_PRESETS[1]
        for i = 1, #CUSTOM_LEAD_PRESETS do
            if CUSTOM_LEAD_PRESETS[i] > cur + 0.001 then
                nxt = CUSTOM_LEAD_PRESETS[i]
                break
            end
            nxt = CUSTOM_LEAD_PRESETS[(i % #CUSTOM_LEAD_PRESETS) + 1]
        end
        lala.customLeadValue = nxt
        lala.customLeadMode = true
    elseif key == "N" then
        lala.customFacingMinMode = not lala.customFacingMinMode
    elseif key == "FPLUS" then
        lala.customFacingMinValue = math.clamp(lala.customFacingMinValue + 0.01, -1, 1)
        lala.customFacingMinMode = true
    elseif key == "FMINUS" then
        lala.customFacingMinValue = math.clamp(lala.customFacingMinValue - 0.01, -1, 1)
        lala.customFacingMinMode = true
    end
    saveConfig()
end

local cam = workspace.CurrentCamera or game:GetService("Camera")
local HUD_MAIN_COUNT = 11
local HUD_SYS_GAP = 30
local HUD_SYS_START = HUD_MAIN_COUNT + 1
local function hudLineY(i)
    local y0 = (cam.ViewportSize.Y - 96) * 0.5
    if i >= HUD_SYS_START then
        return y0 + (HUD_MAIN_COUNT - 1) * 18 + HUD_SYS_GAP + (i - HUD_SYS_START) * 18
    end
    return y0 + (i - 1) * 18
end
hudHitAt = function(mx, my)
    local vp = cam.ViewportSize
    local y0 = (vp.Y - 96) * 0.5
    for i, ln in ipairs(TOGGLE_LINES) do
        local r = rText[ln]
        if r.Visible and r.Text ~= "" then
            local w = r.TextBounds.X
            local px = vp.X - 12 - w * 0.5
            local py = hudLineY(ln)
            if math.abs(mx - px) <= w * 0.5 + 6 and math.abs(my - py) <= 11 then
                return i
            end
        end
    end
    local r = rText[7]
    if r.Visible and r.Text ~= "" then
        local w = r.TextBounds.X
        local px = vp.X - 12 - w * 0.5
        local py = hudLineY(7)
        if math.abs(mx - px) <= w * 0.5 + 6 and math.abs(my - py) <= 11 then
            return "A"
        end
    end
    r = rText[14]
    if r.Visible and r.Text ~= "" then
        local w = r.TextBounds.X
        local px = vp.X - 12 - w * 0.5
        local py = hudLineY(14)
        if math.abs(mx - px) <= w * 0.5 + 6 and math.abs(my - py) <= 11 then
            return "ACCPLUS"
        end
    end
    return nil
end
local ringR = 21
local pts = {}
local vfl = {}
local lastDomeCam = nil
local lastDomeCenter = Vector3.zero
local lastDomeLead = 0
local lastDomeT = 0
local lastDomeMode = nil
local conn
local wasP, wasV, wasC, wasX, wasL, wasLB, wasRB = false, false, false, false, false, false, false
local wasB, wasR, wasAccM, wasAccP = false, false, false, false
local wasG = false
local wasT = false
local wasN, wasFP, wasFM = false, false, false
local m1Was = false
local visCnt = 0
local C_CACHE = { f = nil, t = nil, th = nil, r = nil, g = nil, b = nil }
local lastConeFill = nil
local hdC = { r = nil, g = nil, b = nil }
local hdTh, hdTr = nil, nil
local kbSig, kbPW, kbPH, kbN, kbDrawn = nil, 0, 0, 0, false
local trailVer = 0
local tcr, tcg, tcb, ter, teg, teb, tbt = nil, nil, nil, nil, nil, nil, nil
local segCols, thBest, thNorm = {}, {}, {}
local function refreshTrailStyle()
    local sr = lala.bvColor.r or 0
    local sg = lala.bvColor.g or 255
    local sb = lala.bvColor.b or 0
    local er = lala.bvEnd.r or 255
    local eg = lala.bvEnd.g or 0
    local eb = lala.bvEnd.b or 0
    tbt = math.clamp(tonumber(lala.bvThick) or 6, 1, 14)
    local thinEnd = math.max(1, math.floor(tbt / 3))
    for s = 1, VIS_SEG do
        local t = s / VIS_SEG
        segCols[s] = Color3.new(sr + (er - sr) * t, sg + (eg - sg) * t, sb + (eb - sb) * t)
        thNorm[s] = tbt + (thinEnd - tbt) * t
        thBest[s] = (tbt + 4) + (thinEnd - (tbt + 4)) * t
    end
    tcr, tcg, tcb, ter, teg, teb = sr, sg, sb, er, eg, eb
    trailVer = trailVer + 1
end
conn = RunService.RenderStepped:Connect(function()
    if bob ~= _G.__apGen then return end
    visCnt = (visCnt + 1) % 3
    local visTick = visCnt == 0
    local np = keyHeld(lala.keyP)
    local nv = keyHeld(lala.keyV)
    local nc = keyHeld(lala.keyC)
    local nx = keyHeld(lala.keyX)
    local nl = keyHeld(lala.keyL)
    local nb = keyHeld(lala.keyB)
    local nr = keyHeld(lala.keyR)
    local ng = keyHeld(lala.keyG)
    local nt = keyHeld(lala.keyT)
    local nSmart = keyHeld(lala.keySmart)
    local nPanic = keyHeld(lala.keyPanic)
    local nlb = (219 ~= (_G._genUIKey or 45)) and keyHeld(219) or false
    local nrb = (221 ~= (_G._genUIKey or 45)) and keyHeld(221) or false
    local naccp = (187 ~= (_G._genUIKey or 45)) and keyHeld(187) or false
    local naccm = (189 ~= (_G._genUIKey or 45)) and keyHeld(189) or false
    local nn = keyHeld(lala.keyN)
    local nfp = (190 ~= (_G._genUIKey or 45)) and keyHeld(190) or false
    local nfm = (188 ~= (_G._genUIKey or 45)) and keyHeld(188) or false
    local rc = tick() < rebindCooldown
    if not rebindIdx then
        if np and not wasP and not rc then doToggle("P") end
        if nv and not wasV and not rc then doToggle("V") end
        if nc and not wasC and not rc then doToggle("C") end
        if nx and not wasX and not rc then doToggle("X") end
        if nl and not wasL and not rc then doToggle("L") end
        if nb and not wasB and not rc then doToggle("B") end
        if ng and not wasG and not rc then doToggle("G") end
        if nt and not wasT and not rc then doToggle("T") end
        if nSmart and not ymer.wasSmart and not rc then doToggle("Smart") end
        if nPanic and not ymer.wasPanic and not rc then doToggle("Panic") end
        if nr and not wasR and not rc then doToggle("R") end
        if nn and not wasN and not rc then doToggle("N") end
        if nfp and not wasFP and not rc then doToggle("FPLUS") end
        if nfm and not wasFM and not rc then doToggle("FMINUS") end
        if naccp and not wasAccP and not rc then doToggle("ACCPLUS") end
        if naccm and not wasAccM and not rc then doToggle("ACCMINUS") end
        if nlb and not wasLB and not rc then doToggle("LBRACKET") end
        if nrb and not wasRB and not rc then doToggle("RBRACKET") end
    end
    wasP, wasV, wasC, wasX, wasL, wasLB, wasRB = np, nv, nc, nx, nl, nlb, nrb
    wasB = nb
    wasG = ng
    wasT = nt
    ymer.wasSmart = nSmart
    ymer.wasPanic = nPanic
    wasR = nr
    wasAccM = naccm
    wasAccP = naccp
    wasN = nn
    wasFP = nfp
    wasFM = nfm

    local tc = tick()
    if not lala.hudEnabled then
        if not hudHidden then
            hudHidden = true
            for i = 1, #rText do rText[i].Visible = false end
            pcall(function() hudBg.Visible = false end)
            pcall(function() hudBg2.Visible = false end)
        end
    elseif tc - lastHud > 0.1 then
        lastHud = tc
        local vp = cam.ViewportSize
        local hudLead = getEffectiveLeadTime()
        local leadLabel = lala.customLeadMode and "Custom-lead" or "Auto-lead"
        local adjustHint = lala.customLeadMode and " [+ -]" or ""
        local idleTag = ymer.idle and " (IDLE)" or ""
        local apLabel = "OFF"
        if lala.abilityParry then
            local apName = getEquippedAbility()
            if AP_ABILITIES[apName] then
                apLabel = apName
            end
        end
        local lines = {
            "-- Game Features --" .. idleTag,
            string.format("Autoparry: %s [%s]", lala.v2 and "ON" or "OFF", keyLabel(lala.keyP)),
            string.format("Ball Visuals: %s [%s]", lala.bvExtras and "ON" or "OFF", keyLabel(lala.keyV)),
            string.format("Clash: %s [%s]", ymer.clash and "ON" or "OFF", keyLabel(lala.keyX)),
            string.format("View: %s", lala.viewEnabled == false and "Off" or (lala.cone and "Cone" or "Circle")),
            "-- Toggles --",
            string.format("Ability ESP: %s", lala.abilityEsp and "ON" or "OFF"),
            string.format("Ability Parry: %s [%s]", apLabel, keyLabel(lala.keyB)),
            string.format("Autoplay: %s [%s]", lala.autoplay and "ON" or "OFF", keyLabel(lala.keyG)),
            string.format("Triggerbot: %s [%s]", lala.triggerbot and "ON" or "OFF", keyLabel(lala.keyT)),
            "Parry: " .. remyLabel,
            "-- System --",
            string.format("%s: %.2f [%s]%s", leadLabel, hudLead, keyLabel(lala.keyL), adjustHint),
            string.format("Anti-curve: %s %.2f [%s]%s", lala.customFacingMinMode and "Custom" or "Auto", getEffectiveFacingMin(), keyLabel(lala.keyN), lala.customFacingMinMode and " [,. ]" or ""),
            string.format("Randomize: %s%s [%s]", lala.randomize and "ON" or "OFF", (lala.randomize and tc - panicParryAt < 0.5) and " (bypass)" or "", keyLabel(lala.keyR)),
            string.format("Accuracy: %d%% [-/+]", math.floor(nextParryAccuracy() + 0.5)),
        }
        if rebindIdx then
            lines[TOGGLE_LINES[rebindIdx]] = "press key to bind..."
        end
        local y0 = (vp.Y - 96) * 0.5
        local mainCount = HUD_MAIN_COUNT
        local sysStart = HUD_SYS_START
        local sysGap = HUD_SYS_GAP
        for i = 1, #lines do
            local r = rText[i]
            r.Text = lines[i]
            local w = r.TextBounds.X
            local iy
            if i >= sysStart then
                iy = y0 + (mainCount - 1) * 18 + sysGap + (i - sysStart) * 18
            else
                iy = y0 + (i - 1) * 18
            end
            r.Position = { x = vp.X - 12 - w * 0.5, y = iy }
            if rebindIdx and TOGGLE_LINES[rebindIdx] == i then
                r.Color = Color3.fromRGB(255, 255, 120)
            elseif i == 1 then
                r.Color = Color3.fromRGB(255, 255, 255)
            elseif i == 2 then
                r.Color = lala.v2 and Color3.fromRGB(30, 200, 90) or Color3.fromRGB(220, 60, 60)
            elseif i == 3 then
                r.Color = lala.bvExtras and Color3.fromRGB(30, 200, 90) or Color3.fromRGB(220, 60, 60)
            elseif i == 4 then
                r.Color = ymer.clash and Color3.fromRGB(30, 200, 90) or Color3.fromRGB(220, 60, 60)
            elseif i == 5 then
                r.Color = Color3.fromRGB(200, 170, 60)
            elseif i == 6 then
                r.Color = Color3.fromRGB(255, 255, 255)
            elseif i == 7 then
                r.Color = lala.abilityEsp and Color3.fromRGB(30, 200, 90) or Color3.fromRGB(220, 60, 60)
            elseif i == 8 then
                if not lala.abilityParry or apLabel == "OFF" then
                    r.Color = Color3.fromRGB(220, 60, 60)
                elseif tick() < abilityReadyAt then
                    r.Color = Color3.fromRGB(255, 200, 60)
                else
                    r.Color = Color3.fromRGB(30, 200, 90)
                end
            elseif i == 9 then
                r.Color = lala.autoplay and Color3.fromRGB(30, 200, 90) or Color3.fromRGB(220, 60, 60)
            elseif i == 10 then
                r.Color = lala.triggerbot and Color3.fromRGB(30, 200, 90) or Color3.fromRGB(220, 60, 60)
            elseif i == 11 then
                r.Color = Color3.fromRGB(255, 255, 255)
            elseif i == 12 then
                r.Color = Color3.fromRGB(255, 255, 255)
            elseif i == 13 then
                r.Color = Color3.fromRGB(255, 255, 255)
            elseif i == 14 then
                r.Color = Color3.fromRGB(255, 255, 255)
            elseif i == 15 then
                if lala.randomize and tc - panicParryAt < 0.5 then
                    r.Color = Color3.fromRGB(255, 200, 60)
                else
                    r.Color = lala.randomize and Color3.fromRGB(30, 200, 90) or Color3.fromRGB(220, 60, 60)
                end
            elseif i == 16 then
                r.Color = Color3.fromRGB(200, 170, 60)
            end
        end
        local maxW = 0
        local sysMaxW = 0
        for i = 1, #lines do
            local w = rText[i].TextBounds.X
            if w > maxW then maxW = w end
            if i >= sysStart and w > sysMaxW then sysMaxW = w end
        end
        hudBg.Position = { x = vp.X - 12 - maxW - 6, y = y0 - 10 }
        hudBg.Size = { x = maxW + 12, y = (mainCount - 1) * 18 + 20 }
        hudBg.Visible = true
        local sysY = y0 + (mainCount - 1) * 18 + sysGap - 10
        hudBg2.Position = { x = vp.X - 12 - sysMaxW - 6, y = sysY }
        hudBg2.Size = { x = sysMaxW + 12, y = (#lines - sysStart) * 18 + 20 }
        hudBg2.Visible = true
        for i = #lines + 1, 14 do rText[i].Visible = false end
    end
    local m1 = ismouse1pressed()
    if mouseBlocked and not m1 then
        mouseBlocked = false
        pcall(setrobloxinput, "BlockUserInput", false)
    end
    if lala.hudEnabled and m1 and not m1Was and not rebindIdx and tc - ymerAutoT > 0.2 then
        local mx, my = mousePos()
        local hit = hudHitAt(mx, my)
        if hit then
            mouseBlocked = true
            pcall(setrobloxinput, "BlockUserInput", true)
            if type(hit) == "number" then
                startRebind(hit)
            else
                doToggle(hit)
            end
        end
    end
    m1Was = m1
    if lala.keybindsHud then
        local sig = nil
        for i = 1, #KB_ROWS do
            if KB_ROWS[i].get() then
                sig = (sig or "") .. i .. ":" .. tostring(lala[KB_ROWS[i].key]) .. ";"
            end
        end
        if sig then
            local moved = false
            if m1 then
                local mx, my = mousePos()
                if not kbDragging and not kbDragWas then
                    if mx >= kbx and mx <= kbx + 110 and my >= kby and my <= kby + 20 then
                        kbDragging = true
                        kbOffX = mx - kbx
                        kbOffY = my - kby
                    end
                elseif kbDragging then
                    kbx = mx - kbOffX
                    kby = my - kbOffY
                    moved = true
                end
            else
                kbDragging = false
            end
            kbDragWas = m1
            local rebuild = sig ~= kbSig
            if rebuild then
                kbSig = sig
                local maxW = kbTitle.TextBounds.X
                local ri = 0
                for i = 1, #KB_ROWS do
                    if KB_ROWS[i].get() then
                        ri = ri + 1
                        local r = kbRow[ri]
                        r.Text = KB_ROWS[i].name .. " [" .. keyLabel(lala[KB_ROWS[i].key]) .. "]"
                        r.Color = C_TXT_A
                        r.Visible = true
                        local w = r.TextBounds.X
                        if w > maxW then maxW = w end
                    end
                end
                for i = ri + 1, #kbRow do kbRow[i].Visible = false end
                kbPW = maxW + 16
                kbPH = 32 + ri * 17 + 8
                kbN = ri
            end
            if rebuild or moved or not kbDrawn then
                local light = _G._bgIsLight
                local red = _G._bgIsRed
                local blk = _G._bgIsBlack
                local pnk = _G._bgIsPink
                kbBg.Position = { x = kbx, y = kby }
                kbBg.Size = { x = kbPW, y = kbPH }
                kbBg.Color = light and Color3.fromRGB(238, 238, 242) or (red and Color3.fromRGB(42, 9, 12) or (blk and Color3.fromRGB(10, 10, 12) or (pnk and Color3.fromRGB(100, 30, 60) or Color3.fromRGB(15, 16, 22))))
                kbBorder.Position = { x = kbx, y = kby }
                kbBorder.Size = { x = kbPW, y = kbPH }
                kbBorder.Color = _G._bdrClr or Color3.fromRGB(60, 62, 80)
                kbBorder.Visible = true
                kbTitle.Color = Color3.fromRGB(255, 255, 255)
                kbBar.Color = _G._uiAccent or Color3.fromRGB(84, 101, 255)
                kbBar.Position = { x = kbx + 8, y = kby + 24 }
                kbBar.Size = { x = kbPW - 16, y = 2 }
                kbTitle.Position = { x = kbx + 8, y = kby + 6 }
                for i = 1, kbN do
                    kbRow[i].Position = { x = kbx + 8, y = kby + 34 + (i - 1) * 17 }
                    kbRow[i].Color = C_TXT_A
                end
                kbDrawn = true
            end
            kbBar.Visible = true
            kbBg.Visible = true
            kbTitle.Visible = true
        else
            kbSig = nil
            kbDrawn = false
            kbBg.Visible = false
            kbBorder.Visible = false
            kbBar.Visible = false
            kbTitle.Visible = false
            for i = 1, #kbRow do kbRow[i].Visible = false end
        end
    else
        kbSig = nil
        kbDrawn = false
        kbBg.Visible = false
        kbBorder.Visible = false
        kbBar.Visible = false
        kbTitle.Visible = false
        for i = 1, #kbRow do kbRow[i].Visible = false end
    end
    if lala.abilityEsp or lala.abilityUpgradeEsp then
        pcall(function()
        local list = abilTargets
        local vp = cam.ViewportSize
        local vw, vh = vp.X, vp.Y
        local n = 0
        for i = 1, #list do
            if n >= POOL then break end
            local t = list[i]
            local hok = t.head and t.head.Parent ~= nil
            local rok = t.root and t.root.Parent ~= nil
            local hpos = hok and t.head.Position
            local rpos = rok and t.root.Position
            if hpos and rpos and hpos.X == hpos.X and rpos.X == rpos.X then
                local top, v1 = WorldToScreen(hpos + Vector3.new(0, 0.6, 0))
                local bot, v2 = WorldToScreen(rpos - Vector3.new(0, 3.2, 0))
                if v1 and v2 then
                n = n + 1
                local e = abilPool[n]
                local tx, ty = bot.X, bot.Y + 12
                local lbl = t.label or ""
                e.txt.Text = lbl
                local tb = e.txt.TextBounds
                e.txt.Position = { x = tx, y = ty }
                e.bg.Position = { x = tx - tb.X * 0.5 - 3, y = ty - tb.Y * 0.5 - 2 }
                e.bg.Size = { x = tb.X + 6, y = tb.Y + 4 }
                e.txt.Visible = true
                e.bg.Visible = true
            else
                n = n + 1
                local e = abilPool[n]
                local h = top.Y - bot.Y
                if h <= 0 then h = 1 end
                local cx = (top.X + bot.X) * 0.5
                local cy = (top.Y + bot.Y) * 0.5
                cx = vw - cx
                cy = vh - cy
                local px = math.clamp(cx, 30, vw - 30)
                local py = math.clamp(cy, 12, vh - 12)
                local lbl = t.label or ""
                e.txt.Text = lbl
                local tb = e.txt.TextBounds
                e.txt.Position = { x = px, y = py }
                e.bg.Position = { x = px - tb.X * 0.5 - 3, y = py - tb.Y * 0.5 - 2 }
                e.bg.Size = { x = tb.X + 6, y = tb.Y + 4 }
                e.txt.Visible = true
                e.bg.Visible = true
            end
            end
        end
        for i = n + 1, POOL do
            abilPool[i].txt.Visible = false
            abilPool[i].bg.Visible = false
        end
        end)
    else
        for i = 1, POOL do
            abilPool[i].txt.Visible = false
            abilPool[i].bg.Visible = false
        end
    end
    local accShow = lala.v2 and lala.randomize and lala.accHead ~= false and ymer.headPos
    if accShow then
        local top, v1 = WorldToScreen(ymer.headPos + Vector3.new(0, 0.9, 0))
        if v1 then
            local acc = math.floor(nextParryAccuracy() + 0.5)
            local bypassing = tc - panicParryAt < 0.5
            accTxt.Text = tostring(acc) .. "%" .. (bypassing and (" - " .. panicReason) or "")
            local col
            if bypassing then col = Color3.fromRGB(255, 160, 0)
            elseif acc < 50 then col = Color3.fromRGB(255, 60, 60)
            elseif acc < 80 then col = Color3.fromRGB(255, 200, 60)
            else col = Color3.fromRGB(60, 220, 90) end
            accTxt.Color = col
            local tb = accTxt.TextBounds
            accTxt.Position = { x = top.X, y = top.Y - 16 }
            accBg.Position = { x = top.X - tb.X * 0.5 - 3, y = top.Y - 16 - tb.Y * 0.5 - 2 }
            accBg.Size = { x = tb.X + 6, y = tb.Y + 4 }
            accTxt.Visible = true
            accBg.Visible = true
        else
            accTxt.Visible = false
            accBg.Visible = false
        end
    else
        accTxt.Visible = false
        accBg.Visible = false
    end
    if not (lala.v2 and ymer.centerPos) or ymer.abilityActive or ymer.idle then
        for i = 1, DM * DN * 2 do triPool[i].Visible = false end
        for i = 1, DN do rimLines[i].Visible = false end
        coneTri.Visible = false
        hitDot.Visible = false
        for i = 1, POOL do
            for s = 1, VIS_SEG do espPool[i].seg[s].Visible = false end
            hideBv(bvPool[i])
        end
        radarBg.Visible = false
        radarRing.Visible = false
        radarCenter.Visible = false
        for i = 1, POOL do radarDots[i].Visible = false end
        for i = 1, POOL do radarPlrs[i].Visible = false end
        return
    end
    ringR = ringR + (ymer.leadDist - ringR) * 0.08
    local R = ringR
    local c = ymer.centerPos
    local flashAge = tc - ymer.flash

    local dc = tick()
    local cp = cam.CFrame
    local camMoved = not lastDomeCam
        or (cp.Position - lastDomeCam.Position).Magnitude > 0.1
        or (cp.LookVector - lastDomeCam.LookVector).Magnitude > 0.02
    local domeStale = (c - lastDomeCenter).Magnitude > 0.15
        or math.abs(R - lastDomeLead) > 1
        or dc - lastDomeT > 0.5
        or lastDomeMode ~= lala.dome
    if camMoved or domeStale then
        lastDomeT = dc
        lastDomeCam = cp
        lastDomeCenter = c
        lastDomeLead = R
        lastDomeMode = lala.dome
        pts = {}
        vfl = {}
        for j = 0, DN do
            local az = ((j / DN) * TAU) or 0
            local sa = math.sin(az) or 0
            local ca = math.cos(az) or 0
            local wp = c + Vector3.new(ca * R, 0, sa * R)
            local sp, v = WorldToScreen(wp)
            local k = vidx(0, j)
            pts[k] = sp
            vfl[k] = v
        end
    end
    local flashing = flashAge < 0.4
    local acr, acg, acb = lala.apColor.r or 0, lala.apColor.g or 255, lala.apColor.b or 120
    local atrans = lala.apTrans or 5
    local athick = lala.apThick or 2
    if flashing ~= C_CACHE.f or atrans ~= C_CACHE.t or athick ~= C_CACHE.th or acr ~= C_CACHE.r or acg ~= C_CACHE.g or acb ~= C_CACHE.b then
        C_CACHE.f, C_CACHE.t, C_CACHE.th, C_CACHE.r, C_CACHE.g, C_CACHE.b = flashing, atrans, athick, acr, acg, acb
        local bcol
        local bfill = atrans / 100
        if flashing then bcol = Color3.fromRGB(255, 40, 40); bfill = 0.05 else bcol = Color3.fromRGB(acr, acg, acb) end
        for i = 1, #triPool do
            triPool[i].Color = bcol
            triPool[i].Transparency = bfill
        end
        for i = 1, DN do
            rimLines[i].Color = bcol
            rimLines[i].Transparency = bfill + 0.3
            rimLines[i].Thickness = athick
        end
        coneTri.Color = bcol
        coneTri.Thickness = athick
    end
    local coneFill = flashing and 0.1 or math.min(atrans / 100 + 0.05, 1)
    if coneFill ~= lastConeFill then
        coneTri.Transparency = coneFill
        lastConeFill = coneFill
    end

    for i = 1, DN do
        local a = vidx(0, i - 1)
        local b = vidx(0, i)
        local rl = rimLines[i]
        if lala.viewEnabled ~= false and not lala.cone and vfl[a] and vfl[b] then
            rl.From = pts[a]
            rl.To = pts[b]
            rl.Visible = true
        elseif rl.Visible then
            rl.Visible = false
        end
    end
        if lala.viewEnabled ~= false and lala.cone and ymer.ballPos and ymer.active then
            local bp = ymer.ballPos
            local dx = bp.X - c.X
            local dz = bp.Z - c.Z
            local dLen = math.sqrt(dx * dx + dz * dz)
            if dLen > 1 then
                local ux, uz = dx / dLen, dz / dLen
                local px, pz = -uz, ux
                local halfW = R * 0.22
                local tipW = c
                local baseL = c + Vector3.new(ux * R + px * halfW, 0, uz * R + pz * halfW)
                local baseR = c + Vector3.new(ux * R - px * halfW, 0, uz * R - pz * halfW)
                local sp1, v1 = WorldToScreen(tipW)
                local sp2, v2 = WorldToScreen(baseL)
                local sp3, v3 = WorldToScreen(baseR)
                if v1 and v2 and v3 then
                    coneTri.PointA = sp1
                    coneTri.PointB = sp2
                    coneTri.PointC = sp3
                    coneTri.Visible = true
                else
                    coneTri.Visible = false
                end
            else
                coneTri.Visible = false
            end
        else
            coneTri.Visible = false
        end
    if not lala.smartParry and lala.parryDistInd ~= false and lala.v2 and ymer.ballPos and c then
        local pDist = ymer.parryDist or R
        local bp = ymer.ballPos
        local dx = bp.X - c.X
        local dz = bp.Z - c.Z
        local dLen = math.sqrt(dx * dx + dz * dz)
        if dLen > 0.5 then
            local ux = dx / dLen
            local uz = dz / dLen
            local floorY = c.Y
            local hitPos = Vector3.new(c.X + ux * pDist, floorY, c.Z + uz * pDist)
            local fromP, fromV = WorldToScreen(Vector3.new(c.X, floorY, c.Z))
            local toP, toV = WorldToScreen(hitPos)
            if fromV and toV then
                hitDot.From = fromP
                hitDot.To = toP
                local hdr, hdg, hdb = lala.pdColor.r or 255, lala.pdColor.g or 0, lala.pdColor.b or 0
                if hdr ~= hdC.r or hdg ~= hdC.g or hdb ~= hdC.b then
                    hdC.r, hdC.g, hdC.b = hdr, hdg, hdb
                    hitDot.Color = Color3.fromRGB(hdr, hdg, hdb)
                end
                local hth = lala.pdThick or 3
                if hth ~= hdTh then hdTh = hth; hitDot.Thickness = hth end
                local htr = (lala.pdTrans or 15) / 100
                if htr ~= hdTr then hdTr = htr; hitDot.Transparency = htr end
                hitDot.Visible = true
            else
                hitDot.Visible = false
            end
        else
            hitDot.Visible = false
        end
    else
        hitDot.Visible = false
    end
    pcall(function()
    if not lala.smartParry and lala.bvExtras ~= false then
        local bcr, bcg, bcb = lala.bvColor.r or 0, lala.bvColor.g or 255, lala.bvColor.b or 0
        local ber, beg, beb = lala.bvEnd.r or 255, lala.bvEnd.g or 0, lala.bvEnd.b or 0
        local btk = tonumber(lala.bvThick) or 6
        if bcr ~= tcr or bcg ~= tcg or bcb ~= tcb or ber ~= ter or beg ~= teg or beb ~= teb or btk ~= tbt then refreshTrailStyle() end
        local list = ymer.ballList
        local n = 0
        if list then
        for i = 1, #list do
            if n >= POOL then break end
            local bp, bv = WorldToScreen(list[i].pos)
            if bv then
                n = n + 1
                local e = espPool[n]
                local dir = list[i].dir
                if lala.showVis and dir then
                    local len = math.clamp(list[i].speed * 0.35, 12, 90) * (math.clamp(tonumber(lala.bvLen) or 100, 20, 100) / 100)
                    local mid = list[i].pos + dir * (len * 0.5)
                    local endPt = mid + dir * (len * 0.5)
                    local turn = list[i].turn
                    local cv = list[i].curve or 0
                    local toTgt = nil
                    if list[i].tgtPos then
                        local tv = (list[i].tgtPos - list[i].pos)
                        if tv.Magnitude > 0.5 then
                            toTgt = tv.Unit
                        end
                    end
                    local bendDir = turn
                    if not bendDir and toTgt then
                        local tdot = math.clamp(dir:Dot(toTgt), -1, 1)
                        local cross = dir:Cross(toTgt)
                        if cross.Magnitude > 0.01 then
                            bendDir = cross.Unit:Cross(dir).Unit
                        end
                    end
                    if bendDir then
                        local bulge = (toTgt and 0.35 or 0.12) * len
                        if cv > 0 then bulge = bulge + cv * len * 4 end
                        endPt = endPt + bendDir * bulge
                    end
                    local endDir = (endPt - list[i].pos)
                    local endLen = endDir.Magnitude
                    local c1 = list[i].pos + dir * (len * 0.45)
                    if bendDir then
                        local c1bulge = (toTgt and 0.5 or 0.15) * len
                        if cv > 0 then c1bulge = c1bulge + cv * len * 3 end
                        c1 = c1 + bendDir * c1bulge
                    end
                    local c2 = list[i].pos
                    if endLen > 0.01 then
                        c2 = endPt - (endDir / endLen) * (len * 0.45)
                    end
                    local bpos = list[i].pos
                    local best = list[i].best
                    local styK = trailVer * 2 + (best and 1 or 0)
                    local prev = bp
                    local shown = 0
                    for s = 1, VIS_SEG do
                        local t = s / VIS_SEG
                        local iu = 1 - t
                        local pt = iu * iu * iu * bpos + 3 * iu * iu * t * c1 + 3 * iu * t * t * c2 + t * t * t * endPt
                        local sp, sv = WorldToScreen(pt)
                        if sv then
                            local sg = e.seg[s]
                            sg.From = prev
                            sg.To = sp
                            if e.segV[s] ~= styK then
                                sg.Color = segCols[s]
                                sg.Thickness = best and thBest[s] or thNorm[s]
                                e.segV[s] = styK
                            end
                            sg.Visible = true
                            prev = sp
                            shown = s
                        else
                            break
                        end
                    end
                    for s = shown + 1, VIS_SEG do e.seg[s].Visible = false end
                else
                    for s = 1, VIS_SEG do e.seg[s].Visible = false end
                end
                do
                    local bve = bvPool[n]
                    local d3 = nil
                    if c then
                        local dv = list[i].pos - c
                        d3 = math.floor(dv.Magnitude + 0.5)
                    end



                    if lala.bvExtras ~= false and lala.bvDist ~= false and d3 then
                        bve.dtxt.Text = tostring(d3) .. "m"

                        bve.dtxt.Position = { x = bp.X, y = bp.Y - 20 }
                        bve.dtxt.Visible = true
                    else
                        bve.dtxt.Visible = false
                    end
                    if lala.bvExtras ~= false and lala.bvSpeed then
                        bve.stxt.Text = tostring(math.floor((list[i].speed or 0) + 0.5))

                        bve.stxt.Position = { x = bp.X, y = bp.Y + 8 }
                        bve.stxt.Visible = true
                    else
                        bve.stxt.Visible = false
                    end
                    if lala.bvExtras ~= false and lala.bvTarget ~= false and list[i].tgtPos then
                        local tp, tv2 = WorldToScreen(list[i].tgtPos)
                        if tv2 then
                            bve.tline.From = bp
                            bve.tline.To = tp
                            bve.tline.Color = Color3.fromRGB(lala.bvEnd.r or 255, lala.bvEnd.g or 0, lala.bvEnd.b or 0)
                            bve.tline.Visible = true
                            bve.tline.Visible = true
                        else
                            bve.tline.Visible = false
                        end
                    else
                        bve.tline.Visible = false
                    end
                    end
                end
            end
        end
        for i = n + 1, POOL do
            for s = 1, VIS_SEG do espPool[i].seg[s].Visible = false end
            hideBv(bvPool[i])
        end
        if lala.bvRadar and c then
            local vp = cam.ViewportSize
            local rr = 92
            local rxp = vp.X - 116
            local ryp = 116
            radarBg.Position = { x = rxp, y = ryp }
            radarBg.Radius = rr
            radarBg.Visible = true
            radarRing.Position = { x = rxp, y = ryp }
            radarRing.Radius = rr
            radarRing.Visible = true
            radarCenter.Position = { x = rxp, y = ryp }
            radarCenter.Visible = true
            local fwd = cam.CFrame.LookVector
            local ang = math.atan2(fwd.X, fwd.Z)
            local ca, sa = math.cos(ang), math.sin(ang)
            local pxPerStud = (rr - 6) / 140
            local function toRadar(wx, wz)
                local dx = wx - c.X
                local dz = wz - c.Z
                local fComp = dx * sa + dz * ca
                local rComp = dx * ca - dz * sa
                local px = rxp + rComp * pxPerStud
                local py = ryp - fComp * pxPerStud
                local ox = px - rxp
                local oy = py - ryp
                local od = math.sqrt(ox * ox + oy * oy)
                local maxO = rr - 5
                if od > maxO then
                    px = rxp + ox / od * maxO
                    py = ryp + oy / od * maxO
                end
                return px, py
            end
            local rd = 0
            for i = 1, #list do
                if rd >= POOL then break end
                rd = rd + 1
                local dot = radarDots[rd]
                local px, py = toRadar(list[i].pos.X, list[i].pos.Z)
                dot.Position = { x = px, y = py }
                dot.Radius = list[i].best and 4.5 or 3

                dot.Visible = true
            end
            for i = rd + 1, POOL do radarDots[i].Visible = false end
            local pd = 0
            local alist = abilTargets
            for i = 1, #alist do
                if pd >= POOL then break end
                local at = alist[i]
                if not at.self and at.root then
                    pd = pd + 1
                    local dot = radarPlrs[pd]
                    local px, py = toRadar(at.root.Position.X, at.root.Position.Z)
                    dot.Position = { x = px, y = py }
                    dot.Visible = true
                end
            end
            for i = pd + 1, POOL do radarPlrs[i].Visible = false end
        else
            radarBg.Visible = false
            radarRing.Visible = false
            radarCenter.Visible = false
            for i = 1, POOL do radarDots[i].Visible = false end            
            for i = 1, POOL do radarPlrs[i].Visible = false end
        end
    else
        for i = 1, POOL do
            for s = 1, VIS_SEG do espPool[i].seg[s].Visible = false end
            hideBv(bvPool[i])
        end
        radarBg.Visible = false
        radarRing.Visible = false
        radarCenter.Visible = false
        for i = 1, POOL do radarDots[i].Visible = false end        
        for i = 1, POOL do radarPlrs[i].Visible = false end
    end
    end)
end)
_G.__apConn = conn

pcall(function()
    uis.InputBegan:Connect(function(inp)
        if bob ~= _G.__apGen then return end
        if rebindIdx then return end
        if tick() < rebindCooldown then return end
        local kc = inp and inp.KeyCode
        local uiVK = _G._genUIKey or 45
        local function match(k)
            if k == uiVK then return false end
            if kc == k then return true end
            if k >= 65 and k <= 90 and kc == k + 32 then return true end
            return false
        end
        if match(lala.keyP) then
            doToggle("P")
        elseif match(lala.keyV) then
            doToggle("V")
        elseif match(lala.keyC) then
            doToggle("C")
        elseif match(lala.keyX) then
            doToggle("X")
        elseif match(lala.keyG) then
            doToggle("G")
        end
    end)
end)

pcall(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local lp = Players.LocalPlayer

    if _G.__apWalk then
        if _G.__apWalk.moveConn then pcall(_G.__apWalk.moveConn.Disconnect, _G.__apWalk.moveConn) end
        if _G.__apWalk.aimConn then pcall(_G.__apWalk.aimConn.Disconnect, _G.__apWalk.aimConn) end
        _G.__apWalk.running = false
    end
    local walk = {}
    _G.__apWalk = walk
    walk.running = true

    local arena = { center = nil, radius = 120, ok = false, t = 0 }
    walk.arena = arena

    local realKeypress = _G.__apRealKeypress or keypress
    local realKeyrelease = _G.__apRealKeyrelease or keyrelease

    local RING = 12

    local function inMatch()
        local t = lp.Team
        return t ~= nil and tostring(t.Name) ~= "Waiting"
    end

    local function arenaFromFloor()
        local ws = game:GetService("Workspace")
        local mapFolder = ws:FindFirstChild("Map")
        local m = mapFolder and mapFolder:FindFirstChildOfClass("Model")
        if not m then return false end
        local floor = m:FindFirstChild("FLOOR")
        if not floor then
            for _, c in ipairs(m:GetChildren()) do
                if c.ClassName == "Part" or c.ClassName == "MeshPart" then
                    if c.Name:match("FLOOR") then floor = c break end
                end
            end
        end
        if not floor then return false end
        local po = floor.Position
        local sz = floor.Size
        local half = (sz.X > 0 and sz.X * 0.5) or 140
        arena.center = Vector3.new(po.X, po.Y + 4, po.Z)
        arena.radius = math.max(half * 0.7, 40)
        arena.ok = true
        return true
    end

    local function refreshArena()
        if not arenaFromFloor() then arena.ok = false end
        arena.t = tick()
    end

    local function rootPos(plr)
        local ch = plr.Character
        local r = ch and ch:FindFirstChild("HumanoidRootPart")
        return r and r.Position or nil
    end

    local function collectEnemies()
        local out = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lp then
                local p = rootPos(plr)
                if p then out[#out + 1] = p end
            end
        end
        return out
    end

    local function clamp01(v)
        if v < 0 then return 0 end
        if v > 1 then return 1 end
        return v
    end

    task.spawn(function()
        refreshArena()
        local lastMove = 0
        while walk.running do
            local lala = _G.autoParry or {}
            local char = lp.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local now = tick()

            if hum and root and hum.Health > 0 and lala.autoplay and lala.apWalk ~= false and inMatch() then
                if not arena.ok or now - arena.t > 6 then refreshArena() end

                if arena.ok and arena.center then
                    local myPos = root.Position
                    local state = _G.__apState or {}
                    local ballSpeed = state.speed or 0
                    local fastThresh = lala.fastBallThreshold or 120

                    local flash = state.flash or 0
                    local holding = (tick() - flash) < 0.35

                    local edge = clamp01(ballSpeed / fastThresh)
                    local wallR = arena.radius / 0.7
                    local innerR = arena.radius * 0.30
                    local outerR = wallR * 0.92
                    local targetR = innerR + (outerR - innerR) * edge

                    if not holding then
                        local enemies = collectEnemies()

                        if #enemies > 0 then
                            local bestAng = walk.ang or 0
                            local bestMin = -1
                            local samples = 24
                            for s = 0, samples - 1 do
                                local a = (s / samples) * math.pi * 2
                                local cand = arena.center + Vector3.new(math.cos(a) * targetR, 0, math.sin(a) * targetR)
                                local minDist = 1e9
                                for _, e in ipairs(enemies) do
                                    local dd = (cand - e).Magnitude
                                    if dd < minDist then minDist = dd end
                                end
                                if minDist > bestMin then
                                    bestMin = minDist
                                    bestAng = a
                                end
                            end
                            bestAng = bestAng + (math.random() - 0.5) * 0.5
                            walk.ang = bestAng
                            local tpos = arena.center + Vector3.new(math.cos(bestAng) * targetR, 0, math.sin(bestAng) * targetR)

                            local dir = tpos - myPos
                            dir = Vector3.new(dir.X, 0, dir.Z)
                            local dLen = dir.Magnitude
                            if dLen > 0.01 then
                                local toC = Vector3.new(arena.center.X - myPos.X, 0, arena.center.Z - myPos.Z)
                                local distC = toC.Magnitude
                                if distC > 0.5 then
                                    local tan = Vector3.new(-toC.Z, 0, toC.X).Unit
                                    local tanSign = 1
                                    if dir.Unit:Dot(tan) < 0 then tanSign = -1 end
                                    local t = math.clamp(toC:Dot(dir) / (dLen * dLen), 0, 1)
                                    local proj = Vector3.new(myPos.X + dir.X * t - arena.center.X, 0, myPos.Z + dir.Z * t - arena.center.Z)
                                    local cperp = proj.Magnitude
                                    local avoid = math.clamp(1 - cperp / (arena.radius * 0.5), 0, 1)
                                    dir = (dir.Unit + tan * tanSign * avoid * 1.2).Unit * dLen
                                end
                            end
                            local rayParams = RaycastParams.new()
                            rayParams.FilterType = Enum.RaycastFilterType.Exclude
                            rayParams.FilterDescendantsInstances = { char }
                            local hit = workspace:Raycast(myPos + Vector3.new(0, 2, 0), dir.Unit * 30, rayParams)
                            if hit and hit.Distance < 22 then
                                local toCenter = arena.center - myPos
                                toCenter = Vector3.new(toCenter.X, 0, toCenter.Z)
                                local blend = (dir.Unit + toCenter.Unit * 2.5).Unit
                                tpos = myPos + blend * math.min(dir.Magnitude, 20)
                            end

                            if now - lastMove > 0.15 then
                                lastMove = now
                                local d = Vector3.new(tpos.X - myPos.X, 0, tpos.Z - myPos.Z)
                                walk.lookDir = d.Unit
                                walk.shouldMove = true
                                walk.moveSpeed = 10
                            end
                        else
                            if walk.ang == nil or (walk.nextRetarget and now > walk.nextRetarget) then
                                walk.ang = (walk.ang or math.random() * math.pi * 2) + (math.random() - 0.5) * 1.6
                                walk.nextRetarget = now + 2 + math.random() * 3
                            end
                            local ang = walk.ang
                            local tpos = arena.center + Vector3.new(math.cos(ang) * targetR, 0, math.sin(ang) * targetR)
                            if now - lastMove > 0.15 then
                                lastMove = now
                                walk.lookDir = Vector3.new(tpos.X - myPos.X, 0, tpos.Z - myPos.Z).Unit
                                walk.shouldMove = true
                                walk.moveSpeed = 10
                            end
                        end
                    end
                end
            else
                if hum and root and now - lastMove > 0.5 then
                    lastMove = now
                    walk.shouldMove = false
                end
            end
            task.wait(0.2)
        end
    end)

    task.spawn(function()
        local keys = { W = 87, A = 65, S = 83, D = 68 }
        local held = { W = false, A = false, S = false, D = false }
        local function setKey(name, down)
            if down == held[name] then return end
            held[name] = down
            if down then pcall(realKeypress, keys[name]) else pcall(realKeyrelease, keys[name]) end
        end
        walk.moveConn = RunService.RenderStepped:Connect(function()
            local look = walk.lookDir
            if not look or not walk.shouldMove then
                setKey("W", false); setKey("A", false); setKey("S", false); setKey("D", false)
                return
            end
            local jx = (math.random() - 0.5) * 0.35
            local jz = (math.random() - 0.5) * 0.35
            look = (look + Vector3.new(jx, 0, jz)).Unit

            local cam = workspace.CurrentCamera
            local cf = cam.CFrame
            local fwd = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z).Unit
            local rgt = Vector3.new(cf.RightVector.X, 0, cf.RightVector.Z).Unit
            local fComp = look:Dot(fwd)
            local rComp = look:Dot(rgt)
            setKey("W", fComp > 0.25)
            setKey("S", fComp < -0.25)
            setKey("D", rComp > 0.25)
            setKey("A", rComp < -0.25)
        end)
    end)

    local jumpHeld = false
    task.spawn(function()
        while walk.running do
            local lala = _G.autoParry or {}
            local want = lala.autoplay and lala.apJump ~= false and inMatch()
            if want and not jumpHeld then
                pcall(realKeypress, 32)
                jumpHeld = true
            elseif not want and jumpHeld then
                pcall(realKeyrelease, 32)
                jumpHeld = false
            end
            task.wait(0.2)
        end
        if jumpHeld then pcall(realKeyrelease, 32) end
    end)

    walk.camConn = nil
    task.spawn(function()
        local cam = workspace.CurrentCamera
        while walk.running do
            local lala = _G.autoParry or {}
            if lala.autoplay and inMatch() then
                local ch = lp.Character
                local root = ch and ch:FindFirstChild("HumanoidRootPart")
                if root and cam then
                    pcall(function()
                        cam.CFrame = CFrame.lookAt(root.Position + Vector3.new(0, 45, 0), root.Position)
                    end)
                end
            end
            task.wait(0.1)
        end
    end)

    walk.aimPos = nil
    walk.nextAimAt = 0
    task.spawn(function()
        local lastScan = 0
        while walk.running do
            local lala = _G.autoParry or {}
            local now = tick()
            if lala.autoplay and lala.apAim ~= false and inMatch() then
                if now - lastScan > 0.3 then
                    lastScan = now
                    local cands = {}
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= lp then
                            local ch = plr.Character
                            local h = ch and ch:FindFirstChild("Head")
                            if h then cands[#cands + 1] = h.Position end
                        end
                    end
                    if #cands > 0 and (walk.aimPos == nil or now > walk.nextAimAt) then
                        walk.aimPos = cands[math.random(1, #cands)]
                        walk.nextAimAt = now + 1.5
                    end
                end
            else
                walk.aimPos = nil
            end
            task.wait(0.1)
        end
    end)
    walk.aimConn = RunService.RenderStepped:Connect(function()
        local lala = _G.autoParry or {}
        if not (lala.autoplay and lala.apAim ~= false and inMatch()) then return end
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local cs, con = WorldToScreen(root.Position)
        if not con or not cs then return end
        local edge = root.Position + Vector3.new(RING, 0, 0)
        local es, eon = WorldToScreen(edge)
        if not (eon and es) then return end
        local ringPx = math.sqrt((es.X - cs.X) ^ 2 + (es.Y - cs.Y) ^ 2)
        if ringPx < 1 then return end

        local visCount = 0
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= lp then
                local h = plr.Character and plr.Character:FindFirstChild("Head")
                if h then
                    local sp, ov = WorldToScreen(h.Position)
                    if ov and sp then visCount = visCount + 1 end
                end
            end
        end

        local tx, ty
        if visCount >= 2 and walk.aimPos then
            local sp = WorldToScreen(walk.aimPos + Vector3.new(0, 0.5, 0))
            if sp then
                local vx = sp.X - cs.X
                local vy = sp.Y - cs.Y
                local L = math.sqrt(vx * vx + vy * vy)
                if L < 1 then L = 1 end
                if L > ringPx then
                    tx = cs.X + vx / L * ringPx
                    ty = cs.Y + vy / L * ringPx
                else
                    tx, ty = sp.X, sp.Y
                end
            end
        end
        if not tx then
            walk.aimAng = (walk.aimAng or 0) + 0.03
            local ang = walk.aimAng
            tx = cs.X + math.cos(ang) * ringPx
            ty = cs.Y + math.sin(ang) * ringPx
        end
        pcall(mousemoveabs, tx, ty)
    end)

    local wasLobby = false
    task.spawn(function()
        local cam = workspace.CurrentCamera
        while walk.running do
            local inLobby = not inMatch()
            if inLobby and not wasLobby then
                wasLobby = true
                task.wait(2)
                local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                local target = root and root.Position
                if not target and cam then
                    target = cam.CFrame.Position - cam.CFrame.LookVector * 10
                end
                if target and cam then
                    local startPos = cam.CFrame.Position
                    local endIn = target + Vector3.new(0, 2, 0)
                    local t0 = tick()
                    while walk.running and tick() - t0 < 1.0 do
                        local k = (tick() - t0) / 1.0
                        local pos = startPos:Lerp(endIn, k)
                        pcall(function() cam.CFrame = CFrame.lookAt(pos, target) end)
                        task.wait(0.02)
                    end
                    t0 = tick()
                    while walk.running and tick() - t0 < 2.0 do
                        local k = (tick() - t0) / 2.0
                        local h = 2 + (45 - 2) * k
                        pcall(function() cam.CFrame = CFrame.lookAt(target + Vector3.new(0, h, 0), target) end)
                        task.wait(0.02)
                    end
                    pcall(function() cam.CFrame = CFrame.lookAt(target + Vector3.new(0, 45, 0), target) end)
                end
            elseif not inLobby then
                wasLobby = false
            end
            task.wait(0.2)
        end
    end)
end)

print("remys bladeball")
end

do
loadstring(game:HttpGet("https://raw.githubusercontent.com/SxGoldenxS/REM-UI/main/rem_v6-matcha.lua"))()
local UI = Rem
assert(UI and UI.Alive, "Rem UI failed to load")

local lala = _G.autoParry or {}
local hs = game:GetService("HttpService")
local UI_CFG = "remybbui-config.json"
local DEFAULT_MENU_KEY = 0xA1
_G.__remyMenuGen = (_G.__remyMenuGen or 0) + 1

local COLORS = {
    { "White", Color3.fromRGB(255, 255, 255) },
    { "Red", Color3.fromRGB(255, 60, 60) },
    { "Black", Color3.fromRGB(10, 10, 10) },
    { "Pink", Color3.fromRGB(255, 150, 200) },
    { "Orange", Color3.fromRGB(255, 165, 0) },
    { "Yellow", Color3.fromRGB(255, 255, 0) },
    { "Lime", Color3.fromRGB(50, 255, 50) },
    { "Cyan", Color3.fromRGB(0, 255, 255) },
    { "Light Blue", Color3.fromRGB(80, 160, 255) },
    { "Blue", Color3.fromRGB(0, 120, 255) },
    { "Purple", Color3.fromRGB(150, 80, 255) },
    { "Magenta", Color3.fromRGB(255, 0, 255) },
    { "Gold", Color3.fromRGB(255, 215, 0) },
    { "Teal", Color3.fromRGB(0, 200, 180) },
    { "Green", Color3.fromRGB(0, 200, 80) },
}

local KEY_NAMES = {
    [8] = "Backspace", [9] = "Tab", [13] = "Enter", [16] = "Shift", [17] = "Ctrl", [18] = "Alt",
    [20] = "Caps Lock", [32] = "Space", [33] = "Page Up", [34] = "Page Down", [35] = "End", [36] = "Home",
    [37] = "Left", [38] = "Up", [39] = "Right", [40] = "Down", [45] = "Insert", [46] = "Delete",
    [160] = "LShift", [161] = "RShift", [162] = "LCtrl", [163] = "RCtrl", [164] = "LAlt", [165] = "RAlt",
    [186] = ";", [187] = "=", [188] = ",", [189] = "-", [190] = ".", [191] = "/", [192] = "`",
    [219] = "[", [220] = "\\", [221] = "]", [222] = "'",
}
local BLOCKED_KEYS = { [87] = true, [65] = true, [83] = true, [68] = true }

local function num(v, d) return type(v) == "number" and v or d end
local function boo(v, d) return type(v) == "boolean" and v or d end

local function keyText(k)
    k = tonumber(k)
    if not k or k <= 0 then return "None" end
    if KEY_NAMES[k] then return KEY_NAMES[k] end
    if (k >= 48 and k <= 57) or (k >= 65 and k <= 90) then return string.char(k) end
    if k >= 112 and k <= 135 then return "F" .. (k - 111) end
    if k >= 96 and k <= 105 then return "Num " .. (k - 96) end
    return "Key " .. k
end

local function rgbOf(c)
    return { r = math.floor(c.R * 255 + 0.5), g = math.floor(c.G * 255 + 0.5), b = math.floor(c.B * 255 + 0.5) }
end

local function sameRgb(a, b)
    return type(a) == "table" and type(b) == "table"
        and tonumber(a.r) == tonumber(b.r) and tonumber(a.g) == tonumber(b.g) and tonumber(a.b) == tonumber(b.b)
end

local function leadForPing(pingMs)
    local tiers = lala.pingTiers or { 30, 50, 70, 120, 170 }
    local leads = lala.pingLead or { 0.34, 0.38, 0.44, 0.52, 0.58, 0.64 }
    for i = 1, #tiers do
        if pingMs <= tiers[i] then return leads[i] end
    end
    return leads[#leads]
end

local function cfgData()
    local L = _G.autoParry
    if not L then return nil end
    return {
        _version = 2,
        keyP = L.keyP, keyV = L.keyV, keyC = L.keyC, keyX = L.keyX,
        keyL = L.keyL, keyB = L.keyB, keyR = L.keyR, keyN = L.keyN, keyG = L.keyG,
        keyT = L.keyT, keySmart = L.keySmart, keyPanic = L.keyPanic,
        v2 = L.v2, autoplay = L.autoplay, abilityParry = L.abilityParry,
        abilityEsp = L.abilityEsp, abilityUpgradeEsp = L.abilityUpgradeEsp, accuracy = L.accuracy, randomize = L.randomize,
        pingComp = L.pingComp, leadTime = L.leadTime, pingMax = L.pingMax,
        customLeadMode = L.customLeadMode, customLeadValue = L.customLeadValue,
        accelLead = L.accelLead, fastFrame1 = L.fastFrame1, fastBallThreshold = L.fastBallThreshold,
        minDist = L.minDist, maxDist = L.maxDist, panicBase = L.panicBase,
        panicSpeedMul = L.panicSpeedMul, cooldown = L.cooldown, perBallCooldown = L.perBallCooldown,
        maxSpeed = L.maxSpeed, closeRangeDist = L.closeRangeDist,
        facingMin = L.facingMin, customFacingMinMode = L.customFacingMinMode, customFacingMinValue = L.customFacingMinValue,
        showVis = L.showVis, dome = L.dome, cone = L.cone, clash = L.clash,
        viewEnabled = L.viewEnabled, parryDistInd = L.parryDistInd,
        uiKey = UI.Keybind,
        uiTheme2 = UI.Theme,
        uiBackground = UI.Background,
    }
end

local lastSnap = hs:JSONEncode(cfgData() or {})
local pendingSave = false
local lastSaveT = 0

local function flushSave()
    if not pendingSave then return end
    if tick() - lastSaveT < 0.5 then return end
    pendingSave = false
    lastSaveT = tick()
    local data = cfgData()
    if not data then return end
    pcall(function() writefile(UI_CFG, hs:JSONEncode(data)) end)
    if _G.remybbSaveConfig then pcall(_G.remybbSaveConfig) end
    lastSnap = hs:JSONEncode(data)
end

local function saveUI()
    pendingSave = true
end

local savedTheme = nil
local savedBackground = nil
local function loadUI()
    pcall(function()
        if not isfile(UI_CFG) then return end
        local data = hs:JSONDecode(readfile(UI_CFG))
        if type(data) ~= "table" then return end
        for k, v in pairs(data) do
            if k ~= "_version" and k ~= "uiKey" and k ~= "uiTheme" and k ~= "uiTheme2" and k ~= "uiBackground" and k ~= "uiAccent" and k ~= "uiTrans" and k ~= "hideCard" and k ~= "blurName" then
                lala[k] = v
            end
        end
        if type(data.uiKey) == "number" and data.uiKey ~= 27 then
            pcall(function() UI:SetKeybind(data.uiKey) end)
        end
        if type(data.uiTheme2) == "string" then savedTheme = data.uiTheme2 end
        if type(data.uiBackground) == "string" then savedBackground = data.uiBackground end
    end)
end
loadUI()

local themeControl = nil
local backgroundControl = nil
for _, c in ipairs(UI.Settings.Controls) do
    if c.Kind == "dropdown" and c.Title == "Theme" then themeControl = c end
    if c.Kind == "dropdown" and c.Title == "Background" then backgroundControl = c end
end
local function applyTheme(name)
    if UI:SetTheme(name) and themeControl then
        pcall(function() themeControl:SetValue(UI.Theme, true) end)
    end
end
if savedTheme then applyTheme(savedTheme) end
if savedBackground and backgroundControl and table.find(backgroundControl.Options, savedBackground) then
    pcall(function() backgroundControl:SetValue(savedBackground) end)
end

_G._genUIKey = UI.Keybind

local ELS = {}
local COLS = {}
local BINDS = {}
local unloaded = false

local function Toggle(tab, title, desc, field)
    local ctrl = tab:AddToggle({
        Title = title,
        Description = desc,
        Default = boo(lala[field], false),
        Callback = function(v)
            lala[field] = v
            saveUI()
        end,
    })
    ELS[field] = { ctrl = ctrl, kind = "toggle" }
    return ctrl
end

local function Slider(tab, title, desc, field, min, max, step, fallback)
    local ctrl = tab:AddSlider({
        Title = title,
        Description = desc,
        Min = min,
        Max = max,
        Step = step,
        Default = math.clamp(num(lala[field], fallback), min, max),
        Callback = function(v)
            lala[field] = v
            saveUI()
        end,
    })
    ELS[field] = { ctrl = ctrl, kind = "slider" }
    return ctrl
end

local function colorChoice(field, fallback)
    local cur = lala[field]
    local def = (_G.remybbDefaults and _G.remybbDefaults[field]) or fallback
    if sameRgb(cur, def) then return "Default" end
    for _, p in ipairs(COLORS) do
        if sameRgb(cur, rgbOf(p[2])) then return p[1] end
    end
    return "Custom"
end

local function ColorPick(tab, title, desc, field, fallback)
    local options = { "Default" }
    for _, p in ipairs(COLORS) do options[#options + 1] = p[1] end
    options[#options + 1] = "Custom"
    local ctrl = tab:AddDropdown({
        Title = title,
        Description = desc,
        Options = options,
        Default = colorChoice(field, fallback),
        Callback = function(v)
            if v == "Custom" then return end
            if v == "Default" then
                local def = (_G.remybbDefaults and _G.remybbDefaults[field]) or fallback
                lala[field] = { r = def.r, g = def.g, b = def.b }
                saveUI()
                return
            end
            for _, p in ipairs(COLORS) do
                if p[1] == v then
                    lala[field] = rgbOf(p[2])
                    saveUI()
                    return
                end
            end
        end,
    })
    COLS[field] = { ctrl = ctrl, fallback = fallback }
    return ctrl
end

local capturing = false
local function captureKey(field, ctrl)
    if capturing then return end
    capturing = true
    ctrl.ButtonText = "..."
    local held = {}
    for k = 8, 254 do held[k] = iskeypressed(k) end
    local pressed = nil
    local deadline = tick() + 6
    while UI.Alive and not unloaded and tick() < deadline do
        task.wait()
        for k = 8, 254 do
            local h = iskeypressed(k)
            if h and not held[k] and k ~= 16 and k ~= 17 and k ~= 18 then
                pressed = k
                break
            end
            held[k] = h
        end
        if pressed then break end
    end
    if pressed then
        while UI.Alive and iskeypressed(pressed) do task.wait() end
    end
    if not pressed or pressed == 27 then
        UI:Notify({ Title = "Keybind", Content = "Cancelled.", Type = "info", Duration = 2 })
    elseif pressed == 8 or pressed == 46 then
        lala[field] = nil
        saveUI()
        UI:Notify({ Title = "Keybind", Content = "Key removed.", Type = "success", Duration = 2 })
    elseif not ((pressed >= 65 and pressed <= 90) or (pressed >= 48 and pressed <= 57)) then
        UI:Notify({ Title = "Keybind", Content = "Use a letter or number key.", Type = "error", Duration = 3 })
    elseif BLOCKED_KEYS[pressed] then
        UI:Notify({ Title = "Keybind", Content = "W A S D are movement keys.", Type = "error", Duration = 3 })
    elseif pressed == UI.Keybind then
        UI:Notify({ Title = "Keybind", Content = "That key opens the menu.", Type = "error", Duration = 3 })
    else
        local taken = nil
        for _, b in ipairs(BINDS) do
            if b.field ~= field and lala[b.field] == pressed then taken = b.title break end
        end
        if taken then
            UI:Notify({ Title = "Keybind", Content = keyText(pressed) .. " is used by " .. taken .. ".", Type = "error", Duration = 3 })
        else
            lala[field] = pressed
            saveUI()
            UI:Notify({ Title = "Keybind", Content = "Set to " .. keyText(pressed) .. ".", Type = "success", Duration = 2 })
        end
    end
    ctrl.ButtonText = keyText(lala[field])
    capturing = false
end

local function Bind(tab, title, field)
    local ctrl
    ctrl = tab:AddButton({
        Title = title,
        Description = "Click, then a letter. Del clears.",
        ButtonText = keyText(lala[field]),
        Icon = "key",
        Callback = function()
            captureKey(field, ctrl)
        end,
    })
    BINDS[#BINDS + 1] = { ctrl = ctrl, field = field, title = title }
    return ctrl
end

local function unloadAll()
    if unloaded then return end
    unloaded = true
    _G.__apGen = (_G.__apGen or 0) + 1
    if _G.__apCleanup then pcall(_G.__apCleanup) end
    for _, name in ipairs({ "__apHB", "__apConn", "__apRS" }) do
        local c = _G[name]
        if c then pcall(c.Disconnect, c) end
        _G[name] = nil
    end
    local release = _G.__apRealKeyrelease or keyrelease
    pcall(function()
        for _, k in ipairs({ 87, 65, 83, 68, 32 }) do release(k) end
    end)
    pcall(function()
        if _G.__apRealKeypress then _G.keypress = _G.__apRealKeypress end
        if _G.__apRealKeyrelease then _G.keyrelease = _G.__apRealKeyrelease end
    end)
    if UI.Alive then pcall(function() UI:Destroy() end) end
    if _G._genToken and _G._genToken.unload == unloadAll then _G._genToken = nil end
    _G.remybbMenu = nil
    _G.autoParry = nil
end
_G._genToken = { unload = unloadAll }

local function menuKeyLine()
    return "Open and close the menu with " .. keyText(UI.Keybind) .. ". Change it in Settings."
end
local homeLabel = UI.Home:AddLabel({
    Title = "remys bladeball",
    Description = menuKeyLine(),
})

local autoLead, customLead, autoCurve, customCurve, viewDD, parryTab

do
    local parry = UI:AddTab({ Title = "Parry", Icon = "shield" })
    parryTab = parry
    Toggle(parry, "Autoparry", "Parries the ball for you.", "v2")
    Toggle(parry, "Smart Parry", "Parries late, scaled to ball speed.", "smartParry")
    Toggle(parry, "Clash", "Spam parry in close clashes.", "clash")
    Toggle(parry, "Ability Parry", "Uses your ability to parry.", "abilityParry")
    Toggle(parry, "Panic Parry", "Parries when the ball is too close.", "panicParry")
    Toggle(parry, "Triggerbot", "Parries when the ball targets you.", "triggerbot")
    Toggle(parry, "Triggerbot Once", "Turns off after one parry.", "triggerOnce")
    Toggle(parry, "Training Ball", "Also parries training balls.", "trainingBall")

    local timing = UI:AddTab({ Title = "Timing", Icon = "sliders" })
    autoLead = timing:AddToggle({
        Title = "Auto-lead",
        Description = "Lead time from your ping.",
        Default = (not boo(lala.customLeadMode, false)) and boo(lala.pingComp, false),
        Callback = function(v)
            if v then
                lala.pingComp = true
                lala.customLeadMode = false
            else
                lala.pingComp = false
            end
            saveUI()
        end,
    })
    customLead = timing:AddToggle({
        Title = "Custom-lead",
        Description = "Use your own lead time.",
        Default = boo(lala.customLeadMode, false),
        Callback = function(v)
            if v then
                lala.customLeadMode = true
                lala.pingComp = false
            else
                lala.customLeadMode = false
            end
            saveUI()
        end,
    })
    Slider(timing, "Custom Lead Value", "Seconds early to parry.", "customLeadValue", 0.05, 1, 0.01, 0.10)
    autoCurve = timing:AddToggle({
        Title = "Auto Anti-Curve",
        Description = "Handles curved balls for you.",
        Default = not boo(lala.customFacingMinMode, false),
        Callback = function(v)
            lala.customFacingMinMode = not v
            saveUI()
        end,
    })
    customCurve = timing:AddToggle({
        Title = "Custom Anti-Curve",
        Description = "Use your own curve value.",
        Default = boo(lala.customFacingMinMode, false),
        Callback = function(v)
            lala.customFacingMinMode = v
            saveUI()
        end,
    })
    Slider(timing, "Custom Anti-Curve Value", "Lower = parries more curves.", "customFacingMinValue", -1, 0, 0.01, -0.35)
    Toggle(timing, "Infinity Avoid", "Skips parry during Infinity.", "infinityAvoid")
    Toggle(timing, "Singularity Avoid", "Skips parry during Singularity.", "singularityDetect")

    local accuracy = UI:AddTab({ Title = "Accuracy", Icon = { { 10, 1, 10, 7 }, { 10, 13, 10, 19 }, { 1, 10, 7, 10 }, { 13, 10, 19, 10 }, { 9, 10, 11, 10 } } })
    Slider(accuracy, "Parry Accuracy", "Chance to parry, in percent.", "accuracy", 1, 100, 1, 100)
    Toggle(accuracy, "Randomize", "Random accuracy each parry.", "randomize")
    Slider(accuracy, "Randomize Min", "Lowest random accuracy.", "randMin", 1, 99, 1, 20)
    Slider(accuracy, "Randomize Max", "Highest random accuracy.", "randMax", 2, 100, 1, 100)
    Toggle(accuracy, "Show Above Head", "Shows accuracy over you.", "accHead")
    Slider(accuracy, "Minimum Distance", "Closest parry distance.", "minDist", 1, 100, 1, 16)
    Slider(accuracy, "Maximum Distance", "Farthest parry distance.", "maxDist", 50, 2000, 1, 400)
    Slider(accuracy, "Panic Range", "Distance for panic parry.", "panicBase", 5, 100, 1, 28)
    Slider(accuracy, "Panic Speed", "Extra panic range per speed.", "panicSpeedMul", 0.01, 0.2, 0.01, 0.08)

    local play = UI:AddTab({ Title = "Autoplay", Icon = "power" })
    Toggle(play, "Autoplay", "Plays the round for you.", "autoplay")
    Toggle(play, "Auto Walk", "Walks around while autoplaying.", "apWalk")
    Toggle(play, "Auto Jump", "Jumps while autoplaying.", "apJump")
    Toggle(play, "Auto Aim", "Aims while autoplaying.", "apAim")
end

do
    local vis = UI:AddTab({ Title = "Visuals", Icon = "palette" })
    Toggle(vis, "Ball Visuals", "Trail and labels on the ball.", "bvExtras")
    Toggle(vis, "Ball Curve", "Shows where the ball curves.", "showVis")
    ColorPick(vis, "Trail Start", "Color at the start of the trail.", "bvColor", { r = 0, g = 255, b = 0 })
    ColorPick(vis, "Trail End", "Color at the end of the trail.", "bvEnd", { r = 255, g = 0, b = 0 })
    Slider(vis, "Trail Length", "How long the trail is.", "bvLen", 20, 100, 1, 100)
    Slider(vis, "Trail Thickness", "How thick the trail is.", "bvThick", 1, 14, 1, 6)
    Toggle(vis, "Distance Label", "Shows ball distance.", "bvDist")
    Toggle(vis, "Speed Label", "Shows ball speed.", "bvSpeed")
    Toggle(vis, "Target Line", "Line to who the ball targets.", "bvTarget")
    Toggle(vis, "Mini Radar", "Small radar of players.", "bvRadar")

    local apv = UI:AddTab({ Title = "Parry Visuals", Icon = "layers" })
    if lala.parryDistInd == nil then lala.parryDistInd = true end
    local viewSel = "Off"
    if lala.viewEnabled ~= false then
        viewSel = lala.cone and "Cone" or "Circle"
    end
    viewDD = apv:AddDropdown({
        Title = "View",
        Description = "Shape of the parry view.",
        Options = { "Off", "Circle", "Cone" },
        Default = viewSel,
        Callback = function(sel)
            if sel == "Off" then
                lala.viewEnabled = false
            elseif sel == "Circle" then
                lala.viewEnabled = true
                lala.cone = false
            else
                lala.viewEnabled = true
                lala.cone = true
            end
            saveUI()
        end,
    })
    ColorPick(apv, "AP Color", "Color of the parry view.", "apColor", { r = 0, g = 255, b = 120 })
    Slider(apv, "AP Thickness", "Parry view line thickness.", "apThick", 1, 8, 1, 2)
    Slider(apv, "AP Transparency", "Parry view see-through amount.", "apTrans", 0, 100, 1, 5)
    Toggle(apv, "Parry Distance Indicator", "Shows your parry distance.", "parryDistInd")
    ColorPick(apv, "Indicator Color", "Color of the indicator.", "pdColor", { r = 255, g = 0, b = 0 })
    Slider(apv, "Indicator Thickness", "Indicator line thickness.", "pdThick", 1, 8, 1, 3)
    Slider(apv, "Indicator Transparency", "Indicator see-through amount.", "pdTrans", 0, 100, 1, 15)
    Toggle(apv, "Ability ESP", "Shows each player's ability.", "abilityEsp")
    Toggle(apv, "Ability Upgrade ESP", "Shows ability upgrades.", "abilityUpgradeEsp")
end

do
    local keys = UI:AddTab({ Title = "Keybinds", Icon = "key" })
    Toggle(keys, "Keybinds List", "Shows your binds on screen.", "keybindsHud")
    Bind(keys, "Autoparry", "keyP")
    Bind(keys, "Smart Parry", "keySmart")
    Bind(keys, "Clash", "keyX")
    Bind(keys, "Ability Parry", "keyB")
    Bind(keys, "Panic Parry", "keyPanic")
    Bind(keys, "Triggerbot", "keyT")
    Bind(keys, "Custom-lead", "keyL")
    Bind(keys, "Custom Anti-Curve", "keyN")
    Bind(keys, "Randomize", "keyR")
    Bind(keys, "Autoplay", "keyG")
    Bind(keys, "Ball Visuals", "keyV")
end

do
    local set = UI.Settings
    local slots = (_G.remybbProfiles and _G.remybbProfiles.slots) or { "1" }
    local profSlot = slots[1]
    set:AddDropdown({
        Title = "Config Slot",
        Description = "Pick a slot to save or load.",
        Options = slots,
        Default = profSlot,
        Callback = function(v)
            profSlot = v
        end,
    })
    set:AddButton({
        Title = "Save To Slot",
        Description = "Saves your settings to the slot.",
        ButtonText = "Save",
        Callback = function()
            if _G.remybbProfiles and _G.remybbProfiles.save(profSlot) then
                if _G.remybbSaveConfig then pcall(_G.remybbSaveConfig) end
                UI:Notify({ Title = "Config", Content = "Saved to slot " .. profSlot .. ".", Type = "success", Duration = 2 })
            else
                UI:Notify({ Title = "Config", Content = "Could not save slot " .. profSlot .. ".", Type = "error", Duration = 3 })
            end
        end,
    })
    set:AddButton({
        Title = "Load Slot",
        Description = "Loads settings from the slot.",
        ButtonText = "Load",
        Callback = function()
            if _G.remybbProfiles and _G.remybbProfiles.load(profSlot) then
                saveUI()
                UI:Notify({ Title = "Config", Content = "Loaded slot " .. profSlot .. ".", Type = "success", Duration = 2 })
            else
                UI:Notify({ Title = "Config", Content = "Slot " .. profSlot .. " is empty.", Type = "error", Duration = 2 })
            end
        end,
    })
    set:AddButton({
        Title = "Reset All Settings",
        Description = "Puts every setting back to default.",
        ButtonText = "Reset",
        Callback = function()
            local d = _G.remybbDefaults
            if d then
                for k, v in pairs(d) do
                    if type(v) == "table" then
                        local c = {}
                        for k2, v2 in pairs(v) do c[k2] = v2 end
                        lala[k] = c
                    else
                        lala[k] = v
                    end
                end
            end
            for field, rec in pairs(ELS) do
                if rec.kind == "toggle" then lala[field] = false end
            end
            lala.customLeadMode = false
            lala.pingComp = true
            lala.customFacingMinMode = false
            lala.viewEnabled = false
            applyTheme("Rimuru")
            if backgroundControl then pcall(function() backgroundControl:SetValue("Rimuru") end) end
            pcall(function() UI:SetKeybind(DEFAULT_MENU_KEY) end)
            for _, b in ipairs(BINDS) do b.ctrl.ButtonText = keyText(lala[b.field]) end
            if _G.remybbSaveConfig then pcall(_G.remybbSaveConfig) end
            saveUI()
            UI:Notify({ Title = "Settings", Content = "All settings reset to defaults.", Type = "success", Duration = 2 })
        end,
    })
    set:AddButton({
        Title = "Unload Script",
        Description = "Turns everything off and closes.",
        ButtonText = "Unload",
        Callback = function()
            UI:Notify({ Title = "remys bladeball", Content = "Unloading script.", Type = "info", Duration = 1 })
            task.wait(0.4)
            unloadAll()
        end,
    })
end

_G.remybbMenu = UI

local function syncOnce()
    _G._genUIKey = UI.Keybind
    local keyLine = menuKeyLine()
    if homeLabel.Description ~= keyLine then homeLabel.Description = keyLine end
    local snap = hs:JSONEncode(cfgData() or {})
    if snap ~= lastSnap then saveUI() end
    flushSave()

    for field, rec in pairs(ELS) do
        local c = rec.ctrl
        local lv = lala[field]
        if rec.kind == "toggle" then
            if type(lv) == "boolean" and lv ~= c.Value then c:SetValue(lv, true) end
        elseif type(lv) == "number" and math.abs(lv - c.Value) > c.Step * 0.5 then
            c:SetValue(lv, true)
        end
    end

    local autoOn = (not boo(lala.customLeadMode, false)) and boo(lala.pingComp, false)
    if autoLead.Value ~= autoOn then autoLead:SetValue(autoOn, true) end
    if autoOn then
        local ping = 0
        pcall(function() ping = GetPingValue() or 0 end)
        autoLead.Description = "Leading by " .. string.format("%.2f", leadForPing(ping)) .. "s right now."
    else
        autoLead.Description = "Lead time from your ping."
    end

    local customOn = boo(lala.customLeadMode, false)
    if customLead.Value ~= customOn then customLead:SetValue(customOn, true) end

    local curveAuto = not boo(lala.customFacingMinMode, false)
    if autoCurve.Value ~= curveAuto then autoCurve:SetValue(curveAuto, true) end
    if curveAuto then
        autoCurve.Description = "Curve value now " .. string.format("%.2f", num(lala.facingMin, -0.35)) .. "."
    else
        autoCurve.Description = "Handles curved balls for you."
    end
    if customCurve.Value ~= not curveAuto then customCurve:SetValue(not curveAuto, true) end

    local sel
    if lala.viewEnabled == false then
        sel = "Off"
    elseif lala.cone then
        sel = "Cone"
    else
        sel = "Circle"
    end
    if viewDD.Value ~= sel then viewDD:SetValue(sel, true) end

    for field, rec in pairs(COLS) do
        local want = colorChoice(field, rec.fallback)
        if rec.ctrl.Value ~= want then rec.ctrl:SetValue(want, true) end
    end

    if not capturing then
        for _, b in ipairs(BINDS) do
            local t = keyText(lala[b.field])
            if b.ctrl.ButtonText ~= t then b.ctrl.ButtonText = t end
        end
    end
end

task.spawn(function()
    while UI.Alive and not unloaded do
        pcall(syncOnce)
        task.wait(0.1)
    end
    unloadAll()
end)

parryTab:Select()
end

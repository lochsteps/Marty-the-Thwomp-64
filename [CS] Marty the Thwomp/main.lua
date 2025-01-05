-- name: [CS] Marty the Thwomp
-- description: A Template for Character Select to build off of when making your own pack!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/wiki/API-Documentation

    Use this if you're curious on how anything here works >v<
]]

local TEXT_MOD_NAME = "Marty the Thwomp"

-- Stops mod from loading if Character Select isn't on
if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("marty_geo") -- Located in "actors"

local TEX_CUSTOM_LIFE_ICON = get_texture_info("martyicon") -- Located in "textures"
local TEX_CUSTOM_STAR_ICON = get_texture_info("staricon") -- Located in "textures"

-- All Located in "sound"
local VOICETABLE_MARTY = {
    [CHAR_SOUND_ATTACKED] = 'NES-Hit.ogg',
    [CHAR_SOUND_DOH] = 'NES-Hit.ogg',
    [CHAR_SOUND_DROWNING] = 'NES-Hit.ogg',
    [CHAR_SOUND_DYING] = 'NES-Hit.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'NES-Hit.ogg',
    [CHAR_SOUND_HAHA] = 'NES-Hit.ogg',
    [CHAR_SOUND_HAHA_2] = 'NES-Hit.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'NES-Flagpole.ogg',
    [CHAR_SOUND_HOOHOO] = 'NES-Hit.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'NES-Hit.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'NES-Hit.ogg',
    [CHAR_SOUND_ON_FIRE] = 'NES-Flagpole.ogg',
    [CHAR_SOUND_OOOF] = 'NES-Hit.ogg',
    [CHAR_SOUND_OOOF2] = 'NES-Hit.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'NES-Hit.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'NES-Hit.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'NES-Hit.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'NES-Flagpole.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'NES-Flagpole.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'NES-Hit.ogg',
    [CHAR_SOUND_WAH2] = 'NES-Hit.ogg',
    [CHAR_SOUND_WHOA] = 'NES-Hit.ogg',
    [CHAR_SOUND_YAHOO] = 'NES-Hit.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'NES-Hit.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'NES-Hit.ogg',
    [CHAR_SOUND_YAWNING] = 'NES-Hit.ogg',
}

-- All Located in "actors"
local CAPTABLE_CHAR = {
    normal = smlua_model_util_get_id("martynormal_geo"),
    wing = smlua_model_util_get_id("martywing_geo"),
    metal = smlua_model_util_get_id("martycapmetal_geo"),
    metalWing = smlua_model_util_get_id("martycapwing_geo"),
}

local E_MODEL_CUSTOM_STAR = smlua_model_util_get_id("custom_model_star_geo") -- Located in "actors"

local PALETTE_CHAR = {
    [PANTS]  = "ffffff",
    [SHIRT]  = "ffffff",
    [GLOVES] = "ffffff",
    [SHOES]  = "ffffff",
    [HAIR]   = "ffffff",
    [SKIN]   = "ffffff",
    [CAP]    = "ffffff",
}

--[[
-- All Located in "textures"
local healthMeter = {
    label = {
        left = get_texture_info("template-hp-back-left"),
        right = get_texture_info("template-hp-back-right"),
    },
    pie = {
        [1] = get_texture_info("template-hp-pie-1"),
        [2] = get_texture_info("template-hp-pie-2"),
        [3] = get_texture_info("template-hp-pie-3"),
        [4] = get_texture_info("template-hp-pie-4"),
        [5] = get_texture_info("template-hp-pie-5"),
        [6] = get_texture_info("template-hp-pie-6"),
        [7] = get_texture_info("template-hp-pie-7"),
        [8] = get_texture_info("template-hp-pie-8"),
    }
}
]]

--[[
    Note: If there are some functionalities you don't care
    to add such as palettes, you can freely remove the function
    for it, the only function you require is character_add
]]

local CSloaded = false
local function on_character_select_load()
    CT_CHAR = _G.charSelect.character_add("Marty the Thwomp", {"That one jailed Thwomp", "from Mario Kart."}, "Nessie", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO, TEX_CUSTOM_LIFE_ICON)
    _G.charSelect.character_add_caps(E_MODEL_CUSTOM_MODEL, CAPTABLE_MARTY)
    _G.charSelect.character_add_voice(E_MODEL_CUSTOM_MODEL, VOICETABLE_MARTY)
    _G.charSelect.character_add_palette_preset(E_MODEL_CUSTOM_MODEL, PALETTE_CHAR)
    --_G.charSelect.character_add_health_meter(CT_CHAR, healthMeter)

    CSloaded = true
end

local function on_character_sound(m, sound)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_MARTY then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if not CSloaded then return end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_MARTY then return _G.charSelect.voice.snore(m) end
end

hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)
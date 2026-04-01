-- name: [CS] Frickbear Guard Pack
-- description: "Hey! This isn't Freddy Frickbear's Pizzeria!"\n\nYou can now play as Mike Schmidt and Vanessa Shelly based on their designs from Five Nights At Frickbear's 3 in this Coop Deluxe mod! Will you survive these 5 nigh- I mean... will you survive one adventure to save Princess Peach?\n\nMade by: VioletSM64\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local TEXT_MOD_NAME = get_active_mod().name

-- Stops mod from loading if Character Select isn't on, Does not need to be touched
if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

local E_MODEL_MIKE = smlua_model_util_get_id("mike_violet_geo")      -- Located in "actors"
local E_MODEL_VANESSA = smlua_model_util_get_id("vanessa_violet_geo")      -- Located in "actors"
local E_MODEL_JEREMY = smlua_model_util_get_id("jeremy_violet_geo")      -- Located in "actors"
local E_MODEL_FRITZ = smlua_model_util_get_id("fritz_violet_geo")      -- Located in "actors"

local E_MODEL_REMIKE = smlua_model_util_get_id("remike_violet_geo")      -- Located in "actors"
local E_MODEL_REVANESSA = smlua_model_util_get_id("revanessa_violet_geo")      -- Located in "actors"
local E_MODEL_REJEREMY = smlua_model_util_get_id("rejeremy_violet_geo")      -- Located in "actors"
local E_MODEL_REFRITZ = smlua_model_util_get_id("refritz_violet_geo")      -- Located in "actors"

local TEX_MIKE_ICON = get_texture_info("mike_violet_icon") -- Located in "textures"
local TEX_VANESSA_ICON = get_texture_info("vanessa_violet_icon") -- Located in "textures"
local TEX_JEREMY_ICON = get_texture_info("jeremy_violet_icon") -- Located in "textures"
local TEX_FRITZ_ICON = get_texture_info("fritz_violet_icon") -- Located in "textures"

local PALETTE_MIKE = {
    [PANTS]  = "000000",
    [SHIRT]  = "ABABAB",
    [GLOVES] = "FFDABC",
    [SHOES]  = "000000",
    [HAIR]   = "984E1E",
    [SKIN]   = "FFDABC",
    [CAP]    = "444444",
	[EMBLEM] = "FFA388"
}

local PALETTE_VANESSA = {
    [PANTS]  = "000000",
    [SHIRT]  = "ABABAB",
    [GLOVES] = "FFDABC",
    [SHOES]  = "000000",
    [HAIR]   = "FFCB3B",
    [SKIN]   = "FFDABC",
    [CAP]    = "3C3C3C",
	[EMBLEM] = "000000"
}

local PALETTE_JEREMY = {
    [PANTS]  = "000000",
    [SHIRT]  = "ABABAB",
    [GLOVES] = "984E1E",
    [SHOES]  = "000000",
    [HAIR]   = "2A2245",
    [SKIN]   = "984E1E",
    [CAP]    = "444444",
	[EMBLEM] = "000000"
}

local PALETTE_FRITZ = {
    [PANTS]  = "000000",
    [SHIRT]  = "ABABAB",
    [GLOVES] = "FFF2E0",
    [SHOES]  = "000000",
    [HAIR]   = "D64F38",
    [SKIN]   = "FFF2E0",
    [CAP]    = "444444",
	[EMBLEM] = "000000"
}

local VOICETABLE_FRICK = {
}

local CAPTABLE_FRICK = {
    normal = smlua_model_util_get_id("frick_violet_cap_geo"),
    wing = smlua_model_util_get_id("frick_violet_wing_cap_geo"),
    metal = smlua_model_util_get_id("frick_violet_metal_cap_geo"),
    metalwing = smlua_model_util_get_id("frick_violet_metalwing_cap_geo"),
}

-- Adds the custom character to the Character Select Menu
CT_JEREMY = _G.charSelect.character_add(
    "Jeremy Fitzgerald", -- Character Name
    "Jeremy always seems to have bad fortune on his side, despite that, Jeremy remains as the most cheerful person you'll meet! And 'luckily' for him, he recieved a call to save a certain someone, maybe his luck is finally turning around!", -- Description
    "VioletSM64", -- Credits
    "2A2245",           -- Menu Color
    E_MODEL_JEREMY,       -- Character Model
    CT_MARIO,           -- Override Character
    TEX_JEREMY_ICON, -- Life Icon
    1                   -- Camera Scale
)
_G.charSelect.character_add_caps(E_MODEL_JEREMY, CAPTABLE_FRICK)
_G.charSelect.character_add_voice(E_MODEL_JEREMY, VOICETABLE_FRICK)
_G.charSelect.character_add_caps(E_MODEL_REJEREMY, CAPTABLE_FRICK)
_G.charSelect.character_add_voice(E_MODEL_REJEREMY, VOICETABLE_FRICK)
_G.charSelect.character_add_palette_preset(E_MODEL_JEREMY, PALETTE_JEREMY)
_G.charSelect.character_add_palette_preset(E_MODEL_REJEREMY, PALETTE_JEREMY)
_G.charSelect.character_set_nickname(CT_JEREMY, "Jeremy")
_G.charSelect.character_set_category(CT_JEREMY, TEXT_MOD_NAME)

CT_MIKE = _G.charSelect.character_add(
    "Mike Schmidt", -- Character Name
    "Mike has been struggling to get a new job ever since his shift at Freddy Frickbear's Pizzeria ended, he is rather not much of an ambitious person, however, he recieved a job offer in the Mushroom Kingdom! Could he push himself to save... a Princess from a turtle...?", -- Description
    "VioletSM64", -- Credits
    "984E1E",           -- Menu Color
    E_MODEL_MIKE,       -- Character Model
    CT_MARIO,           -- Override Character
    TEX_MIKE_ICON, -- Life Icon
    1                   -- Camera Scale
)
_G.charSelect.character_add_caps(E_MODEL_MIKE, CAPTABLE_FRICK)
_G.charSelect.character_add_voice(E_MODEL_MIKE, VOICETABLE_FRICK)
_G.charSelect.character_add_caps(E_MODEL_REMIKE, CAPTABLE_FRICK)
_G.charSelect.character_add_voice(E_MODEL_REMIKE, VOICETABLE_FRICK)
_G.charSelect.character_add_palette_preset(E_MODEL_MIKE, PALETTE_MIKE)
_G.charSelect.character_add_palette_preset(E_MODEL_REMIKE, PALETTE_MIKE)
_G.charSelect.character_set_nickname(CT_MIKE, "Mike")
_G.charSelect.character_set_category(CT_MIKE, TEXT_MOD_NAME)

CT_VANESSA = _G.charSelect.character_add(
    "Vanessa Shelly", -- Character Name
    "Vanessa has previously worked hard along the Fazbear franchise, however, with the Frickbear's franchise toppling down, she seems to no longer need to work for the business again, up until she recieved a call about rescuing some Princess, seems like a challenge, but that won't stop her!", -- Description
    "VioletSM64", -- Credits
    "FFCB3B",           -- Menu Color
    E_MODEL_VANESSA,       -- Character Model
    CT_MARIO,           -- Override Character
    TEX_VANESSA_ICON, -- Life Icon
    1                   -- Camera Scale
)
_G.charSelect.character_add_caps(E_MODEL_VANESSA, CAPTABLE_FRICK)
_G.charSelect.character_add_voice(E_MODEL_VANESSA, VOICETABLE_FRICK)
_G.charSelect.character_add_caps(E_MODEL_REVANESSA, CAPTABLE_FRICK)
_G.charSelect.character_add_voice(E_MODEL_REVANESSA, VOICETABLE_FRICK)
_G.charSelect.character_add_palette_preset(E_MODEL_VANESSA, PALETTE_VANESSA)
_G.charSelect.character_add_palette_preset(E_MODEL_REVANESSA, PALETTE_VANESSA)
_G.charSelect.character_set_nickname(CT_VANESSA, "Vanessa")
_G.charSelect.character_set_category(CT_VANESSA, TEXT_MOD_NAME)

CT_FRITZ = _G.charSelect.character_add(
    "Fritz Smith", -- Character Name
    "...Who invited this guy to the Mushroom Kingdom? Fritz just so happened to arrive one day for unknown reasons, but heard a call for help from a castle close by, Fritz doesn't seem too bothered by the Princess, however, if he could defeat a king, he can become the new ruler and be able to tinker anything he wants!", -- Description
    "VioletSM64", -- Credits
    "D64F38",           -- Menu Color
    E_MODEL_FRITZ,       -- Character Model
    CT_MARIO,           -- Override Character
    TEX_FRITZ_ICON, -- Life Icon
    1                   -- Camera Scale
)
_G.charSelect.character_add_caps(E_MODEL_FRITZ, CAPTABLE_FRICK)
_G.charSelect.character_add_voice(E_MODEL_FRITZ, VOICETABLE_FRICK)
_G.charSelect.character_add_caps(E_MODEL_REFRITZ, CAPTABLE_FRICK)
_G.charSelect.character_add_voice(E_MODEL_REFRITZ, VOICETABLE_FRICK)
_G.charSelect.character_add_palette_preset(E_MODEL_FRITZ, PALETTE_FRITZ)
_G.charSelect.character_add_palette_preset(E_MODEL_REFRITZ, PALETTE_FRITZ)
_G.charSelect.character_set_nickname(CT_FRITZ, "Fritz")
_G.charSelect.character_set_category(CT_FRITZ, TEXT_MOD_NAME)

_G.charSelect.credit_add(TEXT_MOD_NAME, "VioletSM64", "Pack")
_G.charSelect.credit_add(TEXT_MOD_NAME, "Squishy6094", "Palette Costume Code")
_G.charSelect.credit_add(TEXT_MOD_NAME, "SpookyRick", "Creator of Frickbear's 3")

-- Update Model based on palette
local prevPalette = 1
local function update_model()
    local palette = _G.charSelect.character_get_current_palette_number(0)
    if prevPalette ~= palette then
        _G.charSelect.character_edit_costume(CT_MIKE, 1, nil, nil, nil, nil, palette == 1 and E_MODEL_MIKE or E_MODEL_REMIKE)
        _G.charSelect.character_edit_costume(CT_VANESSA, 1, nil, nil, nil, nil, palette == 1 and E_MODEL_VANESSA or E_MODEL_REVANESSA)
        _G.charSelect.character_edit_costume(CT_JEREMY, 1, nil, nil, nil, nil, palette == 1 and E_MODEL_JEREMY or E_MODEL_REJEREMY)
        _G.charSelect.character_edit_costume(CT_FRITZ, 1, nil, nil, nil, nil, palette == 1 and E_MODEL_FRITZ or E_MODEL_REFRITZ)
        prevPalette = palette
    end
end

hook_event(HOOK_UPDATE, update_model)
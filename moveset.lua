local TEX_HEALTH = get_texture_info("frickbear_violet_health")

local healthPool = {
    [CT_JEREMY] = 12,
    [CT_MIKE] = 8,
    [CT_VANESSA] = 4,
    [CT_FRITZ] = 1,
}

local function frickbear_health_meter(localIndex, health, prevX, prevY, prevScaleW, prevScaleH, x, y, scaleW, scaleH)
    local moveset = _G.charSelect.gCSPlayers[localIndex].movesetToggle
    local charNum = _G.charSelect.character_get_current_number(localIndex)
    local maxHealth = (moveset and healthPool[charNum] ~= nil) and healthPool[charNum] or 8
    local currHealth = health >= 0x100 and math.floor(math.clamp(health/0x800, 0, 1)*maxHealth) or 0

    local prevScaleW = prevScaleW / 64
    local prevScaleH = prevScaleH / 64
    local scaleW = scaleW / 64
    local scaleH = scaleH / 64

    local meterHeight = 21
    local meterWidthInside = maxHealth*6 - 1
    local meterWidthFull = 47 + meterWidthInside + 8
    local prevX = prevX + (32 - meterWidthFull*0.5) * prevScaleW
    local prevY = prevY + (32 - meterHeight*0.5) * prevScaleH
    local x = x + (32 - meterWidthFull*0.5) * scaleW
    local y = y + (32 - meterHeight*0.5) * scaleH

    if localIndex == 0 then
        prevX = 2
        prevY = 217
        x = 2
        y = 217

        prevScaleW = 1
        prevScaleH = 1
        scaleW = 1
        scaleH = 1
    end

    local djuiColor = djui_hud_get_color()

    djui_hud_set_color(djuiColor.r, djuiColor.g, djuiColor.b, djuiColor.a)
    djui_hud_render_texture_tile_interpolated(TEX_HEALTH, prevX, prevY, prevScaleW * 21/47, prevScaleH, x, y, scaleW * 21/47, scaleH, 0, 0, 47, 21)
    djui_hud_render_texture_tile_interpolated(TEX_HEALTH, prevX + (47)*prevScaleW, prevY, prevScaleW * 21/1 * meterWidthInside, prevScaleH, x + (47)*scaleW, y, scaleW * 21/1 * meterWidthInside, scaleH, 47, 0, 1, 21)

    djui_hud_set_color(255 * (1 - currHealth/maxHealth) * (djuiColor.r/255), 0, 0, djuiColor.a)
    if currHealth > 0 then
        for i = 1, currHealth do
            local xOffset = (47 + 6 * (i - 1))
            djui_hud_render_rect_interpolated(prevX + xOffset*prevScaleW, prevY + 8*prevScaleH, 5*prevScaleW, 6*prevScaleH, x + xOffset*scaleW, y + 8*scaleH, 5*scaleW, 6*scaleW)
        end
    end

    djui_hud_set_color(djuiColor.r, djuiColor.g, djuiColor.b, djuiColor.a)
    djui_hud_render_texture_tile_interpolated(TEX_HEALTH, prevX + (47 + meterWidthInside)*prevScaleW, prevY, prevScaleW * 21/8, prevScaleH, x + (47 + meterWidthInside)*scaleW, y, scaleW * 21/8, scaleH, 47, 0, 8, 21)
end

_G.charSelect.character_add_health_meter(CT_JEREMY, frickbear_health_meter)
_G.charSelect.character_add_health_meter(CT_MIKE, frickbear_health_meter)
_G.charSelect.character_add_health_meter(CT_VANESSA, frickbear_health_meter)
_G.charSelect.character_add_health_meter(CT_FRITZ, frickbear_health_meter)

gExtraStates = {}
for i = 0, MAX_PLAYERS - 1 do
    gExtraStates[i] = {
        prevHurtCounter = 0,
        prevHealCounter = 0
    }
end

---@param m MarioState
local function frickbears_health_update(m)
    local e = gExtraStates[m.playerIndex]
    local charNum = _G.charSelect.character_get_current_number(m.playerIndex)
    local HPScale = 8/((m.playerIndex and healthPool[charNum] ~= nil) and healthPool[charNum] or 8)

    if (m.health >= 0x100) then
        if ((m.healCounter | m.hurtCounter) == 0) then
            if ((m.input & INPUT_IN_POISON_GAS) ~= 0 and (m.action & ACT_FLAG_INTANGIBLE) == 0) then
                if ((m.flags & MARIO_METAL_CAP) == 0) then
                    -- Revert Vanilla Change
                    m.health = m.health + 4;
                    -- Apply Custom Change
                    m.health = m.health - 4*HPScale
                end
            else
                if ((m.action & ACT_FLAG_SWIMMING) ~= 0 and (m.action & ACT_FLAG_INTANGIBLE) == 0) then
                    terrainIsSnow = (m.area.terrainType & TERRAIN_MASK) == TERRAIN_SNOW;

                    -- Update Drown Time
                    m.health = m.health + 1
                    m.health = m.health - math.min(HPScale, 4)

                    -- When Mario is near the water surface, recover health (unless in snow),
                    -- when in snow terrains lose 3 health.
                    if ((m.pos.y >= (m.waterLevel - 140)) and not terrainIsSnow) then
                        m.health = m.health - 0x1A;
                        m.health = m.health + 0x1A*HPScale;
                    end
                end
            end
        end

        if (m.healCounter > 0 or e.prevHealCounter > 0) then
            m.health = m.health - 0x40;
            m.health = m.health + 0x40*HPScale;
        end
        e.prevHealCounter = m.healCounter
        
        if (m.hurtCounter > 0 or e.prevHurtCounter > 0) then
            m.health = m.health + 0x40;
            m.health = m.health - 0x40*HPScale;
        end
        e.prevHurtCounter = m.hurtCounter

        --[[
        if (m.health > 0x880) then
            m.health = 0x880;
        end
        if (m.health < 0x100) then
            if (m.playerIndex ~= 0) then
                -- never kill remote marios
                m.health = 0x100;
            else
                m.health = 0xFF;
            end
        end

        if (m->playerIndex == 0) {
            // Play a noise to alert the player when Mario is close to drowning.
            if (((m->action & ACT_GROUP_MASK) == ACT_GROUP_SUBMERGED) && (m->health < 0x300)) {
                play_sound(SOUND_MOVING_ALMOST_DROWNING, gGlobalSoundSource);
                if (!gRumblePakTimer) {
                    gRumblePakTimer = 36;
                    if (is_rumble_finished_and_queue_empty()) {
                        queue_rumble_data_mario(m, 3, 30);
                    }
                }
            }
            else {
                gRumblePakTimer = 0;
            }
        }
        ]]
    end
end

_G.charSelect.character_hook_moveset(CT_JEREMY, HOOK_BEFORE_MARIO_UPDATE, frickbears_health_update)
_G.charSelect.character_hook_moveset(CT_MIKE, HOOK_BEFORE_MARIO_UPDATE, frickbears_health_update)
_G.charSelect.character_hook_moveset(CT_VANESSA, HOOK_BEFORE_MARIO_UPDATE, frickbears_health_update)
_G.charSelect.character_hook_moveset(CT_FRITZ, HOOK_BEFORE_MARIO_UPDATE, frickbears_health_update)
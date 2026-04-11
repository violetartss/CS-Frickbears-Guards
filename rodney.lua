-- Shoutouts to SpookyRick

local TEX_RODNEY_HEAD = get_texture_info("rodney_violet_head")
local TEX_RODNEY_HEAD_CLOSED = get_texture_info("rodney_violet_head_closed")
local TEX_RODNEY_HEAD_TALK = get_texture_info("rodney_violet_head_talk")
local TEX_RODNEY_NECK = get_texture_info("rodney_violet_neck")
local TEX_RODNEY_TORSO = get_texture_info("rodney_violet_torso")

local RODNEY_GROUP_PASSIVE = 0

local rodneyVoicelines = {
    [RODNEY_GROUP_PASSIVE] = {
        audio_stream_load("RodneyIngameFrickbears63.ogg"),
        audio_stream_load("RodneyIngameFrickbears58.ogg"),
    }
}

local currentLine = nil
local function play_rodney_voiceline(group, line)
    if currentLine ~= nil then
        audio_stream_stop(currentLine)
    end
    group = group or RODNEY_GROUP_PASSIVE
    line = line or math.random(1, #rodneyVoicelines[RODNEY_GROUP_PASSIVE])
    local sound = rodneyVoicelines[group][line]
    audio_stream_play(sound, true, 2)
    currentLine = sound
end

local soundsPos = {}
---@param stream ModAudio
local function audio_is_playing(stream)
    if not stream.isStream then return end
    if soundsPos[stream.filepath] == nil then
        soundsPos[stream.filepath] = {
            pos = -1,
            timer = 0
        }
    end
    if soundsPos[stream.filepath].pos ~= audio_stream_get_position(stream) then
        soundsPos[stream.filepath].pos = audio_stream_get_position(stream)
        soundsPos[stream.filepath].timer = 0
    else
        soundsPos[stream.filepath].timer = soundsPos[stream.filepath].timer + 1
        if soundsPos[stream.filepath].timer > 5 then
            return false
        end
    end
    return true
end

local function rot_x(x, y, angle)
    return x * coss(angle) - y * sins(angle)
end

local function rot_y(x, y, angle)
    return x * sins(angle) + y * coss(angle)
end

local frame = 0
local bounceOffset = 0
local yOffset = 0
local position = 0
local blinkFrames = 0
local positionTarget = 0
local bounceSpeed = 1
local positionSpeed = 0
local timeToNextQuip = 0
local quoteNum = 0
local randomizer = 0
local function hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    local sWidth = djui_hud_get_screen_width()
    local sHeight = djui_hud_get_screen_height()
    local frameAngle = frame/90

    local bodyX = sWidth + 2 - TEX_RODNEY_TORSO.width
    local bodyY = sHeight + 2 + math.sin(frameAngle + 30) + bounceOffset + yOffset - TEX_RODNEY_TORSO.height
    local bodyAngle = 0

    local neckX = bodyX + 22 + rot_x(-22, -12, bodyAngle)
    local neckY = bodyY + 12 + rot_y(-22, -12, bodyAngle)
    local neckAngle = (math.lerp(math.sin(frameAngle)*5 + 8, math.sin(frameAngle)*3, position) + bounceOffset)/360*0x8000

    local headX = neckX + 46 + rot_x(-46, -53, -neckAngle)
    local headY = neckY + 53 + rot_y(-46, -53, -neckAngle)
    local headAngle = math.lerp(math.sin(frameAngle - 30)*2, 15, position)/360*0x8000
    local headSize = 1 + bounceOffset/20
    local headImage = TEX_RODNEY_HEAD

    if blinkFrames > 0 then
        blinkFrames = blinkFrames - 1
        headImage = TEX_RODNEY_HEAD_CLOSED
    elseif positionTarget ~= 0 then
        headImage = TEX_RODNEY_HEAD_TALK
    end

    djui_hud_set_rotation(bodyAngle, 1, 1)
    djui_hud_render_texture(TEX_RODNEY_TORSO, bodyX, bodyY, 1, 1)
    djui_hud_set_rotation(neckAngle, (128 - 22)/128, (128 - 12)/128)
    djui_hud_render_texture(TEX_RODNEY_NECK, neckX, neckY, 1, 1)
    djui_hud_set_rotation(headAngle, (128 - 46)/128, (128 - 53)/128)
    djui_hud_render_texture(headImage, headX + headImage.width * (1 - 1/headSize)*0.5, headY + headImage.height * (1 - headSize)*0.5, 1/headSize, headSize)

    if math.random(0, 100) == 0 and blinkFrames == 0 and positionTarget == 0 then
        blinkFrames = 10
        bounceSpeed = 0.25
    end

    position = position + positionSpeed
    positionSpeed = math.lerp(bounceSpeed, (positionTarget - position)*0.8, 0.2)

    bounceOffset = bounceOffset + bounceSpeed
    bounceSpeed = math.lerp(bounceSpeed, (0 - bounceOffset)*0.8, 0.2)

    frame = frame + 1
    timeToNextQuip = timeToNextQuip - 1

    if currentLine == nil then
        if timeToNextQuip <= 0 then
            play_rodney_voiceline()
            
            --timeToNextQuip = 100
            positionTarget = 1
            bounceSpeed = 2
            blinkFrames = 5
            quoteNum = quoteNum + 1
        end
    else
        audio_stream_set_volume(currentLine, 2)
        if not audio_is_playing(currentLine) then
            timeToNextQuip = math.random(10*30, 60*30)
            currentLine = nil
            randomizer = 0.75 + math.random()*0.5
            positionTarget = 0
            bounceSpeed = 2
            blinkFrames = 5
        end
    end
end

hook_event(HOOK_ON_HUD_RENDER, hud_render)
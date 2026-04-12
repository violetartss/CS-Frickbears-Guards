-- Shoutouts to SpookyRick

--[[
    Voicelines:
        - Passive:
            Orignal:
                "Listen, I could make a better game than this. Just watch me. Raise me 35,000 dollars and I'll show you."
                "If your recording this for a video, I'm going to be expecting a cut of the ad revenue."
                "I don't wanna alarm you... AHH!! Ah, just kidding. I was lying."
                "I'm actually the anti-piracy for this game. If you obtained the rom for free,
                    I WILL be sending a strongly-worded letter to your mother to let you know Rodney Redbird is disappointed in you.
                    ...Not because of the piracy, just 'cuz you suck."
                "...God, do you not have anything better to do?"
                "I've run out of things to say. That's how uninteresting this is."
                "This is getting really boring, I'm starting to run out of things to say."
                "Hey I wrote a song for you! *BELCH* ...Ah, nevermind, I lost interest."
                "I should swear so I can get you demonetized."
                "Hey, let me guess, this your first time playing? No? Oof. That's embarrassing."
                "...I'm still getting paid for this, right?"
                "If you think things are tough now... Don't worry, they're gonna get worse."
                "I'm editing your save file to invalidate this speedrun."
                "Y'know, it'd be real funny if, OUT OF NOWHERE, the game's memory started leaking.
                    And you'd have to start ALL over again. Wasted all that time getting all those stars just for some faulty coding.
                    It could happen. Really could.
                    You'd be cryin' tears. And I'll be drinking 'em."
                "You ever wondered how long it took me to record ALL these lines?
                    I don't remember. But it was probably long. I should be making these schmucks pay me extra."
            "I'm surprised you're hanging in there, I know those buttons can get real sticky."
            "Can you beleieve they cheaped out on a different voice actor? I'm still not even getting paid!"
            "I knew how to unlock luigi before it was cool."
            "Y'know Bowser actually hired me for this! Yeah same shtick as the rabbit, he knew you'd be too gullible to not wanna talk to someone as dashing as me."
            "Hey big man, dug through your pocket here for a quick second, this letter's cute but I don't think she's got a cake for you.
                Yeah i know, tough pill to swallow, you'll get over it."
            "The 121st star they were talking about all that time? Yeah that was me, get over it."
            "You know that 'modfs' stuff isn't as safe as you think it is, I actually just got a keylogger set up in there!"
            "*yawn* Man when does this game get good"
            "Look at you, lookin around all scared like there's other animatronics here."
            "Y'know the reason i'm here in the first place is so the mod developers can blame me for reaching the file size limit, they REALLY don't like updating stuff past at MOST v4."
            "Your friend's taking a while to join, wonder why?"
            "Hey so which community you coming from big guy? ...Either way you're weird."
            "I know there's no audio cues or anything, I'm just doing this for the love of the game."
            "I can't believe THIS is the game they're maintaining!"
            "*OBNOXIOUS CRUNCHING* mmph, Sorry, you wanted some?"
            "Modelers need to learn Blender's shade auto smooth and sharps, it'd save them from crappy shading like this."
            "Imagine if whenever Mario started eating mushrooms, he got zooted out of his mind! Nintendo should hire me, I've got GREAT ideas!"
        - Star Collect:
            "I'm still not impressed"
            "Pretty good work for a wannabe plumber."
            "I kinda wish you had non-stop on, all these cutscenes are getting on my nerves"
        - Character Select Menu Opened:
            "I could make a menu like this in my sleep."
            "Chop chop kid, I got places to be."
            "Look at this pile of mess, this entire menu is all bloat!"
            "This selection is really just, yikes, all of these jerks add next-to-nothing."
            "None of these jerks have yet to best me."
            "Yeah I'd pick a different character too, sheesh."
        - Night Started (DNC):
            "Would you look at the time! How's my favorite platform character doin'?"
            "Heyyy is this where the party's at? Oh nevermind, it's just you."
            "I was told i'd be paid good money for sittin' around here, so here I am."
        - Night Ended (DNC):
            "*SNOARING* Huh? Eh? Oh my god, I get to leave. Thank god."
            "Well this was a waste of time."
            "Alright that was fun, same time tommorow?"
        - Host:
            "You thought rehosting would get you outta this mess? Sorry pallie, you're stuck with me for the long haul."
            "What you forget a mod? Oh no wait I get itm you're turning on your cheat scripts!"
            "I think your finger slipped on your Disconnect bind"
        - Seeing/Playing as Rodney:
            "Gee, what a handsome lookin' fellow!"
            "Look at THAT dashing devil! *whistle*"
        - Initially picked up:
            "Alright I guess i'm coming with."
            "Thanks for the dollar. Yeah you read the salvage price right, I just took it out of your pocket."
        - Getting to 100 coins:
            "Mind if I borrow, some money? I need to buy some lunch. No? Geez fine."
            "If I knew getting money was this easy I would've just started running around myself instead of letting you drag me around."
            "Man that's... a lot of coins...! Sorry i'm trying to kill some dead air here, you're wasting so much time on this."
]]

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
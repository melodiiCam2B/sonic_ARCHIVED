local x0_p1
local x1_p1
local x2_p1
local x3_p1


local y0_p1
local y1_p1
local y2_p1
local y3_p1

local x0_p2
local x1_p2
local x2_p2
local x3_p2


local y0_p2
local y1_p2
local y2_p2
local y3_p2

local noteSwingAmount =6
local swingFactor = 32

local startSwing = false

local swingX = false

local swingY = true

function onSongStart( ... )
	startSwing = getModSetting('noteSwing')
end

function onCreatePost( ... )
	x0_p2 = defaultPlayerStrumX0
	y0_p2 = defaultPlayerStrumY0
	x1_p2 = defaultPlayerStrumX1
	y1_p2 = defaultPlayerStrumY1
	x2_p2 = defaultPlayerStrumX2
	y2_p2 = defaultPlayerStrumY2
	x3_p2 = defaultPlayerStrumX3
	y3_p2 = defaultPlayerStrumY3

	x0_p1 = defaultOpponentStrumX0
	y0_p1 = defaultOpponentStrumY0
	x1_p1 = defaultOpponentStrumX1
	y1_p1 = defaultOpponentStrumY1
	x2_p1 = defaultOpponentStrumX2
	y2_p1 = defaultOpponentStrumY2
	x3_p1 = defaultOpponentStrumX3
	y3_p1 = defaultOpponentStrumY3

end


function onUpdate(elapsed)

	songPos = getSongPosition()
    currentBeat = (songPos/1000)*(bpm/60)

	if startSwing == true then
			
			if swingX then
			noteTweenX('noteTweenX'..0, 0, x0_p1 +noteSwingAmount*math.sin((currentBeat + 0) * math.pi*16/swingFactor),0.0001)
			noteTweenX('noteTweenX'..1, 1, x1_p1 +noteSwingAmount*math.sin((currentBeat + 1) * math.pi*16/swingFactor),0.0001)
			noteTweenX('noteTweenX'..2, 2, x2_p1 +noteSwingAmount*math.sin((currentBeat + 2) * math.pi*16/swingFactor),0.0001)
			noteTweenX('noteTweenX'..3, 3, x3_p1 +noteSwingAmount*math.sin((currentBeat + 3) * math.pi*16/swingFactor),0.0001)
			noteTweenX('noteTweenX'..0+4, 0+4,  x0_p2 +noteSwingAmount*math.sin((currentBeat + 0+4) * math.pi*16/swingFactor),0.0001)
			noteTweenX('noteTweenX'..1+4, 1+4,  x1_p2 +noteSwingAmount*math.sin((currentBeat + 1+4) * math.pi*16/swingFactor),0.0001)
			noteTweenX('noteTweenX'..2+4, 2+4,  x2_p2 +noteSwingAmount*math.sin((currentBeat + 2+4) * math.pi*16/swingFactor),0.0001)
			noteTweenX('noteTweenX'..3+4, 3+4,  x3_p2 +noteSwingAmount*math.sin((currentBeat + 3+4) * math.pi*16/swingFactor),0.0001)
			end

			if swingY then
			noteTweenY('noteTweenY'..0, 0, y0_p1 +noteSwingAmount*math.cos((currentBeat + 0) * math.pi*16/swingFactor),0.0001)
			noteTweenY('noteTweenY'..1, 1, y1_p1 +noteSwingAmount*math.cos((currentBeat + 1) * math.pi*16/swingFactor),0.0001)
			noteTweenY('noteTweenY'..2, 2 ,y2_p1 +noteSwingAmount*math.cos((currentBeat + 2) * math.pi*16/swingFactor),0.0001)
			noteTweenY('noteTweenY'..3, 3, y3_p1 +noteSwingAmount*math.cos((currentBeat + 3) * math.pi*16/swingFactor),0.0001)
			
			noteTweenY('noteTweenY'..0+4, 0+4,  y0_p1 +noteSwingAmount*math.cos((currentBeat + 0+4) * math.pi*16/swingFactor),0.0001)
			noteTweenY('noteTweenY'..1+4, 1+4,  y1_p1 +noteSwingAmount*math.cos((currentBeat + 1+4) * math.pi*16/swingFactor),0.0001)
			noteTweenY('noteTweenY'..2+4, 2+4,  y2_p1 +noteSwingAmount*math.cos((currentBeat + 2+4) * math.pi*16/swingFactor),0.0001)
			noteTweenY('noteTweenY'..3+4, 3+4,  y3_p1 +noteSwingAmount*math.cos((currentBeat + 3+4) * math.pi*16/swingFactor),0.0001)
			end
			
	end


end

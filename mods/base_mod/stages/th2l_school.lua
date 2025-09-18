function onCreate()
makeLuaSprite('white', '', -300, 300);
 makeGraphic('white', 4500,3200,'FFFFFF')
addLuaSprite('white', false);
setProperty('white.scale.x',2)
setProperty('white.scale.y',2)

makeLuaSprite('overlay', 'stages/school/0', -400, -280)
scaleObject('overlay', 1.2, 1.2)
addLuaSprite('overlay', true)

makeLuaSprite('bg', 'stages/school/1', -400, -280)
scaleObject('bg', 1.2, 1.2)
addLuaSprite('bg')

makeAnimatedLuaSprite('speaker', 'stages/school/speaker', 680, 360)
addAnimationByPrefix('speaker', 'anim', 'speaker idle', 12, false)
scaleObject('speaker', 1.2, 1.2)
addLuaSprite('speaker')

end

function onBeatHit()
	if curBeat % 1 == 0 then
setProperty('boyfriend.y', 400)
doTweenY('bfy1', 'boyfriend', 380, 0.5, 'circOut')
setProperty('dad.y', 320)
doTweenY('dady', 'dad', 300, 0.5, 'circOut')
end
if curBeat % 2 == 1 then
playAnim('speaker', 'anim')
	end
end


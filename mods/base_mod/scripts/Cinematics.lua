local width = 600

function onCreate( ... )
	makeLuaSprite('blackSide2', '', 0, 0)
	makeGraphic('blackSide2', 200,1920, '000000')
	setScrollFactor('blackSide2', 0, 0)
	setObjectCamera('blackSide2','other')
    addLuaSprite('blackSide2', true)
	
	
	makeLuaSprite('blackSide1', '', 1100, 0)
	makeGraphic('blackSide1',400,1920, '000000')
	setScrollFactor('blackSide1', 0, 0)
	setObjectCamera('blackSide1','other')
    addLuaSprite('blackSide1', true)

	makeLuaSprite('blackTop', '', 0, 600)
	makeGraphic('blackTop', 1920, 720, '000000')
	-- setGraphicSize('blackTop', 1920, 500)
	setScrollFactor('blackTop', 0, 0)
	setProperty('blackTop.alpha', 1)
	setObjectCamera('blackTop','other')
    addLuaSprite('blackTop', true)
	
	
	makeLuaSprite('blackButtom', '', 0,-720)
	makeGraphic('blackButtom', 1920, 720, '000000')
	setGraphicSize('blackButtom', 1920, 500)
	setScrollFactor('blackButtom', 0, 0)
	setProperty('blackButtom.alpha', 1)
	setObjectCamera('blackButtom','hud')
    addLuaSprite('blackButtom', true)

	Hide(0.1,'linear')

	first()
end
function onEvent(name, duration,tween)
	if name == 'CinemaShow' then
		doTweenX('phone1','blackSide1', 1100,0.6,  'cubeOut')
		doTweenX('phone2','blackSide2', 0,0.6,  'cubeOut')
		doTweenY('top-hide3','blackTop',width,0.6, 'cubeOut')
		doTweenY('down-hide2','blackButtom',-390,0.6, 'cubeOut')
	elseif name == 'CinemaHide' then
		doTweenX('phoneleave1','blackSide1', 1500,0.6, 'cubeOut')
		doTweenX('phoneleave2','blackSide2', -500,0.6, 'cubeOut')
		doTweenY('top-Show1','blackTop',720,0.6, 'cubeOut')
		doTweenY('down-Show2','blackButtom',-720,0.6, 'cubeOut')

	end
end

function Hide(duration,tween)
	doTweenY('top-Show','blackTop',720,duration,tween)
	doTweenY('down-Show','blackButtom',-720,duration,tween)
end

function Show(duration,tween)
	doTweenY('top-Show','blackTop',width,duration,tween)
	doTweenY('down-Show','blackButtom',-width,duration,tween)
end
function first()
	doTweenX('phoneleave4','blackSide1', 1500,0.6,'cubeOut')
	doTweenX('phoneleave5','blackSide2', -500,0.6,'cubeOut')
end
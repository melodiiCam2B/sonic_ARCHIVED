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

	first()
end
function onEvent(name, value1, value2)
	if name == 'PhoneMode' then
		doTweenX('phone1','blackSide1', 1100,value1, value2)
		doTweenX('phone2','blackSide2', 0,value1, value2)
	elseif name == 'noPro' then
		doTweenX('phoneleave1','blackSide1', 1500,value1, value2)
		doTweenX('phoneleave2','blackSide2', -500,value1, value2)
	elseif name == 'CinemaHide' then
		doTweenX('phone1','blackSide1', 1100,value1, value2)
		doTweenX('phone2','blackSide2', 0,value1, value2)
	elseif name == 'CinemaShow' then
		doTweenX('phoneleave1','blackSide1', 1500,value1 + 0.2, value2)
		doTweenX('phoneleave2','blackSide2', -500,value1 + 0.2, value2)
	end
end
function first()
	doTweenX('phoneleave4','blackSide1', 1500,0.6,'cubeOut')
	doTweenX('phoneleave5','blackSide2', -500,0.6,'cubeOut')
end
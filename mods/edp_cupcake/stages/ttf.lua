function onCreate()
	makeLuaSprite('blackSide2', '', 0, 0)
	makeGraphic('blackSide2', 20000,20000, 'FFFFFF')
	setScrollFactor('blackSide2', 0, 0)
	screenCenter('blackSide2')
    addLuaSprite('blackSide2', false)


	makeLuaSprite('bg_1', 'stages/ttf/bg');
	scaleObject('bg_1', 2.2,2.2);
	screenCenter('bg_1')

	makeAnimatedLuaSprite('bg_2', 'stages/ttf/sun');
	addAnimationByIndices('bg_2','idle','idle')
	scaleObject('bg_2', 1.2,1.2);
	screenCenter('bg_2')
	setScrollFactor('bg_2', 1.2, 1.2);


	addLuaSprite('bg_2', false)
	addLuaSprite('bg_1', false)
end
function onCreate()
	makeLuaSprite('A', 'stage/bg-greenhill/Sky', -1700, -900);
	scaleObject('A', 3,3);
	setScrollFactor('A', 1, 1);
	
	makeLuaSprite('B', 'stage/bg-greenhill/Clouds', -1500, -535);
	scaleObject('B', 2,2);
	setScrollFactor('B', 1, 1);

	makeLuaSprite('C', 'stage/bg-greenhill/Moutians', -1400, -390);
	scaleObject('C', 2,2);
	setScrollFactor('C', 1, 1);
	
	makeLuaSprite('D', 'stage/bg-greenhill/Water', -1700, 65);
	scaleObject('D', 3, 3);
	setScrollFactor('D', 1, 1);

	makeLuaSprite('E', 'stage/bg-greenhill/Ground', -1700, -400)
	scaleObject('E', 1.75,1.75);
	setScrollFactor('E',1, 1)

	makeAnimatedLuaSprite('F',  'stage/bg-greenhill/rings', -500, 200)
    addAnimationByPrefix('F', 'idle ring', 'idle ring', 24, true)
	scaleObject('F', 1.2,1.2);
	setScrollFactor('F', 1, 1)


	makeLuaSprite('G', 'stage/bg-greenhill/Foreground', -1600, -125)
	scaleObject('G', 2.5, 2.5);
	setScrollFactor('G', 1.25, 1.25)


	addLuaSprite('A', false)

	addLuaSprite('C', false)
	addLuaSprite('B', false)
	addLuaSprite('D', false)
	addLuaSprite('E', false)
	addLuaSprite('F', false)
	addLuaSprite('G', true)
end
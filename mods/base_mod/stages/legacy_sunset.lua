function onCreate()
	makeLuaSprite('A', 'stage/sunset/whatsupthesky', -2000, -900);
	scaleObject('A', 1,1);
	setScrollFactor('A', 1, 1);
	
	makeLuaSprite('B', 'stage/sunset/backrocks', -1650, -300);
	scaleObject('B', 1,1);
	setScrollFactor('B', 1, 1);

	makeLuaSprite('C', 'stage/sunset/biggerbackrocks', -1700,-535);
	scaleObject('C', 1,1);
	setScrollFactor('C', 1, 1);
	
	makeLuaSprite('D', 'stage/sunset/mmmpalms', -1500, -300);
	setScrollFactor('D', 1, 1);

	makeLuaSprite('E', 'stage/sunset/Ground', -1960, 300)
	scaleObject('E', 1,1);
	setScrollFactor('E',1, 1)

	makeAnimatedLuaSprite('F',  'stage/sunset/waterfall',-2100, -500)
    addAnimationByPrefix('F', 'agua', 'agua', 24, true)
	setScrollFactor('F', 1, 1)


	makeLuaSprite('G', 'stage/sunset/frontobjects', -1880, 75)
	scaleObject('G', 0.8, 0.8);
	setScrollFactor('G', 1.25, 1.25)


	addLuaSprite('A', false)
	addLuaSprite('C', false)
	addLuaSprite('F', false)
	addLuaSprite('B', false)
	addLuaSprite('D', false)
	addLuaSprite('E', false)
	addLuaSprite('G', true)
end
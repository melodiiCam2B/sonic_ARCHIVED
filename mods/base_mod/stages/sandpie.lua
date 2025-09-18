local yPos = -500
local xPos = -850
local song 
local wideScreen = 0
local widescreen = false
local widescreentog = false
function onCreate()

	song =  (songName):gsub("remix", "")

	makeLuaSprite('bg_1', 'school/'..song..'_sky', xPos, -250);
	scaleObject('bg_1',9,9);
    setProperty('bg_1.antialiasing',false)

	makeLuaSprite('bg_2', 'school/'..song..'_back', xPos, yPos);
	scaleObject('bg_2',9,9);
    setProperty('bg_2.antialiasing',false)

	makeLuaSprite('bg_3', 'school/'..song..'_school', xPos, yPos);
	scaleObject('bg_3',9,9);
    setProperty('bg_3.antialiasing',false)

	makeLuaSprite('bg_5', 'school/'..song..'_floor', xPos, yPos);
	scaleObject('bg_5',9,9);
    setProperty('bg_5.antialiasing',false)

	makeLuaSprite('bg_6', 'school/'..song..'_treeback', xPos, yPos);
	scaleObject('bg_6',9,9);
    setProperty('bg_6.antialiasing',false)

	makeLuaSprite('bg_7', 'school/'..song..'_petals', xPos, yPos);
	scaleObject('bg_7',9,9);
    setProperty('bg_7.antialiasing',false)
	
	makeLuaSprite('bg_8', 'school/'..song..'_mid', xPos, yPos);
	scaleObject('bg_8',9,9);
    setProperty('bg_8.antialiasing',false)

	makeLuaSprite('fg_1', 'school/'..song..'_treefront', xPos, yPos);
	scaleObject('fg_1',9,9);
    setProperty('fg_1.antialiasing',false)

	makeLuaSprite('fg_2', 'school/'..song..'_front', xPos, yPos);
	scaleObject('fg_2',9,9);
    setProperty('fg_2.antialiasing',false)
	
	addLuaSprite('bg_1', false)
	addLuaSprite('bg_2', false)
	addLuaSprite('bg_3', false)
	addLuaSprite('bg_4', false)
	addLuaSprite('bg_5', false)
	addLuaSprite('bg_6', false)
	addLuaSprite('bg_7', false)
	addLuaSprite('bg_8', false)
	addLuaSprite('fg_1', true)
	addLuaSprite('fg_2', true)

	setScrollFactor('bg_1', 0, 0);
	setScrollFactor('bg_2', 0, 0);
	setScrollFactor('bg_3', 0, 0);
	setScrollFactor('bg_4', 0, 0);
	setScrollFactor('bg_5', 0, 0);
	setScrollFactor('bg_6', 0, 0);
	setScrollFactor('bg_7', 0, 0);
	setScrollFactor('bg_8', 0, 0);
	setScrollFactor('fg_1', 0, 0);
	setScrollFactor('fg_2', 0, 0);

	-- 	addLuaSprite('A', false) [true = foreground]

	-- addHaxeLibrary("Lib", "openfl");
	-- if widescreentog == false then
	-- 	setPropertyFromClass("flixel.FlxG", "width", 1066.666667)
	-- 	setPropertyFromClass("openfl.Lib", "current.stage.stageWidth", 1066.666667)
	-- 	setPropertyFromClass("openfl.Lib", "application.window.width", 1066.666667)
	-- 	setPropertyFromClass("openfl.Lib", "application.window.height", 720)
	-- 	setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") - wideScreen)
	-- 	setProperty("camGame.x", -wideScreen)
	-- 	setPropertyFromClass("openfl.Lib", "application.window.resizable", false)
	-- end
end
function onUpdate(elapsed)
    for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end
	HUDfuncPOS()
   	getPropertyFromClass('ClientPrefs', 'comboOffset')
   	setPropertyFromClass('ClientPrefs', 'comboOffset', {40000, 40000, 40000, 40000})
end
function goodNoteHit()
	setProperty('p2b.scale.y', _check(getProperty('p2b.scale.y')+0.01,220, true))
	updateHitbox('p2b')
	
	setProperty('p1b.scale.y', _check(getProperty('p1b.scale.y')-0.01,1, false))
	updateHitbox('p1b')
    HUDfuncPOS()
end
function noteMiss()
	setProperty('p2b.scale.y', _check(getProperty('p2b.scale.y')-0.01,1, true))
	updateHitbox('p2b')
	
	setProperty('p1b.scale.y', _check(getProperty('p1b.scale.y')+0.01,220, false))
	updateHitbox('p1b')
    HUDfuncPOS()
end
function opponentNoteHit()
	setProperty('p2b.scale.y', _check(getProperty('p2b.scale.y')-0.01,1, true))
	updateHitbox('p2b')
	
	setProperty('p1b.scale.y', _check(getProperty('p1b.scale.y')+0.01,220, false))
	updateHitbox('p1b')
    HUDfuncPOS()
end
function _check(value, point, add)
	if value > point then return point else return value end

end
function cSwitch()--color switch
	song =  (songName):gsub("remix", "")

	if song == 'Roses' then
		return 'ffab6f'
	elseif song == 'Thorns' then
		return 'ff3c6e'
	else
		return 'ffab6f'
	end
end
--hp creation
function createHUDfunc()
	makeLuaSprite('p2a', '', 22, 380)
	makeGraphic('p2a', 20, 220, cSwitch())
	setScrollFactor('p2a', 0, 0)
	setProperty('p2a.alpha', 1)
	setObjectCamera('p2a','hud')
    addLuaSprite('p2a', false)

	makeLuaSprite('p2b', '', 22, 380)
	makeGraphic('p2b', 20, 110, '7bd6f6')
	setScrollFactor('p2b', 0, 0)
	setProperty('p2b.alpha', 1)
	setObjectCamera('p2b','hud')
    addLuaSprite('p2b', false)


	makeLuaSprite('p1a', '', 1236.05, 380)
	makeGraphic('p1a', 20, 220, '7bd6f6')
	setScrollFactor('p1a', 0, 0)
	setProperty('p1a.alpha', 1)
	setObjectCamera('p1a','hud')
    addLuaSprite('p1a', false)

	makeLuaSprite('p1b', '',  1236.05, 380)
	makeGraphic('p1b', 20, 110, cSwitch())
	setScrollFactor('p1b', 0, 0)
	setProperty('p1b.alpha', 1)
	setObjectCamera('p1b','hud')
    addLuaSprite('p1b', false)
end
function HUDfuncPOS()
	setProperty('p1a.x', 1236)
	setProperty('p1a.y', 380)
	setProperty('p1b.x', 1236)
	setProperty('p1b.y', 380)

	setProperty('p2a.x', 22)
	setProperty('p2a.y', 380)
	setProperty('p2b.x', 22)
	setProperty('p2b.y', 380)
end
function setHUD()

	makeLuaSprite('1', 'hud/ui/pixel/border', 0, 0)
    scaleObject('1', 3.66,2.07)
    setProperty('1.antialiasing',false)
    addLuaSprite('1',true)
    setObjectCamera('1', 'hud');

	makeLuaSprite('2', 'hud/ui/pixel/p2', 0, 378)
    scaleObject('2', 2.05,2.05)
    setProperty('2.antialiasing',false)
    addLuaSprite('2',true)
    setObjectCamera('2', 'hud');

	makeLuaSprite('4', 'hud/ui/pixel/p2_'..song, 0, 539)
    scaleObject('4', 2.05,2.05)
    setProperty('4.antialiasing',false)
    addLuaSprite('4',true)
    setObjectCamera('4', 'hud');


	makeLuaSprite('3', 'hud/ui/pixel/p1', 1135, 378)
    scaleObject('3', 2.05,2.05)
    setProperty('3.antialiasing',false)
    addLuaSprite('3',true)
    setObjectCamera('3', 'hud');


	makeLuaSprite('5', 'hud/ui/pixel/boyfriend', 1100, 539)
    scaleObject('5', 2.05,2.05)
    setProperty('5.antialiasing',false)
    addLuaSprite('5',true)
    setObjectCamera('5', 'hud');
	createHUDfunc()
end
function onDestroy()
	setPropertyFromClass("openfl.Lib",
	"application.window.title",
	"Friday Night Funkin': Psych Engine");
-- 		setPropertyFromClass("flixel.FlxG", "width", 1280)
-- 		setPropertyFromClass("openfl.Lib", "current.stage.stageWidth", 1280)
-- 		setPropertyFromClass("openfl.Lib", "application.window.width", 1280)
-- 		setPropertyFromClass("openfl.Lib", "application.window.height", 720)
-- 		setPropertyFromClass("openfl.Lib", "application.window.x", getPropertyFromClass("openfl.Lib", "application.window.x") - wideScreen)
-- 		setPropertyFromClass("openfl.Lib", "application.window.resizable", true)
-- runHaxeCode([[
--     var stage = Lib.current.stage;
--     var resolutionX = 0;
--     var resolutionY = 0;
--     if (stage.window != null)
--     {
--         var display = stage.window.display;
--         if (display != null)
--         {
--             resolutionX = Math.ceil(display.currentMode.width * stage.window.scale);
--             resolutionY = Math.ceil(display.currentMode.height * stage.window.scale);
--         }
--     }
--     if(resolutionX <= 0){
--         resolutionX = stage.stageWidth;
--         resolutionY = stage.stageHeight;
--     }
--   Lib.application.window.x = (resolutionX - Lib.application.window.width)/2;
--   Lib.application.window.y = (resolutionY - Lib.application.window.height)/2;
-- ]]);
	setPropertyFromClass('openfl.Lib', 'application.window.borderless', false)
	setPropertyFromClass('openfl.Lib', 'application.window.title', "Friday Night Funkin': Psych Engine")
end
function onCountdownStarted()
	setProperty('gf.visible',false);
	setPropertyFromClass("openfl.Lib",
	"application.window.title",
	"Untitled_Dating_Simulator");
 	triggerEvent('Change Character','gf','gf-pix')
	song =  (songName):gsub("remix", "")
	setHUD()	
	setProperty('timeBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('scoreTxt.visible', false)
	setProperty('timeTxt.visible', false)

	setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('iconP1.visible', false)
	setProperty('iconP2.visible', false)
	for i = 0, getProperty('opponentStrums.length') do 
		setPropertyFromGroup('opponentStrums', i, 'visible', false);
	end
	if not middlescroll then
		for i = 0, getProperty('playerStrums.length') do
			setPropertyFromGroup('playerStrums', i, 'x', getPropertyFromGroup('playerStrums', i, 'x') - 320);
				if not downscroll then
					setPropertyFromGroup('playerStrums', i, 'y', getPropertyFromGroup('playerStrums', i, 'y') + 25);
				else
					setPropertyFromGroup('playerStrums', i, 'y', getPropertyFromGroup('playerStrums', i, 'y') - 25);
				end
		end
	end
end
function getIconColor(chr)
	return getColorFromHex(rgbToHex(getProperty(chr .. ".healthColorArray")))
end
function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end
function onBeatHit()
	song =  (songName):gsub("remix", "")
	if song == 'Thorns' then
		if curBeat % 1 == 0 then
			setPropertyFromClass("openfl.Lib",
		"application.window.title",
		shuffleTitle());
    	end
	end

end

local shuffleList = {"U","n","t","i","t","l","e","d","_","D","a","t","i","n","g","_","S","i","m","u","l","a","t","o","r"}

function shuffleTitle()
	ShuffleInPlace(shuffleList)
	return table.concat(shuffleList)
end
function ShuffleInPlace(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end
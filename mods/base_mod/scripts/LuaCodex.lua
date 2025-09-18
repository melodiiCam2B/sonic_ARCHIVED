FadeTime = 0.5
FadeEase = 'CircInOut'

function getMustHit()
    return mustHitSection
end



function getMidScrole()
    return getPropertyFromClass('backend.ClientPrefs', 'data.downScroll')
end

function getSongPos()
    return getSongPosition()
end

function getBPM()
    return bpm()
end

function luaCharSwap(char, new)
    triggerEvent('Change Character',char,new)
end

function onCreate() 
    makeLuaSprite('two', 'hud/ui/2', 0, 0)
	screenCenter('two', 'xy')
	setObjectCamera('two', 'other')
	setProperty('two.alpha', 0)

	makeLuaSprite('one', 'hud/ui/1', 0, 0)
	screenCenter('one', 'xy')
	setObjectCamera('one', 'other')
	setProperty('one.alpha', 0)

	makeLuaSprite('three', 'hud/ui/3', 0, 0)
	screenCenter('three', 'xy')
	setObjectCamera('three', 'other')
	setProperty('three.alpha', 0)

	makeLuaSprite('go', 'hud/ui/go', 0, 0)
	screenCenter('go', 'xy')
	setObjectCamera('go', 'other')
	setProperty('go.alpha', 0)

	addLuaSprite('one', true)
	addLuaSprite('two', true)
	addLuaSprite('three', true)
	addLuaSprite('go', true)
    
    setProperty('three.alpha', 1)
end

function onCountdownTick(counter)
	if counter == 0 then
		doTweenAlpha('three', 'three', 0, FadeTime, FadeEase)
        removeLuaSprite('three')
		setProperty('two.alpha', 1)
	elseif counter == 1 then
		doTweenAlpha('two', 'two', 0, FadeTime, FadeEase)
		setProperty('countdownReady.visible', false)
        removeLuaSprite('two')
        setProperty('one.alpha', 1)
	elseif counter == 2 then
		setProperty('go.alpha', 1)
		doTweenAlpha('one', 'one', 0, FadeTime, FadeEase)
		setProperty('countdownSet.visible', false)
        removeLuaSprite('one')
	elseif counter == 3 then
		doTweenAlpha('go', 'go', 0, FadeTime, FadeEase)
		setProperty('countdownGo.visible', false)
        removeLuaSprite('go')
	end
end
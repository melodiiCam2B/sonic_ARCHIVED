f = 1
h = -550
function onCreate()
  makeLuaSprite('sky', 'stages/expurgated/sky', -1500, h)
  scaleObject('sky', 1.8, 1.8)
  addLuaSprite('sky')

  makeLuaSprite('rock2', 'stages/expurgated/rock2', -1500, h)
  scaleObject('rock2', 1.8, 1.8)
  addLuaSprite('rock2')

  makeLuaSprite('ground', 'stages/expurgated/ground', -1500, h)
  scaleObject('ground', 1.8, 1.8)
  addLuaSprite('ground')

  makeLuaSprite('front', 'stages/expurgated/signfront', -1500, h)
  scaleObject('front', 1.8, 1.8)
  setScrollFactor(0.8,0.8)
  addLuaSprite('front', true)

	makeLuaSprite('overlay', 'stages/expurgated/gradoverlay',0,0)
	setScrollFactor('overlay', 0, 0)
	setObjectCamera('overlay','hud')
  setProperty('overlay.alpha', 0.4)
  addLuaSprite('overlay', true)
end
function onStepHit()
    Particle()
end

function Particle()
  songPos = getSongPosition()
  currentBeat = (songPos/500)
  f = f + 1
  sus = math.random(2, 1500)
  sus2 = math.random(2, 1500)
  makeLuaSprite('part' .. f, 'stages/expurgated/particle', math.random(-800, 1200), 1200)
  doTweenY(sus, 'part' .. f, -900*math.tan((currentBeat+1*0.1)*math.pi), 6)
  doTweenX(sus2, 'part' .. f, -900*math.sin((currentBeat+1*0.1)*math.pi), 6)
  scaleObject('part' .. f, 0.5, 0.5);
  addLuaSprite('part' .. f, true)

  if f >= 50 then
    f = 1
  end
end
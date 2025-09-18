local w = -1500
local h = -750
function onCreate()
  makeLuaSprite('sky','stages/smokebomb/sky', w, h)
  scaleObject('sky', 1.5, 1.5)
  addLuaSprite('sky')

  makeLuaSprite('backcity','stages/smokebomb/buildings', w, -999)
  scaleObject('backcity', 1.5, 1.5)
  addLuaSprite('backcity')

  makeLuaSprite('city','stages/smokebomb/buildings2', w, h)
  scaleObject('city', 1.5, 1.5)
  addLuaSprite('city')

  makeLuaSprite('ground','stages/smokebomb/ground', w, h)
  scaleObject('ground', 1.5, 1.5)
  addLuaSprite('ground')

  makeLuaSprite('l2', 'stages/smokebomb/overlay1', w, h)
  scaleObject('l2', 1.5, 1.5)
  addLuaSprite('l2', true)

  makeLuaSprite('l1', 'stages/smokebomb/overlay2', w, h)
  scaleObject('l1', 1.5, 1.5)
  addLuaSprite('l1', true)

  makeLuaSprite('front', 'stages/smokebomb/bushes', w, h)
  scaleObject('front', 1.5, 1.5)
  addLuaSprite('front', true)

  makeLuaSprite('l3', 'stages/smokebomb/overlay3', w, h)
  scaleObject('l3', 1.5, 1.5)
  setProperty('l3.alpha', 0.4)
  addLuaSprite('l3', true)
end
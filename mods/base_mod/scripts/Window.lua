function expoFunc()--do not run
	-- width, height, time/speed of tween
	callOnHScript('resizeWindow', {1280*1.4,720 *1.4,0.3})
	-- width, height - doens't have tween
	callOnHScript('winResizeNT', {1280*1.4,720 *1.4})
	-- instant window centering
	callOnHScript('centerTweenless')
	callOnHScript('centerWindowOnPoint')
	-- fullscreen
	callOnHScript('fullScreenForced')
	callOnHScript('resetWindowSize')
	-- x/y tween
	callOnHScript('tweenXWin',{100,0.3,'linear'})
	callOnHScript('tweenYWin',{100,0.3,'linear'})
	-- shake window violently!!! 
	callOnHScript('windowShake',{3}) --variable depends time in seconds
	-- forgot to add this function!
	callOnHScript('getMidPoint',{true}) -- true sends screen X center, false sends screen Y center
end
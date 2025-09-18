local width = 600

function onEvent(name, v1, v2)
	if name == 'HudVis' then
		Fun(v1, v2)
	end

end

function Fun(alpha,duration)
	doTweenAlpha('hpBar', 'healthBar', alpha, duration, 'linear');
	doTweenAlpha('iconP1', 'iconP1', alpha, duration, 'linear');
	doTweenAlpha('iconP2', 'iconP2', alpha, duration, 'linear');
	doTweenAlpha('hpBarBg', 'healthBarBG', alpha, duration, 'linear');
	doTweenAlpha('stxt', 'scoreTxt', alpha, duration, 'linear');
	doTweenAlpha('timeTxt', 'timeTxt', alpha, duration, 'linear')
	doTweenAlpha('timeBar', 'timeBar', alpha, duration, 'linear')
end

doTweenAlpha('TBG4','TBG4',1,1);
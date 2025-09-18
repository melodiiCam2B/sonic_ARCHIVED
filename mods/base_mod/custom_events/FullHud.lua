local duration = 0.6

function onEvent(name, v1, v2)
	if name == 'FullHud' then
		Fun(v1, v2)
	end

end
function Fun(alpha,opp)



	noteTweenAlpha("twe1", 4, alpha, duration,"quartInOut")
	noteTweenAlpha("twe2", 5, alpha, duration, "quartInOut")
	noteTweenAlpha("twe3", 6, alpha, duration, "quartInOut")
	noteTweenAlpha("twe4", 7, alpha, duration, "quartInOut")


	noteTweenAlpha('dayum1', 0, alpha, duration, 'linear')
	noteTweenAlpha('dayum2', 1, alpha, duration, 'linear')
	noteTweenAlpha('dayum3', 2, alpha, duration, 'linear')
	noteTweenAlpha('dayum4', 3, alpha, duration, 'linear')

	noteTweenX("midx5", 4, 410, 1, "quartInOut");
	noteTweenX("midx6", 5, 522, 1, "quartInOut");
	noteTweenX("midx7", 6, 633, 1, "quartInOut");
	noteTweenX("midx8", 7, 745, 1, "quartInOut");

	noteTweenX("midx1", 0, -2000, 1, "quartInOut");
	noteTweenX("midx2", 1, -2000, 1, "quartInOut");
	noteTweenX("midx3", 2, -2000, 1, "quartInOut");
	noteTweenX("midx4", 3, -2000, 1, "quartInOut");

end

doTweenAlpha('TBG4','TBG4',1,1);
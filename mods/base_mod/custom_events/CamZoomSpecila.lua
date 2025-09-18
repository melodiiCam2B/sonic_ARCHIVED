function onEvent(eventName, value1, value2) 
    if eventName == 'CamZoomSpecila' then
        cancelTween("asf")
        doTweenZoom('asf', 'camGame', value1, value2, 'cubeOut')
        setProperty('defaultCamZoom', value1)
    end
end
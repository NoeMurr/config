function EnterResizeMode() 

    local resizeKeyMaps = {
        j = 'resize -1',
        k = 'resize +1',
        h = 'vertical resize -1',
        l = 'vertical resize +1',
        w = 'winc w',
        W = 'winc W',
        ['='] = 'resize =',
    }

    require('libmodal').mode.enter('RESIZE', resizeKeyMaps)
end

function secToHMS(s)
    return string.format("%.2d:%.2d:%.2d", s / (60 * 60), s / 60 % 60, s % 60)
end

function probe()
    if vlc.access ~= 'http' and vlc.access ~= 'https' then
        return false
    end

    return string.match(vlc.path, 'api.twitch.tv/api/videos/.+')
end

function parse()
    local str = vlc.readline()
    local parts = {}
    local currtime = 0
    for url, duration in string.gmatch(str, '"url":"([^\"]+)","length":(%d+)') do
        table.insert(parts, {path = url, duration = duration, title = secToHMS(currtime) })
        currtime = currtime + duration
    end

    return parts
end

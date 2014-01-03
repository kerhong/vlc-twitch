function probe()
    if vlc.access ~= 'http' and vlc.access ~= 'https' then
        return false
    end

    return string.match(vlc.path, 'api.twitch.tv/api/videos/.+')
end

function parse()
    local str = vlc.readline()
    local parts = {}
    for url, duration in string.gmatch(str, '"url":"([^\"]+)","length":(%d+)') do
        table.insert(parts, {path = url, duration = duration })
    end

    return parts
end

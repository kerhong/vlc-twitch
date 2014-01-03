function probe()
    if vlc.access ~= 'http' and vlc.access ~= 'https' then
        return false
    end

    if not string.match(vlc.path, 'twitch.tv') then
        return false
    end

    return string.match(vlc.path, '/b/%d+')
end

function parse()
    while true do
        local line = vlc.readline()
        if not line then break end

        if string.match(line, '<meta property="og:video"') then
            realid = string.match(line, 'videoId=(.%d+)')
        end

        if string.match(line, '<meta property="og:title"') then
            title = string.match(line, 'content="([^\"]+)"')
        end
    end

    return { { path='http://api.twitch.tv/api/videos/' .. realid, title = title } }
end

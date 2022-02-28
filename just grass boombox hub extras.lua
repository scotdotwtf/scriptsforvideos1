--// JUST GRASS SUPPORT SCRIPT
    --// Boombox hub loadstring here //--
    local C = game.PlaceId == 5100950559
    if not C then return; end

    local oFireServer; oFireServer = hookfunction(Instance.new'RemoteEvent'.FireServer, function(self, ...)
        local Args = { ... }
        if Args[1] == 'PlaySong' then
            return oFireServer(self, Args[2])
        end
        return oFireServer(self, ...)
    end)



--// JUST GRASS ONLY QUICK DUPE THING IDK
    --// Execute this like 15 times in your executor
    local chr = game.Players.LocalPlayer.Character
    game.Players.LocalPlayer.Backpack.BoomBox.Parent = chr
    chr.BoomBox.Parent = workspace
    wait()
    game.Players:Chat("-re")

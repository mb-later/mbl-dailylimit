
RLCore = nil

TriggerEvent("RLCore:GetObject", function (library)
    RLCore = library or library or nil
end)


setdefault = function()
    local palyers = RLCore.Functions.GetPlayers()
    for k,v in pairs(palyers) do
        local player = RLCore.Functions.GetPlayer(v)
        player.Functions.SetMetaData("dailylimit", 0)
    end
end

-- üstteki kod çalışmazsa diye
-- exports.ghmattimysql:ready(function()
--     RLCore.Functions.ExecuteSql(false, "SELECT * FROM `players`", function(result)
--         if result == nil then print("nil") return end
--         local MetaData = json.decode(result[1].metadata)
--         print(MetaData.dailylimit)
--         RLCore.Functions.ExecuteSql(false, "UPDATE `players` SET `metadata` = '"..json.encode(MetaData).."'")
--         MetaData.dailylimit = 0
--     end)
-- end)
TriggerEvent('cron:runAt', 23, 59, setdefault)


exports("getdailylimit", function (source)
    local player = RLCore.Functions.GetPlayer(source)
    local dailylimit = player["PlayerData"]["metadata"]["dailylimit"]
    local retval = false
    if dailylimit == nil then
        dailylimit = 0
    end
    if dailylimit == 10 then
        retval = false
        TriggerClientEvent("RLCore:Notify", source, "Günlük limite ulaştın.")
    else
        retval = true
    end
    return retval
end)


RegisterServerEvent("dailylimit")
AddEventHandler("dailylimit", function(val)
    local player = RLCore.Functions.GetPlayer(source)
    player.Functions.SetMetaData("dailylimit", player["PlayerData"]["metadata"]["dailylimit"] + val)
end)


RegisterCommand("günlüklimit", function(source, args)
    if args[1] == nil and args[2] == nil or args[2] == nil or args[1] == nil then 
        TriggerClientEvent("RLCore:Notify", source, "Lütfen tüm argümanları doldurun.\n Örnek kullanım: /günlüklimit [id] [değer]", "info", 5000) 
    else
        local ply = RLCore.Functions.GetPlayer(tonumber(args[1]))
        ply.Functions.SetMetaData("dailylimit", args[2])
    end
end)

RLCore.Functions.CreateCallback("getdailylimit", function(source, cb)
    local player = RLCore.Functions.GetPlayer(source)
    local dailylimit = player["PlayerData"]["metadata"]["dailylimit"]
    local retval = false
    if dailylimit == nil then
        dailylimit = 0
    end
    if dailylimit == 10 then
        retval = false
        TriggerClientEvent("RLCore:Notify", source, "Günlük limite ulaştın.")
    else
        retval = true
    end
    cb(retval)
end)

RegisterServerEvent("cmdprint")
AddEventHandler("cmdprint", function (text)
    --print(RLCore.Functions.GetPlayer(source)["PlayerData"]["metadata"]["dailylimit"])
    print(text)
end)


RLCore = nil
Citizen.CreateThread(function ()
    while RLCore == nil do
        TriggerEvent("RLCore:GetObject", function (obje)
            RLCore = obje
        end)
        Citizen.Wait(0)
    end
    log("^2[Dailylimit]^0 started!")
end)


log = function (text)
    if text == nil then return end
    TriggerServerEvent("cmdprint", text)
end


-- RegisterCommand("abb", function()
--     RLCore.Functions.TriggerCallback("getdailylimit", function(success)
--         if success then
--             print("bbaşarılı")
--         else
--             print("blablal")
--         end
--     end)
-- end)


RegisterNetEvent("mbl:abim")
AddEventHandler("mbl:abim", function(meta, vl)
    TriggerServerEvent("RLCore:Server:SetMetaData", meta, vl)
end)
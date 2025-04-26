local hogtied = false
local checkingHogtied = false 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local size = GetNumberOfEvents(0)
        if size > 0 then
            for i = 0, size - 1 do
                local eventAtIndex = GetEventAtIndex(0, i)
                if eventAtIndex == GetHashKey("EVENT_ENTITY_DAMAGED") then 
                    local eventDataSize = 9
                    local eventDataStruct = DataView.ArrayBuffer(72)
                    eventDataStruct:SetInt32(0 ,0)
                    eventDataStruct:SetInt32(8 ,0) 
                    local is_data_exists = Citizen.InvokeNative(0x57EC5FA4D4D6AFCA,0,i,eventDataStruct:Buffer(),eventDataSize)
                    if is_data_exists then
                        local lassoTarget = eventDataStruct:GetInt32(0)  -- Target (the person to be tied)
                        local lassoUser = eventDataStruct:GetInt32(8)    -- Lasso user (the person throwing the lasso)
                        local weaponHash = GetPedCurrentHeldWeapon(lassoUser) 
                        if weaponHash == 2055893578 then  -- Checking the weapon is simple lasso or not
                            if PlayerPedId() == lassoUser then
                                RemoveWeaponFromPed(lassoUser, weaponHash)
                                TriggerServerEvent('beka-lassoremove:server:removeWeapon', 'WEAPON_LASSO')
                            end
                        elseif weaponHash == -680302000 then -- Checking the weapon is rainforced lasso or not
                            if PlayerPedId() == lassoTarget then
                                hogtied = true
                                checkingHogtied = true 
                            end
                        end
                    end
                end
            end
        end

        -- Disables the ability to untie ropes.
        if hogtied then
            DisableControlAction(0, 0x295175BF, true) --0x6E9734E8
            DisableControlAction(0, 0x6E9734E8, true)
        end

        local ped = PlayerPedId()
        local isHogtied = IsPedHogtied(ped)
        local beingHogtied = IsPedBeingHogtied(ped)

        if checkingHogtied then
            if isHogtied then
                hogtied = true
                checkingHogtied = false
            end
        end

        if not isHogtied and not beingHogtied then
            hogtied = false
        end
    end 
end)

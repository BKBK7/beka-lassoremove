RegisterNetEvent('beka-lassoremove:server:removeWeapon')
AddEventHandler('beka-lassoremove:server:removeWeapon', function(weaponName)
    if Config.Inventory == "RSG" then
        exports['rsg-inventory']:RemoveItem(source, weaponName, 1, false, 'used-lasso')
    else
        exports.vorp_inventory:getUserInventoryWeapons(source, function(Userweapons)
            for i, weapon in pairs(Userweapons) do
                if weapon.name == weaponName then
                    exports.vorp_inventory:subWeapon(source, weapon.id)
                    exports.vorp_inventory:deleteWeapon(source, weapon.id)
                    break
                end
            end
        end)
    end
end)
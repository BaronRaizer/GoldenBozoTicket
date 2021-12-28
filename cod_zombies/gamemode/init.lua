AddCSLuaFile("cl_init.lua")
AddCSLuaFile("Shared.lua")

include("shared.lua")



AddCSLuaFile("round_controller/cl_round_controller.lua")
include("round_controller/sv_round_controller.lua")

AddCSLuaFile("lobby_manager/cl_lobby.lua")
include("lobby_manager/sv_lobby.lua")

local startWeapons = {
    "weapon_shotgun",
    "tfa_fas2_sg55x",
    "deika_raygunmark2",
    "mac_bo2_an94",
    "mac_bo2_warmach",
    "mac_bo2_lsat",
    "mac_bo2_lsat"
}

local ply = FindMetaTable("Player")

function ply:GiveLoadout()

    for k, v in pairs(startWeapons) do

        self:Give(v)

    end

end

function GM:PlayerConnect(name, ip)

    print("Ausländer" .. name .. " ist mit der Adresse (" .. ip .. ")" .. " aufgetaucht.")

end

function GM:PlayerInitialSpawn(ply)

    print("Kanake " .. ply:Name() .. " ist aufgetaucht")

end
local round_status = 0 --so wie beim mikrocontroller mit pullup, wenn null, dann ende, wenn 1, dann aktiv
local activeRound = 1
local t = 0 -- timer
local interval = 3
local zombieCount = 20
local isSpawning = false

local spawnPos = {
Vector(-277, -1455, -79),
Vector(-844.511780 -1086.920532 -79.968750),
Vector(-185.120667 -1753.420654 -79.968750),
Vector(-509.893524 -573.252441 -83.969803),
Vector(-428.334320 -168.007217 -83.968781)
}

util.AddNetworkString("UpdateRoundStatus")

-- Lässt die Runde laufen
function beginRound()
    round_status = 1
    updateClientRoundStatus()
    isSpawning = true
end

-- Beendet die Runde
function endRound()
    round_status = 0
    updateClientRoundStatus()
end

-- Ist die Runde aktiv? Return gibt es uns aus
function getRoundStatus()
    return round_status
end

--think funktion
hook.Add("Think", "WaveThink", function()
    if round_status == 1 and isSpawning == true then
        nextWaveWaiting = false

        if t < CurTime() then
            t = CurTime() + interval
            local temp = ents.Create("npc_zombie")
            temp:SetPos(spawnPos[math.random(1, table.Count(spawnPos))])
            temp:Spawn()
            temp:SetHealth(50 * activeRound)
            zombieCount = zombieCount - 1

            if zombieCount <= 0 then
                isSpawning = false
            end
        end
    end

    if round_status == 1 and isSpawning == false and table.Count(ents.FindByClass("npc_zombie")) == 0 and nextWaveWaiting == false then
        activeRound = activeRound + 1
        nextWaveWaiting = true

        timer.Simple(10, function()
            zombieCount = 20 * activeRound
            isSpawning = true
        end)
    end
end)

function updateClientRoundStatus()
    net.Start("UpdateRoundStatus") -- Gibt die Nachricht aus, welche runde(Zahl läift)
    net.WriteInt(round_status, 4)
    net.Broadcast() -- schickt an allen signal
end
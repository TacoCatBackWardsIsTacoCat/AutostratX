local suc,err = pcall(function()
    repeat wait() until game:IsLoaded()
    --functions first
    local function getchild(self,value) return self:WaitForChild(value) end
    local function getTime(queueItem)
        local wave,minute,second = queueItem[#queueItem-2],queueItem[#queueItem-1],queueItem[#queueItem]
        return wave,minute,second
    end
    local function compareTimes(Time1,Time2)--find a solution to this later
        local Wave1,Min1,Sec1 = getTime(Time1)
        local Wave2,Min2,Sec2 = getTime(Time2)
        local lhsTime = Sec1 + Min1 * 60 + Wave1 * 1000
        local rhsTime = Sec2 + Min2 * 60 + Wave2 * 1000
        return lhsTime <= rhsTime
     end
    local function Split(s, delimiter)
         return s:split(delimiter)
    end 
    local function isIntermission()
        return workspace:FindFirstChild("PathArrow")
    end
    --definitions
    getgenv().queue = {{10,0,20},{0,0,10},{9,0,59}}
    local lPlayer = game.Players.LocalPlayer
    local pGui = lPlayer.PlayerGui
    local gameGui = getchild(pGui,"GameGui")
    local waveFrame = gameGui.Health
    local timeF = waveFrame.Time
    local waveF = waveFrame.Wave
    local queue = getgenv().queue --sets all actions to this value, example {"Place",5,2}
    --more functions and initiazation
    local function getcurrent()
 
        local wave = Split(waveF.Text," ")[2]
        local minutes,seconds = Split(timeF.Text,":")[1],Split(timeF.Text,":")[2]
        return tonumber(wave),tonumber(minutes),tonumber(seconds)
    end
    table.sort(queue,compareTimes)
    --script
    timeF:GetPropertyChangedSignal("Text"):Connect(function()
        local wave,minutes,seconds = getcurrent()
        for i,v in ipairs(queue) do
            local Wave,Min,Sec = getTime(v)
            print(Wave,Min,Sec)
            print(wave,minutes,seconds)
            if compareTimes({Wave,Min,Sec},{wave,minutes,seconds} ) then
                --run code
                print("Testing")
                table.remove(1)
            else
                print("nope")
                break --Table in order, don't waste computing power looping it through
            end
        end
    end)
    
    end)
    if not suc then warn(err) else print("No errors!") end

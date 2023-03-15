SelectionMode = 1


function binding.nextFrame()
    moveTo(1.0)
end

function binding.previousFrame()
    moveTo(-1.0)
end

function moveTo(direction)
    local currentTime = player.CurrentTime()
    local deltaFrame = 1.0/player.FPS()
    local script = ofs.Script(ofs.ActiveIdx())
    local newAt = currentTime + deltaFrame*direction
    print("new at: ", newAt)

    if SelectionMode == 1 then
        local a = nil
        local idx = nil
        a, idx = script:closestAction(currentTime)
        if a ~= nil then
            script.actions[idx].at = newAt
        end
    else
        for idx, action in ipairs(script.actions) do
            if action.selected then
                action.at = newAt
                break
            end
        end
    end

    player.Seek(newAt)
    script:commit() 
end

function init()
    -- this runs once at when loading the extension
    -- ofs.Bind("nextFrame", "move to next frame.")
    -- ofs.Bind("previousFrame", "move to previous frame.")
    print("Move Action Advanced initialized")
    print("Video FPS", player.FPS())
end

function update(delta)
    -- this runs every OFS frame
    -- delta is the time since the last call in seconds
    -- doing heavy computation here will lag OFS
end

function gui()
    -- this only runs when the window is open
    -- and is the place where a custom gui can be created
    -- doing heavy computation here will lag OFS
    comboItems = {"Closest", "First selected"}
    SelectionMode, selectionChanged = ofs.Combo("Which Action?", SelectionMode, comboItems)

    if selectionChanged then
        print("Selection Mode changed to: ", comboItems[SelectionMode])
    end
end
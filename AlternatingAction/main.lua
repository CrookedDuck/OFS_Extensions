-- a script which inserts the action before the last action
-- helpful for scripting when distance is equal but rhythm is varying

function binding.alternatingAction()
    local currentTime = player.CurrentTime()
    local script = ofs.Script(ofs.ActiveIdx())

    print("Inserting previous action...")
    print("CurrentTimeMs: ", currentTime)
    local previous_action
    for idx, action in ipairs(script.actions) do
        if idx == #script.actions and previous_action ~= nil then
            if action.at ~= currentTime then
                script.actions:add(Action.new(currentTime, previous_action.pos, false))
                -- ofs.AddAction(script, currentTime, previous_action.pos, false)
                print("new action:", previous_action.pos )
		break
            end
        end
        previous_action = action
    end
    print("committing...")
    script:commit()
end

function init()
    -- this runs once at when loading the extension
    -- ofs.Bind("alternatingAction", "Insert pre-previous action at current position.")
    print("AlternatingAction initialized")
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
end

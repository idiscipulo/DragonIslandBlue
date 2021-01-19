StateManager = {}
StateManager.__index = StateManager

function StateManager:new(name)
    local stateManager = {}
    setmetatable(stateManager, StateManager)

    stateManager.name = name
    stateManager.states = {} 
    stateManager.curState = nil

    return stateManager
end

function StateManager:doesStateExist(name)
    for key, val in pairs(self.states) do
        if key == name then
            return true
        end
    end
    return false
end

function StateManager:addState(name, state)
    assert(not self:doesStateExist(name))

    self.states[name] = state
end

function StateManager:changeState(name, data)
    assert(self:doesStateExist(name))
    assert(data ~= nil)

    self.curState = name
    self.states[self.curState]:start(data)
end

function StateManager:update()
    assert(self.curState ~= nil)

    resp = self.states[self.curState]:update()

    if resp ~= nil then
        self:changeState(resp)
    end
end

function StateManager:draw()
    assert(self.curState ~= nil)
    self.states[self.curState]:draw()
end
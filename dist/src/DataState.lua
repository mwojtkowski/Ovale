local __addonName, __addon = ...
__addon.require(__addonName, __addon, "./src/DataState", { "./src/State", "./src/Requirement", "./src/Data" }, function(__exports, __State, __Requirement, __Data)
__exports.DataState = __class(nil, {
    CleanState = function(self)
    end,
    InitializeState = function(self)
    end,
    ResetState = function(self)
    end,
    CheckRequirements = function(self, spellId, atTime, tokens, index, targetGUID)
        return __Requirement.CheckRequirements(spellId, atTime, tokens, index, targetGUID)
    end,
    CheckSpellAuraData = function(self, auraId, spellData, atTime, guid)
        return __Data.OvaleData:CheckSpellAuraData(auraId, spellData, atTime, guid)
    end,
    CheckSpellInfo = function(self, spellId, atTime, targetGUID)
        return __Data.OvaleData:CheckSpellInfo(spellId, atTime, targetGUID)
    end,
    GetItemInfoProperty = function(self, itemId, atTime, property)
        return __Data.OvaleData:GetItemInfoProperty(itemId, atTime, property)
    end,
    GetSpellInfoProperty = function(self, spellId, atTime, property, targetGUID)
        return __Data.OvaleData:GetSpellInfoProperty(spellId, atTime, property, targetGUID)
    end,
})
__exports.dataState = __exports.DataState()
__State.OvaleState:RegisterState(__exports.dataState)
end)

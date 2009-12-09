local anvil = CreateFrame"Frame"
anvil:Hide()

anvil:RegisterEvent"CHAT_MSG_SYSTEM"
function anvil:CHAT_MSG_SYSTEM(event, msg)
	if(msg == TRANSFER_ABORT_TOO_MANY_REALM_INSTANCES) then
		print("|cff33ff99Anvil:|r Attempting to teleport again in 5. Write /anvil to disable.")
		self:Show()
	end
end

anvil:SetScript("OnEvent", function(self, event, ...)
	return self[event](self, event, ...)
end)

local time
anvil:SetScript("OnShow", function(self)
	time = 5
end)

anvil:SetScript("OnUpdate", function(self, elapsed)
	time = time - elapsed
	if(time < 0) then
		LFGTeleport()

		return self:Hide()
	end
end)

SLASH_ANVIL1 = '/anvil'

SlashCmdList['ANVIL'] = function()
	if(anvil:IsShown()) then
		anvil:Hide()
		print("|cff33ff99Anvil:|r Automatic teleport disabled.")
	else
		anvil:Show()
		print("|cff33ff99Anvil:|r Automatic teleport enabled.")
	end
end

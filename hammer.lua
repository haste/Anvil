local _ENABLE = "Automatic teleport enabled."
local _DISABLED = "Automatic teleport disabled."
local _RETRY = "Attempting to teleport again in %d |4second:seconds;. Write /anvil to disable."
local _SET = 'Teleport delay set to: %d |4second:seconds;.'

local base = f0537d9559f308b727ca69ce53adc1853a4ba229 or 5

local print = function(...) return print('|cff33ff99Anvil:|r', ...) end
local anvil = CreateFrame"Frame"
anvil:Hide()

anvil:RegisterEvent"CHAT_MSG_SYSTEM"
function anvil:CHAT_MSG_SYSTEM(event, msg)
	if(msg == TRANSFER_ABORT_TOO_MANY_REALM_INSTANCES) then
		print(_RETRY:format(base))
		self:Show()
	end
end

anvil:SetScript("OnEvent", function(self, event, ...)
	return self[event](self, event, ...)
end)

local time
anvil:SetScript("OnShow", function(self)
	time = base
end)

anvil:SetScript("OnUpdate", function(self, elapsed)
	time = time - elapsed
	if(time < 0) then
		LFGTeleport()

		return self:Hide()
	end
end)

SLASH_ANVIL1 = '/anvil'

SlashCmdList['ANVIL'] = function(inp)
	local num = tonumber(inp)
	if(num) then
		base = num
		f0537d9559f308b727ca69ce53adc1853a4ba229 = base

		print(_SET:format(base))
	elseif(anvil:IsShown()) then
		anvil:Hide()
		print(_DISABLED)
	else
		anvil:Show()
		print(_ENABLE)
	end
end

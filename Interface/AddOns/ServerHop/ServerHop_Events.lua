local globalOptions = hopAddon.optionsFrame.globalOptionsFrame

local function StatusEvents(self, event, ...)
	if event == "GROUP_ROSTER_UPDATE" then
		-- we're not in group, we're updating searching mode (move to a different event?)
		if NotInGroup() then
			hopAddon.hopStatus.groupStatusFrame:Hide()
			
			-- check if searching, then show another frame
			if (false) then
			
			else -- if not searching and not in group, there's no status to show
				hopAddon.hopStatus:Hide()
			end
		else -- if we're in group, we're updating current group mode
			if globalOptions.statusCheckButton:GetChecked() then
				hopAddon.hopStatus:Show()
			end
			hopAddon.hopStatus.groupStatusFrame:Show()
			
			-- set name to default if we're not in lfg group
			if not C_LFGList.GetActiveEntryInfo() then
				hopAddon.hopStatus.groupStatusFrame.groupName:SetText(HOPADDON_NOTLFGGROUP)
			end
			
			local index = GetNumGroupMembers()
			local tank =0 local heal = 0 local dps = 0
			if IsInRaid() then
				hopAddon.hopStatus.groupStatusFrame.SetRaid(true,UnitIsGroupLeader("player"))
				for i=1,index do
					local role = UnitGroupRolesAssigned("raid"..i)
					if role == "TANK" then
						tank = tank + 1
					elseif role == "HEALER" then
						heal = heal + 1
					elseif role == "DAMAGER" then
						dps = dps + 1
					end
				end
			else
				hopAddon.hopStatus.groupStatusFrame.SetRaid(false,UnitIsGroupLeader("player"))
				-- group roles (player can't be dected as a part of the group, only raid)
				for i=1,(index-1) do
					local role = UnitGroupRolesAssigned("party"..i)
					if role == "TANK" then
						tank = tank + 1
					elseif role == "HEALER" then
						heal = heal + 1
					elseif role == "DAMAGER" then
						dps = dps + 1
					end
				end
				-- player role
				local role = UnitGroupRolesAssigned("player")
				if role == "TANK" then
					tank = tank + 1
				elseif role == "HEALER" then
					heal = heal + 1
				elseif role == "DAMAGER" then
					dps = dps + 1
				end
			end
			
			hopAddon.hopStatus.groupStatusFrame.playerCountFrame.setPlayerCount(tank,heal,dps)
			
			-- enable party functions if leader
			if UnitIsGroupLeader("player") then
				if IsInRaid() then
					hopAddon.hopStatus.groupStatusFrame.convertToRaid:Hide()
					hopAddon.hopStatus.groupStatusFrame.convertToParty:Show()
					if GetNumGroupMembers() <= 5 then
						hopAddon.hopStatus.groupStatusFrame.convertToParty:Enable()
					else
						hopAddon.hopStatus.groupStatusFrame.convertToParty:Disable()						
					end
				else
					hopAddon.hopStatus.groupStatusFrame.convertToParty:Hide()				
					hopAddon.hopStatus.groupStatusFrame.convertToRaid:Show()
				end
			else
				hopAddon.hopStatus.groupStatusFrame.convertToParty:Hide()				
				hopAddon.hopStatus.groupStatusFrame.convertToRaid:Hide()			
			end
		end	
	
	elseif event == "LFG_LIST_ACTIVE_ENTRY_UPDATE" then
		local active, activityID, ilvl, name, comment, voiceChat, duration, autoAccept = C_LFGList.GetActiveEntryInfo()
		
		hopAddon.hopStatus.groupStatusFrame.UpdateGroup(name,autoAccept)
		
	elseif event == "LFG_LIST_APPLICANT_LIST_UPDATED" or event == "LFG_LIST_APPLICANT_UPDATED" then
		-- RECHECK EVENTS PLOX
		
		-- show queued players if promoted or leader
		if UnitIsRaidOfficer("player") or UnitIsGroupLeader("player") then
			-- show invite frames
		end	
	end
end

hopAddon.hopStatus:SetScript("OnEvent", StatusEvents)
hopAddon.hopStatus:RegisterEvent("GROUP_ROSTER_UPDATE")
hopAddon.hopStatus:RegisterEvent("LFG_LIST_JOINED_GROUP")
hopAddon.hopStatus:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
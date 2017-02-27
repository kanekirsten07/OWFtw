-- Addon is based on DK_Sounds from NTex
-- Create the base variable array
OWFtw = {}

-- General stuff
OWFtw.Version = "1.05";
OWFtw.Title = "OverwatchSounds " .. OWFtw.Version;

-- Events Table
OWFtw.events = {}

-- Invisible frame to grab events
OWFtw.eventFrame = CreateFrame("Frame")
OWFtw.eventFrame:SetScript("OnEvent", function(this, event, ...) OWFtw.events[event](...) end)

OWFtw.eventFrame:RegisterEvent("ADDON_LOADED");
OWFtw.eventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
OWFtw.eventFrame:RegisterEvent("PLAYER_LOGIN");
OWFtw.eventFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
OWFtw.eventFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
OWFtw.eventFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
OWFtw.eventFrame:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND");
OWFtw.eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
OWFtw.eventFrame:RegisterEvent("BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE");


OWFtw.CharName = UnitName("player");


OWFtwtimer1 = GetTime()
OWFtwtimer2 = GetTime()
OWFtwtimer3 = GetTime()
OWFtwktime = GetTime()
OWFtwres = 0
OWFtwbreite = 0
OWFtwhoehe = 0
OWFtwframex = 0
OWFtwframey = 0
OWFtwpve = 1
OWFtwpvemerk = 1
OWFtwgender = 0
OWFtwisplayer = 0
OWFtwx = 0
OWFtwzuf = 0
OWFtwtest = 0
OWFtwtest2 = 0
OWFtwtest3 = 0
OWFtwtest4 = 0
OWFtwkills = 0
OWFtwtkills = 0
OWFtwfatality = 0
OWFtwrtest = 0
OWFtwkmerk = 0
OWFtwkwait = 60

SLASH_OWFtwhelp1 = '/OWFtw'
function SlashCmdList.OWFtwhelp(msg, editbox)
	if (msg == "help") then 
		DEFAULT_CHAT_FRAME:AddMessage("Console Commands: ");
		DEFAULT_CHAT_FRAME:AddMessage("/pve on 'pve sounds on'"); 
		DEFAULT_CHAT_FRAME:AddMessage("/pve off 'pve sounds off'");
		DEFAULT_CHAT_FRAME:AddMessage("/reset 'resets all OverwatchSounds variables'");
	else 
		DEFAULT_CHAT_FRAME:AddMessage("Console Commands: ");
		DEFAULT_CHAT_FRAME:AddMessage("/pve on 'pve sounds on'"); 
		DEFAULT_CHAT_FRAME:AddMessage("/pve off 'pve sounds off'");
		DEFAULT_CHAT_FRAME:AddMessage("/reset 'resets all OverwatchSounds variables'");
	end
end

SLASH_OWFtwpve1 = '/pve'
function SlashCmdList.OWFtwpve(msg, editbox)
	if (msg == "on") then OWFtwpve = 1; OWFtwpvemerk = 0; DEFAULT_CHAT_FRAME:AddMessage("OverwatchSounds pve sounds are " .. msg .. " now!");
	elseif (msg == "off") then OWFtwpve = 0; OWFtwpvemerk = 0; DEFAULT_CHAT_FRAME:AddMessage("OverwatchSounds pve sounds are " .. msg .. " now!");
	else DEFAULT_CHAT_FRAME:AddMessage("Type in '/pve on' or /pve off'."); end;
end

SLASH_OWFtw1 = '/reset'
function SlashCmdList.OWFtw(msg, editbox)
	OWFtwtimer1 = GetTime()
	OWFtwtimer2 = GetTime()
	OWFtwtimer3 = GetTime()
	OWFtwktime = GetTime()
	OWFtwpve = 1
	OWFtwpvemerk = 1
	OWFtwgender = 0
	OWFtwisplayer = 0
	OWFtwx = 0
	OWFtwzuf = 0
	OWFtwtest = 0
	OWFtwtest2 = 0
	OWFtwtest3 = 0
	OWFtwtest4 = 0
	OWFtwkills = 0
	OWFtwtkills = 0
	OWFtwfatality = 0
	OWFtwrtest = 0
	OWFtwkmerk = 0
	OWFtwkwait = 60
	OWFtwfont:SetText("")
	OWFtwfont2:SetText("")
	OWFtwf:Show();
	DEFAULT_CHAT_FRAME:AddMessage("All Overwatch Sound variables reset!");
end

function OWFtw.events.ADDON_LOADED(addon)
    if addon ~= "OWFtw" then return end
    DEFAULT_CHAT_FRAME:AddMessage("OverwatchSounds " .. OWFtw.Version .. " loaded sucessfully!")
    SetCVar("violencelevel", 5)
end

function OWFtw.events.PLAYER_LOGIN()
	PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwwelcome.mp3")
	OWFtwres = GetCurrentResolution();
	if (OWFtwres == 1) then OWFtwbreite = 720; OWFtwhoehe = 576; end;
	if (OWFtwres == 2) then OWFtwbreite = 800; OWFtwhoehe = 600; end;
	if (OWFtwres == 3) then OWFtwbreite = 832; OWFtwhoehe = 624; end;
	if (OWFtwres == 4) then OWFtwbreite = 1024; OWFtwhoehe = 768; end;
	if (OWFtwres == 5) then OWFtwbreite = 1280; OWFtwhoehe = 720; end;
	if (OWFtwres == 6) then OWFtwbreite = 1280; OWFtwhoehe = 768; end;
	if (OWFtwres == 7) then OWFtwbreite = 1152; OWFtwhoehe = 846; end;
	if (OWFtwres == 8) then OWFtwbreite = 1280; OWFtwhoehe = 800; end;
	if (OWFtwres == 9) then OWFtwbreite = 1280; OWFtwhoehe = 960; end;
	if (OWFtwres == 10) then OWFtwbreite = 1280; OWFtwhoehe = 1024; end;
	OWFtwframex = ceil(OWFtwbreite / 160);
	OWFtwframey = 40 - (ceil(OWFtwhoehe / 8.54));

	-- frameOWFtwtest
	OWFtwf = CreateFrame("MessageFrame", "OWFtw", UIParent)
	OWFtwf:SetHeight(64)
	OWFtwf:SetWidth(256)
	OWFtwf:SetPoint("LEFT", UIParent, OWFtwframex, OWFtwframey)
	OWFtwf:Show() 

	OWFtwfont = OWFtw:CreateFontString(nil,"OVERLAY")
	OWFtwfont:SetFontObject("GameFontNormal")
	OWFtwfont:SetHeight(32)
	OWFtwfont:SetWidth(256)
	OWFtwfont:SetPoint("CENTER", OWFtw, "CENTER",0 ,0)
	OWFtwfont:SetJustifyH("LEFT")
	OWFtwfont:SetJustifyV("BOTTOM")
	OWFtwfont:SetText("")

	OWFtwfont2 = OWFtw:CreateFontString(nil, "OVERLAY")
	OWFtwfont2:SetFontObject("GameFontNormal")
	OWFtwfont2:SetHeight(32)
	OWFtwfont2:SetWidth(256)
	OWFtwfont2:SetPoint("CENTER", OWFtw, "CENTER",0 ,6)
	OWFtwfont2:SetJustifyH("LEFT")
	OWFtwfont2:SetJustifyV("TOP")
	OWFtwfont2:SetText("")
end

function OWFtw.events.PLAYER_ENTERING_BATTLEGROUND()
	DEFAULT_CHAT_FRAME:AddMessage("Battleground detected!");
	PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwinitializingmatch.mp3")
	OWFtwpvemerk = OWFtwpve;
	OWFtwpve = 0;
	OWFtwtkills = 0;
	OWFtwkills = 0;
	OWFtwfatality = 0;
	OWFtwktime = GetTime();
	OWFtwx = 0;
	OWFtwkmerk = 0;
end

function OWFtw.events.BATTLEFIELD_MGR_QUEUE_REQUEST_RESPONSE()
OWFtwzuf = math.random(5);
		if (OWFtwzuf == 1) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwdorado.mp3") end;
		if (OWFtwzuf == 2) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwvolskaya.mp3") end;
		if (OWFtwzuf == 3) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwnumbani.mp3") end;
		if (OWFtwzuf == 4) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwhanamura.mp3") end;
		if (OWFtwzuf == 5) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwhollywood.mp3") end;
end

function OWFtw.events.PLAYER_ENTERING_WORLD()
	OWFtwpve = OWFtwpvemerk;
end

function OWFtw.events.PLAYER_REGEN_DISABLED()
	OWFtwkmerk = OWFtwtkills;
	PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwpreparetoattack.mp3")
end



function OWFtw.events.PLAYER_TARGET_CHANGED()
	if (UnitHealth("target") > 0) then
		OWFtwzuf = math.random(2);
		if (OWFtwzuf == 1) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwcharacterselect.mp3") end;
		if (OWFtwzuf == 2) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwcharacterselect.mp3") end;
		if (UnitIsPlayer("target")) then OWFtwisplayer = 1 else OWFtwisplayer = 0 end
		OWFtwgender = UnitSex("target");
--		DEFAULT_CHAT_FRAME:AddMessage("is player ".. OWFtwisplayer .. " with OWFtwgender " .. OWFtwgender .. "");
	else
		OWFtwisplayer = 0;
		OWFtwgender = UnitSex("target");
--		DEFAULT_CHAT_FRAME:AddMessage("is player ".. OWFtwisplayer .. " with OWFtwgender " .. OWFtwgender .. ""); 
		return;
	end
end



function OWFtw.events.COMBAT_LOG_EVENT_UNFILTERED
    (timestamp, event, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, ...)

    if (event == "ENVIRONMENTAL_DAMAGE") and (dstName == OWFtw.CharName) and (UnitHealth("player") / UnitHealthMax("player") <= 0.1) and (UnitHealth("player") > 1) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\dmml.mp3"); end

    if (srcName == OWFtw.CharName) then
        if (event == "SPELL_CAST_SUCCESS") or (event == "SWING_CAST_SUCCESS") or (event == "RANGE_CAST_SUCCESS") or (event == "SPELL_ENCHANT_APPLIED") or (event == "CURRENT_SPELL_CAST_CHANGED")then
            local sid, spellName = ...

--	    DEFAULT_CHAT_FRAME:AddMessage("spellid: ".. sid .. "");

--          Death Knight
            if (sid == 49576) or (sid == 71)then
                   PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwcomehere.mp3")
            end 
			if(sid == 48263) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwdontworry.mp3"); end;
			
			if (sid == 42650) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwdeathwalksamongyou.mp3"); end;
-- 			Mage			
			if (sid == 43571) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwcoldasice.mp3"); end;
			
			if (sid == 120) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwcoldsnap.mp3"); end;
			if (sid == 56936) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwblizzard.mp3"); end;
			
			if(sid == 31661) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwdragonconsume.mp3"); end;
			if(sid == 122) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwfreeze.mp3"); end;
			
-- 			Warrior
			if(sid == 23931) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwhammerdown.mp3"); end;
			if(sid == 100) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwcomeout.mp3"); end;
-- 			Hunter
			if (sid == 1130) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwgotyouinmysights.mp3")
			end
-- 			Shaman
			if (sid == 1064) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwgotyouinmysights.mp3")
			end
-- 			Druid
			if (sid == 5185) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwhealup.mp3")
			if (sid == 740) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwhealingboost.mp3")
--			Warlock  
			if (sid == 5740) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwjusticerains.mp3")
			if (sid == 29722) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtw.mp3")
--			Priest
			if (sid == 34861) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwgotyouinmysights.mp3")
			end
			
-- 			Paladin
			if (sid == 24275) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwgotyouinmysights.mp3")
			end
	end

      if (OWFtwisplayer == 1) or (OWFtwpve == 1) then
	if (event == "SPELL_DAMAGE") or (event == "SPELL_PERIODIC_DAMAGE") then
		local spellId, spellName, spellSchool, amount, overkill, school, resisted, blocked, absorbed, critical = ...
		OWFtwtest = GetTime() - OWFtwktime;
		OWFtwrtest = ceil(OWFtwtest);

		if ((UnitHealth("target") / UnitHealthMax("target")) <= 0.30) and (overkill < 1) and (OWFtwx == 0) then
		print("finish him" );
			if (OWFtwgender == 1) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtweliminate.mp3") end
			if (OWFtwgender == 2) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwfinishthem.mp3") end
			if (OWFtwgender == 3) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwoutoftime.mp3") end
			OWFtwx = 1; 
		end

		if (critical == 1) and (overkill == -1) then 
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwcrit.mp3")
			
		end

		if (critical == 1) and (overkill > 0) and (UnitHealthMax("target") > 1) then 
			OWFtwzuf = math.random(3) 
			if (OWFtwzuf == 1) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwannouncervictory.mp3"); end;
			if (OWFtwzuf == 2) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwexcellent.mp3"); end;
			if (OWFtwzuf == 3) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwepic.mp3"); end;
			OWFtwx = 0;
			OWFtwkills = OWFtwkills + 1; OWFtwtkills = OWFtwtkills + 1; OWFtwfatality = OWFtwfatality + 1;
			OWFtwktime = GetTime(); 
			if (OWFtwkills > 1) then
				OWFtwfont:SetText("You did " .. OWFtwkills .. " kills in a row! Last kill was " .. OWFtwrtest .. " seconds ago.")
				OWFtwfont2:SetText("kills total: ".. OWFtwtkills .. " with " .. OWFtwfatality .. " fatalities!");
				OWFtwf:Show();
			else 
				OWFtwfont:SetText("First kill after " .. OWFtwrtest .. " seconds!"); 
				OWFtwfont2:SetText("kills total: ".. OWFtwtkills .. " with " .. OWFtwfatality .. " fatalities!");
				OWFtwf:Show();
			end
		else
			if (overkill > 0) and (UnitHealthMax("target") > 1) then
				if ((GetTime() - OWFtwktime) < OWFtwkwait) and (OWFtwkills > 0) and (UnitHealth("player") > 1) then
					OWFtwtest = GetTime() - OWFtwktime;
					OWFtwrtest = ceil(OWFtwtest);
					OWFtwktime = GetTime();
					if (OWFtwtest >= 1) then
						OWFtwx = 0;
						OWFtwkills = OWFtwkills + 1; OWFtwtkills = OWFtwtkills + 1;
						if (OWFtwkills == 2) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwexcellent.mp3"); end
						if (OWFtwkills == 3) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwlegendary.mp3"); end
						if (OWFtwkills == 4) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwepic.mp3"); end
						
					OWFtwfont:SetText("You did " .. OWFtwkills .. " kills in a row! Last kill was " .. OWFtwrtest .. " seconds ago.")
					OWFtwfont2:SetText("kills total: ".. OWFtwtkills .. " with " .. OWFtwfatality .. " fatalities!");
					OWFtwf:Show();
					end
				elseif (OWFtwkills == 0) then
					OWFtwx = 0;
					OWFtwkills = OWFtwkills + 1; OWFtwtkills = OWFtwtkills + 1;
					OWFtwtest = GetTime() - OWFtwktime;
					OWFtwrtest = ceil(OWFtwtest);
					OWFtwktime = GetTime();
					PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\excellent.mp3");
					OWFtwfont:SetText("First kill after " .. OWFtwrtest .. " seconds!");
					OWFtwfont2:SetText("kills total: ".. OWFtwtkills .. " with " .. OWFtwfatality .. " fatalities!");
					OWFtwf:Show();
				end
			end
		end
	end

	if (event == "SWING_DAMAGE") then
		local amount, overkill, school, resisted, blocked, absorbed, critical = ...
		OWFtwtest = GetTime() - OWFtwktime;
		OWFtwrtest = ceil(OWFtwtest);

		if ((UnitHealth("target") / UnitHealthMax("target")) <= 0.30) and (overkill < 1) and (OWFtwx == 0) then
			if (OWFtwgender == 1) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtweliminate.mp3") end
			if (OWFtwgender == 2) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwfinishthem.mp3") end
			if (OWFtwgender == 3) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwoutoftime.mp3") end
			OWFtwx = 1; 
		end

		if (critical == 1) and (overkill == -1) then
			PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwcrit.mp3")
		end

		if (critical == 1) and (overkill > 0) and (UnitHealthMax("target") > 1) then
			OWFtwzuf = math.random(3) 
			if (OWFtwzuf == 1) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwexcellent.mp3"); end;
			if (OWFtwzuf == 2) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwlegendary.mp3"); end;
			if (OWFtwzuf == 3) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwepic.mp3"); end;
			OWFtwx = 0;
			OWFtwkills = OWFtwkills + 1; OWFtwtkills = OWFtwtkills + 1; OWFtwfatality = OWFtwfatality + 1;
			OWFtwktime = GetTime(); 
			if (OWFtwkills > 1) then
				
				OWFtwfont:SetText("You did " .. OWFtwkills .. " kills in a row! Last kill was " .. OWFtwrtest .. " seconds ago.")
				OWFtwfont2:SetText("kills total: ".. OWFtwtkills .. " with " .. OWFtwfatality .. " fatalities!");
				OWFtwf:Show();
				PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwkillstreak.mp3")
			else 
				OWFtwfont:SetText("First kill after " .. OWFtwrtest .. " seconds!")
				OWFtwfont2:SetText("kills total: ".. OWFtwtkills .. " with " .. OWFtwfatality .. " fatalities!");
				OWFtwf:Show();
			end
		else
			if (overkill > 0) and (UnitHealthMax("target") > 1) then
				if ((GetTime() - OWFtwktime) < OWFtwkwait) and (OWFtwkills > 0) and (UnitHealth("player") > 1) then
					OWFtwtest = GetTime() - OWFtwktime;
					OWFtwrtest = ceil(OWFtwtest);
					OWFtwktime = GetTime();
					if (OWFtwtest >= 1) then
						OWFtwx = 0;
						OWFtwkills = OWFtwkills + 1; OWFtwtkills = OWFtwtkills + 1;
						if (OWFtwkills == 2) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwexcellent.mp3"); end
						if (OWFtwkills == 3) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwlegendary.mp3"); end
						if (OWFtwkills == 4) then PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\OWFtwepic.mp3"); end
						
					OWFtwfont:SetText("You did " .. OWFtwkills .. " kills in a row! Last kill was " .. OWFtwrtest .. " seconds ago.")
					OWFtwfont2:SetText("kills total: ".. OWFtwtkills .. " with " .. OWFtwfatality .. " fatalities!");
					OWFtwf:Show();
					end
				elseif (OWFtwkills == 0) then
					OWFtwx = 0;
					OWFtwkills = OWFtwkills + 1; OWFtwtkills = OWFtwtkills + 1;
					OWFtwtest = GetTime() - OWFtwktime;
					OWFtwrtest = ceil(OWFtwtest);
					OWFtwktime = GetTime();
					PlaySoundFile("Interface\\AddOns\\OverwatchSounds\\Sounds\\excellent.mp3");
					OWFtwfont:SetText("First kill after " .. OWFtwrtest .. " seconds!");
					OWFtwfont2:SetText("kills total: ".. OWFtwtkills .. " with " .. OWFtwfatality .. " fatalities!");
					OWFtwf:Show();
				end
			end
		end
	end
      end
    end

    function ActionButton_OnUpdate()
    OWFtwtest = GetTime() - OWFtwktime;
    OWFtwrtest = ceil(OWFtwtest);



	if ((GetTime() >= OWFtwtimer3 + 10) and (OWFtwtest4 == 1)) then
		OWFtwtimer3 = GetTime();
		OWFtwtest4 = 0;
		OWFtwf:Hide();
	end
    end
end

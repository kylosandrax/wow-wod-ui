local DEBUG = true					--|
local DEBUG_COMBAT_LOG = false		--|
local VERSION = 2.35				--|
--------------------------------------
local getnB = 15
local timer,temp,timer2 = 0,true,0
local O,Ot,Oo = {},{},{}
local TESTMODE = false
local _,CLASS = UnitClass("player")
local NAME = UnitName("player")
local REALM = GetRealmName()
local SPE_ACTIVE = GetActiveSpecGroup()
local SPE_INACTIVE
local COMBAT = false
if SPE_ACTIVE == 1 then
	SPE_INACTIVE = 2
else
	SPE_INACTIVE = 1
end
local DAMAGE = {}
for i=1,50 do DAMAGE[i] = 0 end
local DMG = 1
local PROFILE,PROFILENB,PROFILESELECTED = "",0,0
local C_ORANGE = "|cffe04000"
local C_BLEU = "|cff0090e0"
local C_VIOLET = "|cffe020e0"

local DATE
local FIRST_CALL_ACTIVE_TALENT_GROUP_CHANGED = true


local ERRORCOUNT = 0
local OPTIONTEXTHEIGHT = 12
------------------------------
local getn = table.getn
------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------ LIB
local LSM = LibStub("LibSharedMedia-3.0")
------------------------------------------
function Sh_LSM_Find(var,item,type)
	for j=1,getn(item) do
		if var == LSM:Fetch(type,item[j]) then
			return item[j]
		end
	end
end
local M_statusbar = {}
for i=1,getn(LSM:List("statusbar")) do
   M_statusbar[i] = LSM:List("statusbar")[i]
end
local M_font = {}
for i=1,getn(LSM:List("font")) do
   M_font[i] = LSM:List("font")[i]
end
local M_border = {}
for i=1,getn(LSM:List("border")) do
   M_border[i] = LSM:List("border")[i]
end
local M_background = {}
for i=1,getn(LSM:List("background")) do
   M_background[i] = LSM:List("background")[i]
end


------------------------------------------









------------------------------------------
function Sh_OnLoad()
   ------------------------------------------
   
   
   


   
   
   -- Slash command
	SLASH_ShieldHealth1 = "/ShieldHealth"
	SLASH_ShieldHealth2 = "/sh"
	SlashCmdList["ShieldHealth"] = function(arg)
		if arg == "" then 
			InterfaceOptionsFrame_OpenToCategory("ShieldHealth")
		end
		if arg == "toggle" then
			Sh_print(arg)
		end
	end
	
	
	
   -- Event
	Sh_EventFrame1 = CreateFrame("Frame", "Sh_EventFrame1", UIParent)
	Sh_EventFrame1:SetScript("OnEvent", Sh_EventFrame_OnEvent)
	Sh_EventFrame1bisbis = CreateFrame("Frame", "Sh_EventFrame1bisbis", UIParent)
	Sh_EventFrame1bisbis:SetScript("OnEvent", Sh_spe_change)
	
	Sh_EventFrame2 = CreateFrame("Frame", "Sh_EventFrame2", UIParent)
	Sh_EventFrame2:RegisterEvent("VARIABLES_LOADED")
	Sh_EventFrame2:SetScript("OnEvent", Sh_opt_LOAD)
	Sh_EventFrame3 = CreateFrame("Frame", "Sh_EventFrame3", UIParent)
	
	Sh_EventFrame3:SetScript("OnEvent", Sh_EventFrame3_OnEvent)
	
	Sh_EventFrame4 = CreateFrame("Frame", "Sh_EventFrame4", UIParent)
	Sh_EventFrame4:SetScript("OnEvent", function()
			Sh_date()
		end
	)
	
	Sh_EventFrame5 = CreateFrame("Frame", "Sh_EventFrame5", UIParent)
	Sh_EventFrame5:SetScript("OnEvent", function()
			COMBAT = true
		end
	)
	
	Sh_EventFrame6 = CreateFrame("Frame", "Sh_EventFrame6", UIParent)
	Sh_EventFrame6:SetScript("OnEvent", function()
			COMBAT = false
		end
	)
	--Sh_EventFrame7 = CreateFrame("Frame", "Sh_EventFrame6", UIParent)
	--Sh_EventFrame7:SetScript("OnEvent", Sh_message)

	-- Timer
	timer = 0
	local timerframe = CreateFrame("frame")
	timerframe:SetScript("OnUpdate", Sh_timer)
	timer2 = 0
	local timerframe2 = CreateFrame("frame")
	timerframe2:SetScript("OnUpdate", Sh_timer2)

	-- Fonctions
	Sh_options()
	Sh_createBar()
	Sh_OnEvent("player")
	Sh_OnEvent("target")
 
end

function Sh_date()
	local _,x3,x2,x4 = CalendarGetDate()
	x4 = 365 * (x4 - 2011)
	if x3 == 1 then x3 = 0
	elseif x3 == 2 then x3 = 31
	elseif x3 == 3 then x3 = 59
	elseif x3 == 4 then x3 = 90
	elseif x3 == 5 then x3 = 120
	elseif x3 == 6 then x3 = 151
	elseif x3 == 7 then x3 = 181
	elseif x3 == 8 then x3 = 212
	elseif x3 == 9 then x3 = 243
	elseif x3 == 10 then x3 = 273
	elseif x3 == 11 then x3 = 304
	elseif x3 == 12 then x3 = 334	end
	DATE = x2+x3+x4

    if Sh_DB["Profile"][NAME .. "-" .. REALM]["info"] ~= nil then
		Sh_DB["Profile"][NAME .. "-" .. REALM]["info"]["time"] = DATE
	end
end

 

function Sh_options()
	-- Lancé après VARIABLES_LOADED
	------------------------------------------
   
	------------------------
	-- Options par défaut --
	------------------------
	O = {
		["enable"] = true,
		["short"] = false,
		["blink"] = true,
		["show_only_in_combat"] = false,
		

		["f:largeur"] = 210, -- Largeur barre du fond
		["f:hauteur"] = 30, -- Hauteur barre du fond
		["iconsize"] = 27, -- Taille des icones
		["autoicon"] = false,
		["level"] = 1,
		["f:pos:1"] = "CENTER",
		["f:pos:2"] = nil,
		["f:pos:3"] = "CENTER",
		["f:pos:4"] = 0,
		["f:pos:5"] = -50,
		
		["tex_barre"] = "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar", -- Texture des barres des boucliers
		["f:tex:fond"] = "Interface\\Tooltips\\UI-Tooltip-Background", -- Texture du fond de la barre du fond
		["f:tex:border"] = "Interface\\Tooltips\\UI-Tooltip-Border", -- Texture de la bordeure de la barre du fond
		["font:val"] = "Fonts\\FRIZQT__.TTF", -- Text de la valeur des boucliers
		
		["border:size"] = 4,
		["insets:left"] = 2,
		["insets:right"] = 2,
		["insets:top"] = 2,
		["insets:bottom"] = 2,
		
		
		["font:val:size"] = 18,
		["font:val:r"] = 0.8,
		["font:val:v"] = 1,
		["font:val:b"] = 0.9,
		["font:val:a"] = 1,
		["contour"] = false,

		["f:SBC:r"] = 1, -- Couleur du fond des barres
		["f:SBC:v"] = 1,
		["f:SBC:b"] = 1,
		["f:SBC:a"] = 0.5,

		["b:a"] = 100,

		 -- Couleur des barres des boucliers
		["1:r"] = 0.6,
		["1:v"] = 0.8,
		["1:b"] = 0,
		
		["2:r"] = 0.8,
		["2:v"] = 0,
		["2:b"] = 0,
		
		["3:r"] = 0,
		["3:v"] = 0.2,
		["3:b"] = 1,
		
		["4:r"] = 1,
		["4:v"] = 1,
		["4:b"] = 1,
		
		["5:r"] = 1,
		["5:v"] = 0.3,
		["5:b"] = 0,
		
		["6:r"] = 0.5,
		["6:v"] = 1,
		["6:b"] = 0.6,
		
		["7:r"] = 0.7,
		["7:v"] = 0.7,
		["7:b"] = 0.7,
		
		["8:r"] = 0.9,
		["8:v"] = 0.7,
		["8:b"] = 0,
		
		["9:r"] = 1,
		["9:v"] = 0.95,
		["9:b"] = 0.77,
		
		["10:r"] = 1,
		["10:v"] = 0.7,
		["10:b"] = 0.3,
		
		["11:r"] = 0.8,
		["11:v"] = 1,
		["11:b"] = 1,
		
		["12:r"] = 1,
		["12:v"] = 0.7,
		["12:b"] = 0,
		
		["13:r"] = 1,
		["13:v"] = 0.7,
		["13:b"] = 0,
		
		["14:r"] = 1,
		["14:v"] = 1,
		["14:b"] = 0,
		
		["15:r"] = 0.7,
		["15:v"] = 0,
		["15:b"] = 0.7,
	}
	
	Ot = {
		["enable"] = true,
		["short"] = false,
		["blink"] = true,
		["show_only_in_combat"] = false,


		["f:largeur"] = 210,
		["f:hauteur"] = 30,
		["iconsize"] = 27,
		["autoicon"] = false,
		["level"] = 1,
		["f:pos:1"] = "CENTER",
		["f:pos:2"] = nil,
		["f:pos:3"] = "CENTER",
		["f:pos:4"] = 0,
		["f:pos:5"] = -100,
		["tex_barre"] = "Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar",
		["f:tex:fond"] = "Interface\\Tooltips\\UI-Tooltip-Background",
		["f:tex:border"] = "Interface\\Tooltips\\UI-Tooltip-Border",
		["font:val"] = "Fonts\\FRIZQT__.TTF",
		["border:size"] = 5,

		["font:val:size"] = 18,
		["font:val:r"] = 0.8,
		["font:val:v"] = 1,
		["font:val:b"] = 0.9,
		["font:val:a"] = 1,
		["contour"] = false,

		["f:SBC:r"] = 1,
		["f:SBC:v"] = 1,
		["f:SBC:b"] = 1,
		["f:SBC:a"] = 0.5,
		
		["border:size"] = 4,
		["insets:left"] = 2,
		["insets:right"] = 2,
		["insets:top"] = 2,
		["insets:bottom"] = 2,

		["b:a"] = 100,

		 -- Couleur des barres des boucliers
		["1:r"] = 0.6,
		["1:v"] = 0.8,
		["1:b"] = 0,
		
		["2:r"] = 0.8,
		["2:v"] = 0,
		["2:b"] = 0,
		
		["3:r"] = 0,
		["3:v"] = 0.2,
		["3:b"] = 1,
		
		["4:r"] = 1,
		["4:v"] = 1,
		["4:b"] = 1,
		
		["5:r"] = 1,
		["5:v"] = 0.3,
		["5:b"] = 0,
		
		["6:r"] = 0.5,
		["6:v"] = 1,
		["6:b"] = 0.6,
		
		["7:r"] = 0.7,
		["7:v"] = 0.7,
		["7:b"] = 0.7,
		
		["8:r"] = 0.9,
		["8:v"] = 0.7,
		["8:b"] = 0,
		
		["9:r"] = 1,
		["9:v"] = 0.95,
		["9:b"] = 0.77,
		
		["10:r"] = 1,
		["10:v"] = 0.7,
		["10:b"] = 0.3,
		
		["11:r"] = 0.8,
		["11:v"] = 1,
		["11:b"] = 1,
		
		["12:r"] = 1,
		["12:v"] = 0.7,
		["12:b"] = 0,
		
		["13:r"] = 1,
		["13:v"] = 0.7,
		["13:b"] = 0,
		
		["14:r"] = 1,
		["14:v"] = 1,
		["14:b"] = 0,
		
		["15:r"] = 0.7,
		["15:v"] = 0,
		["15:b"] = 0.7,
	}
	
	
	Oo["Ord"] = {}
	Oo["Ord:toggle"] = {}
	Oo["Ord:icon"] = {}
	
	for i=1,getnB do
		Oo["Ord"][i] = i
		Oo["Ord:toggle"][i] = true
		Oo["Ord:icon"][i] = true
	end
	
	Oo["cooldown"] = {
		["enable"] = true,
		["largeur"] = 27,
		["hauteur"] = 27,
		["level"] = 1,
		["pos:1"] = "CENTER",
		["pos:2"] = nil,
		["pos:3"] = "CENTER",
		["pos:4"] = -125,
		["pos:5"] = -60,
		["tex:border"] = "Interface\\Tooltips\\UI-Tooltip-Border",
		["border"] = true,
		["border:width"] = 9,
		["inset"] = 2,
		["anchored"] = true,
		["anchor"] = -15,
		["modules"] = {
				["rapture"] = true
			}
	}
end

------------------------------------------ Variables
------------------------------------------------------------------------------------

------------------------------------------ Tables bouclier
local B = {} -- Nom
------
local Bv = {} -- Valeur
local Bmv = {} -- Valeur max
local Bt = {} -- Temps
local Bmt = {} -- Temps max
local Bf = {} -- Frames barres status bouclier
------
local Bvtar = {} -- Valeur
local Bttar = {} -- Temps
local Bmttar = {} -- Temps max
local Bftar = {} -- Frames barres status bouclier
for i=1,getnB do
	Bv[i],Bmv[i],Bt[i],Bmt[i],Bf[i] = 0,0,0,0,0
	Bvtar[i],Bttar[i],Bmttar[i],Bftar[i] = 0,0,0,0,0
end
------------------------------------------
local bg,blink,f,ft1,fb,fb2,i1,i2,i1CD,i2CD,fbck -- Frames
local bgtar,blinktar,ftar,fbtar,fb2tar,ft1tar,i1tar,i2tar,i1CDtar,i2CDtar,fbcktar-- Frame target

local color,color_tex,color_text = {},{},{}
local colortar,color_textar,color_texttar = {},{},{}

--------------------------------------------------------------------
local Ordre = {} --------------------------------------------------- ORDRE
Ordre["ordre"] = {} -- frame fond
Ordre["icon"] = {} -- icone
Ordre["icontex"] = {} -- texture icone
Ordre["up"] = {} -- bouton haut
Ordre["down"] = {} -- bouton bas
Ordre["text"] = {} -- texte
Ordre["toggle"] = {} -- checkbox activation bouclier
Ordre["icon_toggle"] = {} -- checkbox activation icone
--------------------------------------------------------------------

local Profile_SF_frame,Profile_SF_text = {},{}
local profile_list = {}
local sf,ccf,sftooltipanchor,sfborder

local TOOLTIPBUFF = CreateFrame("GameTooltip","Sh_tooltipbuff",UIParent,"GameTooltipTemplate" )
TOOLTIPBUFF:SetOwner(UIParent,"ANCHOR_NONE")

-- Options
local Slider,Slidermoins,Sliderplus = {},{},{}
local Sh_DDM = {}
local Sh_DDM_frame,Sh_DDM_items = {},{}
Sh_DDM_items["player"],Sh_DDM_items["target"] = {},{}

local Cb = {}
local Btn = {}
local Cp = {}
local I1_tex,I2_tex
local Color_fontval_tex = {}
local B_verr
local Panel,Lockframe = {},{}
--

local Blinkbool = false

local totalmax,total
local slot = {}
for j=1,25 do
	slot[j] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	slot[j][30] = ""
	slot[j][31] = 0
end
-- slot[30] = test
-- slot[s][30] = nom
-- slot[s][31] = temps

------------------------------------------ Localisation
------------------------------------------------------------------------------------


local L = sh_Local
------------------------------------------------------------------------------------
local cooldownTIME = 0


------------------------------------------ Tables
------------------------------------------------------------------------------------

------------------------------------------ Icons
local Btex = {}
local Bid = {}

----DK
-- Anti-Magic Shell
Bid[1]  = 48707
Btex[1] = "spell_shadow_antimagicshell"
-- Blood Shield
Bid[2]  = 77535
Btex[2] = "spell_deathknight_butcher2"

---- MAGE
-- Barrière de glace
Bid[3]  = 11426
Btex[3] = "spell_ice_lament"
-- Incanter's Ward
Bid[4]  = 1463
Btex[4] = "spell_shadow_detectlesserinvisibility"

---- DEMONISTE
--Sacrificial Pact
Bid[5]  = 108416
Btex[5] = "warlock_sacrificial_pact"

----SHAMAN
-- Stone Bulwark
Bid[6]  = 114893
Btex[6] = "ability_shaman_stonebulwark"

----WAR
-- Shield Barrier
Bid[7]  = 112048
Btex[7] = "inv_shield_07"

----MOINE
-- Guard
Bid[8]  = 115295
Btex[8] = "ability_monk_guard"

---- PRETRE
-- Mot de pouvoir bouclier
Bid[9]  = 17
Btex[9] = "Spell_holy_PowerWordShield"
-- Spirit Shell
Bid[10]  = 114908
Btex[10] = "ability_shaman_astralshift"
-- Divine Aegis
Bid[11]  = 47753
Btex[11] = "spell_holy_devineaegis"
-- Clarity of Will
Bid[12]  = 152118
Btex[12] = "ability_priest_clarityofwill"

---- PALADIN
-- Illuminated Healing
Bid[13]  = 86273
Btex[13] = "spell_holy_absolution"
-- Sacred Shield
Bid[14]  = 65148
Btex[14] = "ability_paladin_blessedmending"

---- DEMONISTE
-- Twilight Ward
Bid[15]  = 159693
Btex[15] = "spell_fire_twilightfireward"



for i=1,getn(Btex) do Btex[i] =  "Interface\\Icons\\" .. Btex[i] end

local B = {}
for i=1,getn(Bid) do
	B[i] = GetSpellInfo(Bid[i])
end


------------------------------------------------------------------------------------






------------------------------------------ Fonctions
------------------------------------------------------------------------------------




------------------------------------------
function Sh_timer(self,elapsed)
   -- Fonction indépendante - met à jour le temps restant des boucliers
   ------------------------------------------
	timer = timer + elapsed
	local temps = math.floor(timer * 10)

		if temp ~= temps then
		temp = temps
			if temps == 4 or temps == 8 then
				if CLASS == "PRIEST" and Oo["cooldown"]["modules"]["rapture"] then
					if cooldownTIME - GetTime() < 0 and not(TESTMODE) then
						cooldownFRAME:Hide()
					end
				end
			end
			
		end

	if timer > 1 then
		timer = 0.1
		Sh_OnEvent("player")
		Sh_OnEvent("target")
	end

end  
    

function Sh_timer2(self,elapsed)
	timer2 = timer2 + elapsed
	if (Blinkbool and O["blink"]) or (Blinkbooltar and Ot["blink"]) then
		if (timer2 >= 0.22 and timer2 <= 0.27) or (timer2 >= 0.72 and timer2 <= 0.77) then
			if Blinkbool and O["blink"] then blink:SetBackdropColor(1,0,0,0.5) end
			if Blinkbooltar and Ot["blink"] then blinktar:SetBackdropColor(1,0,0,0.5) end
		elseif (timer2 >= 0.48 and timer2 <= 0.52) or (timer2 >= 1) then 
			if Blinkbool and O["blink"] then blink:SetBackdropColor(1,0,0,0) end
			if Blinkbooltar and Ot["blink"] then blinktar:SetBackdropColor(1,0,0,0) end
		end
	end
	if not(Blinkbool and O["blink"]) then blink:SetBackdropColor(1,0,0,0) end
	if not(Blinkbooltar and Ot["blink"]) then blinktar:SetBackdropColor(1,0,0,0) end
	
	if timer2 >= 1 then
		timer2 = 0
	end
end

------------------------------------------
function Sh_OnEvent(unit)
   -- Appelé sur un UNIT_AURA
   ------------------------------------------
	if not(TESTMODE) then

	
		
		
		
		if unit == "player" then
			if (not(O["show_only_in_combat"]) or (O["show_only_in_combat"] and COMBAT)) and O["enable"] then
				f:Show()
				
				Sh_check_buff(unit)
				
			else
				f:Hide()
			end
		------------------------------------------



		elseif unit == "target" then
			if (not(Ot["show_only_in_combat"]) or (Ot["show_only_in_combat"] and COMBAT)) and Ot["enable"] then
				ftar:Show()
				
				
				local s = Sh_tar_slot(UnitName(unit))
				Sh_check_buff(unit,s)
				
				
			else
				ftar:Hide()
			end
		end
	end
end


   
 

------------------------------------------
function Sh_check_buff(unit,s)
	-- Test si le buff est présent sur unit
	------------------------------------------
	

	
	local isPresent = {}
	for i=1,getnB do
		table.insert(isPresent,false)
	end
	
	
	for j=1,40 do
		local nom,_,_,_,_,duration,expirationTime,_,_,_,spellID,_,_,_,value1,value2,value3 = UnitBuff(unit,j)
		if nom ~= nil then
			for i=1,getnB do
				if spellID == Bid[i] then
					isPresent[i] = true
					
					if unit == "player" then
						Bt[i] = expirationTime - GetTime()
						Bmt[i] = duration
						
						-- ANCIENNE METHODE
						-- Bv[i] = Sh_val(unit,i)
						-- NOUVELLE METHODE
						Bv[i] = value1
						
						if Bv[i] >= Bmv[i] then
							Bmv[i] = Bv[i]
						end
						
						
					elseif unit == "target" then
						Sh_newShieldtar(i,s,true,value1,expirationTime - GetTime(),duration)
					end
					
					break
				end
			end
		end
	end
	
	
	for i=1,getnB do
		if not(isPresent[i]) then
			if unit == "player" then
				Bv[i] = 0
				Bmv[i] = 0
			elseif unit == "target" then
				Sh_newShieldtar(i,s,false,0,0,0)
			end
		end
		
		if not(Oo["Ord:toggle"][i]) then
			if unit == "player" then
				Bv[i]=0
				Bmv[i]=0
			elseif unit == "target" then
				Sh_newShieldtar(i,s,false,0,0,0)
			end
		end
	end
	
	
	
	if unit == "player" then
		Sh_update(unit)
		
	elseif unit == "target" then
		total,totalmax = 0,0
		local _,classtar = UnitClass("target")
		
		for i=1,getnB do
			totalmax = totalmax + slot[s][i]
			total = total + Bvtar[i]
		end
		
		if total ~= 0 then
			slot[s][30] = UnitName(unit)
			slot[s][31] = GetTime()
		end
		
		Sh_tar_update(total,totalmax,s)
	end
	
end


------------------------------------------
function Sh_val(unit,i)
   -- Lis la valeur du bouclier dans le tooltip
   ------------------------------------------
	TOOLTIPBUFF:ClearLines()
	TOOLTIPBUFF:SetUnitBuff(unit,B[i])

	local val = Sh_tooltipbuffTextLeft2:GetText()
	if val ~= nil then
		val = string.match(val,"%d+")
	else
		val = 0
	end
	Sh_debug(B[i])
	Sh_debug(val)
	return tonumber(val)
end






------------------------------------------   
function Sh_newShieldtar(i,s,isPresent,value,t,mt)
	-- 
	------------------------------------------   
	
	
	if isPresent == false then
		Bvtar[i] = 0
		Bttar[i],Bmttar[i] = 0,0 
	else
		Bttar[i] = t
		Bmttar[i] = mt
		---- ANCIENNE METHODE
		-- Bvtar[i] = Sh_val(unit,i)
		---- NOUVELLE METHODE
		Bvtar[i] = value
	end
	-- temps,tempsmax,Val
	if slot[s][i] == nil then
		slot[s][i] = 0
	end
	if Bvtar[i] == nil then
		Bvtar[i] = 0
	end
	if Bvtar[i] == 0 then
		slot[s][i] = 0
	elseif slot[s][i] < Bvtar[i] then
		slot[s][i] = Bvtar[i]
	end
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



------------------------------------------   
function Sh_tar_slot(name)
	-- Selectionne un slot libre ou celui déjà existant de la cible
	------------------------------------------
	if name ~= nil then
		for j=1,25 do
			if slot[j][30] == name then
				return j
			end
		end
	end
	
	for j=1,25 do
		if slot[j] == nil then
			return j
		end
	end

	for j=1,25 do
		if (GetTime()) - slot[j][31] > 60 then
		return j
		end
	end
	return 1
	

end



   

   
   
function Sh_tar_update(total,totalmax,s)
   -- met à jour la barre de la cible
   ------------------------------------------

   ---------------------------
   -- Si il n'y a aucun bouclier
	if totalmax <= 1 then
		Blinkbooltar = false
		blinktar:SetBackdropColor(1,0,0,0)
		ftar:Hide()
		ft1tar:SetText("")
		---------------------------
		---------------------------
		-- Si il y a des boucliers
	else


	ft1tar:SetText(Sh_format(total,Ot["short"]))

		

		-- Blink ------
		if (total / totalmax) <= 0.20 then
			Blinkbooltar = true
		else
			Blinkbooltar = false
			blinktar:SetBackdropColor(1,0,0,0)
		end

		--------------- 


		ftar:Show()
		i1tar:Hide()
		i2tar:Hide()
		  
		local x1,x2,x3,x4,x5 = 0,0,true,true,1
		
		for i,j in pairs(Oo["Ord"]) do
			if Bvtar[j] >= 1 and Oo["Ord:icon"][j] then
				if x3 then
					I1_textar:SetTexture(Btex[j])
					i1tar:Show()
					i1CDtar:SetCooldown(GetTime() - (Bmttar[j] - Bttar[j]), Bmttar[j])
					x3 = false
				elseif x4 then
					I2_textar:SetTexture(Btex[j])
					i2tar:Show()
					i2CDtar:SetCooldown(GetTime() - (Bmttar[j] - Bttar[j]), Bmttar[j])
					x4 = false
				end
				x5 = x5 + 1
			end   
		end  
		
		x5 = fbtar:GetFrameLevel() + x5
		for i,j in pairs(Oo["Ord"]) do
			if Bvtar[j] >= 1 then
				x2 = Bvtar[j]/totalmax
				x1 = x1 + x2
				if Ot["iconsize"] then
					if not(x4) then 
						fbtar:SetPoint("LEFT",i2tar,"RIGHT")
					elseif not(x3) then
						fbtar:SetPoint("LEFT",i1tar,"RIGHT")
					else
						fbtar:SetPoint("LEFT",ftar,"LEFT")
					end
				else
					if not(x4) then 
						fbtar:SetPoint("LEFT",ftar,"LEFT",i1tar:GetHeight() + i2tar:GetHeight(),0)
					elseif not(x3) then
						fbtar:SetPoint("LEFT",ftar,"LEFT",i1tar:GetHeight(),0)
					else
						fbtar:SetPoint("LEFT",ftar,"LEFT")
					end
				end
				Bftar[j]:Show()
				Bftar[j]:SetValue(x1)
				Bftar[j]:SetFrameLevel(x5)
				x5 = x5 - 1
				
			else
				Bftar[j]:SetValue(0)
				Bftar[j]:Hide()
				Bftar[j]:SetFrameLevel(fbtar:GetFrameLevel() + 1)
			end
			x2 = 0
		end
	end
   
end  
   
   
   
   


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------  
------------------------------------------   




------------------------------------------
function Sh_update()
   -- met à jour la barre
   ------------------------------------------
   local unit = "player"
   
   ---------------------------
   local uBmv,uBv = 0,0
   for k,v in pairs(Bmv) do
      uBmv = uBmv + v
   end
   for k,v in pairs(Bv) do
      uBv = uBv + v
   end
   ---------------------------
   
   ---------------------------
   -- Si il n'y a aucun bouclier
	if uBmv < 1 or uBmv == nil then
		Blinkbool = false
		f:Hide()
		ft1:SetText("")
      ---------------------------
      ---------------------------
      -- Si il y a des boucliers
	else
     
	ft1:SetText(Sh_format(uBv,O["short"]))
		
		
		
		
      
      -- Blink ------
		if (uBv / uBmv) <= 0.20 then
			Blinkbool = true
		else
			Blinkbool = false
			blink:SetBackdropColor(1,0,0,0)
		end
	  
	  --------------- 
	  

		i1:Hide()
		i2:Hide()
		icon1,icon2 = 0,0

		local x1,x2,x3,x4,x5 = 0,0,true,true,1
      
		for i,j in pairs(Oo["Ord"]) do
         	if Bv[j] >= 1 and Oo["Ord:icon"][j] then
				if x3 then
					I1_tex:SetTexture(Btex[j])
					i1:Show()
					i1CD:SetCooldown(GetTime()-(Bmt[j]-Bt[j]), Bmt[j])
					x3 = false
				elseif x4 then
					I2_tex:SetTexture(Btex[j])
					i2:Show()
					i2CD:SetCooldown(GetTime()-(Bmt[j]-Bt[j]), Bmt[j])
					x4 = false
				end
				x5 = x5 + 1
		    end   
		end  
		
		x1 = 0
		x5 = fb:GetFrameLevel() + x5
		for i,j in pairs(Oo["Ord"]) do
			if Bv[j] >= 1 then
				x2=Bv[j]/uBmv
				x1 = x1 + x2
				if O["iconsize"] then
					if not(x4) then 
						fb:SetPoint("LEFT",i2,"RIGHT")
					elseif not(x3) then
						fb:SetPoint("LEFT",i1,"RIGHT")
					else
						fb:SetPoint("LEFT",f,"LEFT")
					end
				else
					if not(x4) then 
						fb:SetPoint("LEFT",f,"LEFT",i1:GetHeight() + i2:GetHeight(),0)
					elseif not(x3) then
						fb:SetPoint("LEFT",f,"LEFT",i1:GetHeight(),0)
					else
						fb:SetPoint("LEFT",f,"LEFT")
					end
				end
				Bf[j]:Show()
				Bf[j]:SetValue(x1)
				Bf[j]:SetFrameLevel(x5)
				x5 = x5 - 1
			else
				Bf[j]:SetValue(0) Bf[j]:Hide()
				Bf[j]:SetFrameLevel(fb:GetFrameLevel() + 1)
			end
			x2 = 0
		end
   end
end


--[[function Sh_othershield()
   	local val,index = Sh_othershield_check("player")
	if index then
		Bt[10] = select(7,UnitBuff("player",index)) - GetTime()
		Bmt[10] = select(6,UnitBuff("player",index))
		Btex[10] = select(3,UnitBuff("player",index))
		Bv[10] = val
		if Bv[10] >= Bmv[10] then
			Bmv[10] = Bv[10]
		end
	else
		Bt[10] = 0
		Bmt[10] = 0
		Bv[10] = 0
		Bmv[10] = 0
		Btex[10] = "Interface\\Icons\\inv_misc_questionmark"
	end
	
	Sh_update("player",B[10],10)
end

function Sh_othershieldtar(s)
	local val,index = Sh_othershield_check("target")
	if index then
		print(UnitBuff("target",index))
		Bvtar[10] = val
		Bttar[10] = select(7,UnitBuff("target",index)) - GetTime()
		Bmttar[10] = select(6,UnitBuff("target",index))
		Btex[10] = select(3,UnitBuff("target",index))
		if Bvtar[10] >= Bmvtar[10] then
			Bmvtar[10] = Bvtar[10]
		end
		slot[s][10] = Bmvtar[10]
	else
		slot[s][10] = 0
		Bttar[10] = 0
		Bmttar[10] = 0
		Bvtar[10] = 0
		Bmvtar[10] = 0
		Btex[10] = "Interface\\Icons\\inv_misc_questionmark"
	end
	local valtot,maxtot = 0,0
	for j=1,10 do
		maxtot = maxtot + slot[s][j]
		valtot = valtot + Bvtar[j]
	end
	Sh_tar_update(Bvtar,valtot,maxtot,Bttar,Bmttar,s)
end

function Sh_othershield_check(unit)
	local shieldval = 0
	local shieldbuff = false
	for i=1,100 do
		local buff = UnitBuff(unit,i)
		if buff == nil then
			break
		else
			local bool = true
			for k,v in pairs(B) do
				if select(1,buff) == v then
					bool = false
				end
			end
			
			if bool then
				TOOLTIPBUFF:SetUnitBuff(unit,i)
				local text = Sh_tooltipbuffTextLeft2:GetText()
				if text ~= nil then
					if string.match(text,"Absorbe %d+ points de dégâts") then
						shieldval = shieldval + tonumber(string.match(text,"%d+"))
						shieldbuff = i
					end
				end
			end
		end
	end
	return shieldval,shieldbuff
end
--]]
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------








function Sh_format(val,short)
	if type(val) == "number" then
		local x5 = math.floor(val / 1000)
		local x6 = math.floor(val - (1000 * x5))
		if not(short) then
			if x5 == 0 then
				return x6
			elseif x6 >= 100 then
				return x5 .. " " .. x6
			elseif x6 >= 10 then 
				return x5 .. " 0" .. x6
			else
				return x5 .. " 00" .. x6
			end
		else
			if x5 ~= 0 then
				return x5 .. "k"
			else
				return x6
			end
		end
	else
		Sh_error("Sh_format - " .. tostring(val) .. " is not a number")
		return 0
	end
end

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------ Fonctions Frames
------------------------------------------------------------------------------------


------------------------------------------
function Sh_createBar()
   -- Crée les frames nécessaires à l'affichage de l'addon
   -----------------------------------------
   -- Conteneur
	bg = CreateFrame("Frame","Sh_bg_container",UIParent)
	bg:SetFrameStrata("MEDIUM")
	bg:SetFrameLevel(O["level"])
	bg:Show()
	
	
	blink = CreateFrame("Frame","Sh_blink_blink",bg)
	blink:SetFrameStrata("MEDIUM")
	blink:SetAllPoints(bg)
	blink:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background" })
	blink:SetFrameLevel(O["level"] + 10)
   
   
   
   -- Frame du fond
	f = CreateFrame("Frame","Sh_f_fond",bg)
	f:SetPoint("TOPLEFT",bg,"TOPLEFT",O["insets:left"],-O["insets:top"])
	f:SetPoint("BOTTOMRIGHT",bg,"BOTTOMRIGHT",-O["insets:right"],O["insets:bottom"])
	
	fbck = CreateFrame("Frame","Sh_fbck_backdrop",f)
	fbck:SetBackdrop(
		{
			bgFile = O["f:tex:fond"], 
			edgeFile = O["f:tex:border"],
			edgeSize = O["border:size"],
			insets = {
				left = O["insets:left"],
				right = O["insets:right"],
				top = O["insets:top"],
				bottom = O["insets:bottom"],
			},
		}
	)
	fbck:SetBackdropColor(O["f:SBC:r"],O["f:SBC:v"],O["f:SBC:b"],O["f:SBC:a"])
	fbck:SetPoint("TOPLEFT",bg,"TOPLEFT")
	fbck:SetPoint("BOTTOMRIGHT",bg,"BOTTOMRIGHT")

   -----------------------------------------
   -- Cooldown
   	cooldownFRAME = CreateFrame("frame","Sh_cooldownFRAME_cooldownIcon",UIParent)
	cooldownFRAME:ClearAllPoints()
	cooldownTEX = cooldownFRAME:CreateTexture(nil,"BACKGROUND")
	cooldownTEX:SetAllPoints(cooldownFRAME)
	cooldownTEX:SetTexture("Interface\\Icons\\trade_engineering")
	cooldownCD = CreateFrame("Cooldown","cooldownFRAMECD",cooldownFRAME)
	cooldownFRAME:Hide()
	
   -----------------------------------------
   -- Frame des icones
	i1 = CreateFrame("frame","Sh_i1_icon1",f)
	i1:SetFrameLevel(fbck:GetFrameLevel()+1)
	I1_tex = i1:CreateTexture(nil,"BACKGROUND")
	I1_tex:SetAllPoints(i1)
	I1_tex:SetTexture("Interface\\Icons\\trade_engineering")
	i1CD = CreateFrame("Cooldown","i1CD",i1)
	i1CD:SetAllPoints(i1)   
   
   
	i2 = CreateFrame("frame","Sh_i2_icon2",f)
	i2:SetFrameLevel(fbck:GetFrameLevel()+1)
	I2_tex = i2:CreateTexture(nil,"BACKGROUND")
	I2_tex:SetAllPoints(i2)
	I2_tex:SetTexture("Interface\\Icons\\trade_engineering")
	i2CD = CreateFrame("Cooldown","i2CD",i2)
	i2CD:SetAllPoints(i2)
   
	
	----------------------------------  
	-- Frame du fond des barres
	fb = CreateFrame("frame","Sh_fb_fondBarres",f)
	fb:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT")
	fb:Show()

	fb2 = CreateFrame("frame","Sh_fb2_fondBarreLevel+15",fb)
	fb2:SetPoint("TOPLEFT",fb,"TOPLEFT")
	fb2:SetPoint("BOTTOMRIGHT",fb,"BOTTOMRIGHT")
	fb2:Show()
	fb2:SetFrameLevel(O["level"] + 15)
   
   -----------------------------------------  
   -- Frame de la barre de vie du bouclier
   
   for j=1,getnB do
       	Bf[j] = CreateFrame("statusbar","Sh_Bf[" .. j .. "]_Barre",fb)
		Bf[j]:SetPoint("TOPLEFT",fb,"TOPLEFT")
		Bf[j]:SetPoint("BOTTOMRIGHT",fb,"BOTTOMRIGHT")
		Bf[j]:SetStatusBarTexture(O["tex_barre"])
		Bf[j]:SetStatusBarColor(O[j .. ":r"],O[j .. ":v"],O[j .. ":b"])
		Bf[j]:SetMinMaxValues(0,1)
		Bf[j]:Show()
      
   end
   
	local outline
	-- Texte de la valeur et du pourcentage du bouclier
	ft1 = fb2:CreateFontString("Sh_ft1_texteVal","MEDIUM")
	if O["contour"] then outline = "OUTLINE" else outline = nil end
	ft1:SetFont(O["font:val"],O["font:val:size"],outline)
	ft1:SetText("")
	ft1:SetTextColor(O["font:val:r"],O["font:val:v"],O["font:val:b"],O["font:val:a"])
	ft1:SetPoint("CENTER",fb,"CENTER")
	ft1:Show()

   
   
   
   
   
   
   ----------------------------------------------------------------------------------------
   
      -- Crée les frames nécessaires à l'affichage de l'addon
   -----------------------------------------
   -- Conteneur
	bgtar = CreateFrame("Frame","Sh_bgtar_container",UIParent)
	bgtar:SetFrameStrata("MEDIUM")
	bgtar:SetFrameLevel(Ot["level"])
	bgtar:Show()
   
	blinktar = CreateFrame("Frame","Sh_blinktar_blink",bgtar)
	blinktar:SetFrameStrata("MEDIUM")
	blinktar:SetAllPoints(bgtar)
	blinktar:SetBackdrop({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background"})
	blinktar:SetBackdropColor(1,0,0,0)
	blinktar:SetFrameLevel(Ot["level"] + 10)
   
   
   
   -- Frame du fond
	ftar = CreateFrame("Frame","Sh_ftar_fond",bgtar)
	ftar:SetPoint("TOPLEFT",bgtar,"TOPLEFT",Ot["insets:left"],-Ot["insets:top"])
	ftar:SetPoint("BOTTOMRIGHT",bgtar,"BOTTOMRIGHT",-Ot["insets:right"],Ot["insets:bottom"])

	fbcktar =  CreateFrame("Frame","Sh_fbcktar_backdrop",ftar)
	fbcktar:SetBackdrop(
		{
			bgFile = Ot["f:tex:fond"], 
			edgeFile = Ot["f:tex:border"],
			edgeSize = Ot["border:size"],
			insets = {
				left = Ot["insets:left"],
				right = Ot["insets:right"],
				top = Ot["insets:top"],
				bottom = Ot["insets:bottom"],
			},
		}
	)
	fbcktar:SetBackdropColor(Ot["f:SBC:r"],Ot["f:SBC:v"],Ot["f:SBC:b"],Ot["f:SBC:a"])
	fbcktar:SetPoint("TOPLEFT",bgtar,"TOPLEFT")
	fbcktar:SetPoint("BOTTOMRIGHT",bgtar,"BOTTOMRIGHT")
   -----------------------------------------
   -- Frame des icones
	i1tar = CreateFrame("frame","Sh_i1tar_icon1",ftar)
	i1tar:SetFrameLevel(fbcktar:GetFrameLevel()+1)
	I1_textar = i1tar:CreateTexture(nil,"BACKGROUND")
	I1_textar:SetAllPoints(i1tar)
	I1_textar:SetTexture("Interface\\Icons\\trade_engineering")
	i1CDtar = CreateFrame("Cooldown","i1CDtar",i1tar)
	i1CDtar:SetAllPoints(i1tar)   
   
   
	i2tar = CreateFrame("frame","Sh_i1tar_icon2",ftar)
	i2tar:SetFrameLevel(fbcktar:GetFrameLevel()+1)
	I2_textar = i2tar:CreateTexture(nil,"BACKGROUND")
	I2_textar:SetAllPoints(i2tar)
	I2_textar:SetTexture("Interface\\Icons\\trade_engineering")
	i2CDtar = CreateFrame("Cooldown","i2CDtar",i2tar)
	i2CDtar:SetAllPoints(i2tar)
   ----------------------------------  
   -- Frame du fond des barres
   fbtar = CreateFrame("frame","Sh_fbtar_fondBarres",ftar)
   fbtar:SetFrameStrata("MEDIUM")
   fbtar:SetPoint("BOTTOMRIGHT",ftar,"BOTTOMRIGHT")
   fbtar:Show()
   
   fb2tar = CreateFrame("frame","Sh_fb2tar_fondBarreLevel+15",ftar)
   fb2tar:SetFrameStrata("MEDIUM")
   fb2tar:SetPoint("TOPLEFT",fbtar,"TOPLEFT")
   fb2tar:SetPoint("BOTTOMRIGHT",fbtar,"BOTTOMRIGHT")
   fb2tar:Show()
   fb2tar:SetFrameLevel(Ot["level"] + 15)
   
   -----------------------------------------  
   -- Frame de la barre de vie du bouclier
   
   for j=1,getnB do
       	Bftar[j] = CreateFrame("statusbar","Sh_Bftar[" .. j .. "]_Barre",fbtar)
		Bftar[j]:SetPoint("TOPLEFT",fbtar,"TOPLEFT")
		Bftar[j]:SetPoint("BOTTOMRIGHT",fbtar,"BOTTOMRIGHT")
		Bftar[j]:SetStatusBarTexture(Ot["tex_barre"])
		Bftar[j]:SetStatusBarColor(Ot[j .. ":r"],Ot[j .. ":v"],Ot[j .. ":b"])
		Bftar[j]:SetMinMaxValues(0,1)
		Bftar[j]:Show()
		
   end
   
   
	-- Texte de la valeur et du pourcentage du bouclier
	ft1tar = fb2tar:CreateFontString("Sh_ft1tar_texteVal","MEDIUM")
	if Ot["contour"] then outline = "OUTLINE" else outline = nil end
	ft1tar:SetFont(Ot["font:val"], Ot["font:val:size"], outline)
	ft1tar:SetText("")
	ft1tar:SetTextColor(Ot["font:val:r"],Ot["font:val:v"],Ot["font:val:b"],Ot["font:val:a"])
	ft1tar:SetPoint("CENTER",fb2tar,"CENTER")
	ft1tar:Show()


	
end





function Sh_refresh()
	
	bg:SetParent(UIParent)
	bg:ClearAllPoints()
	bg:SetPoint(O["f:pos:1"],O["f:pos:2"],O["f:pos:3"],O["f:pos:4"],O["f:pos:5"])
	bg:SetWidth(O["f:largeur"])
	bg:SetHeight(O["f:hauteur"])
	bg:SetFrameLevel(O["level"])
	
	fbck:SetBackdrop(
		{
			bgFile = O["f:tex:fond"], 
			edgeFile = O["f:tex:border"],
			edgeSize = O["border:size"],
			insets = {
				left = O["insets:left"],
				right = O["insets:right"],
				top = O["insets:top"],
				bottom = O["insets:bottom"],
			},
		}
	)
	fbck:SetBackdropColor(O["f:SBC:r"],O["f:SBC:v"],O["f:SBC:b"],O["f:SBC:a"])
	
	
	f:SetPoint("TOPLEFT",bg,"TOPLEFT",O["insets:left"],-O["insets:top"])
	f:SetPoint("BOTTOMRIGHT",bg,"BOTTOMRIGHT",-O["insets:right"],O["insets:bottom"])
	
	
	i1:ClearAllPoints()
	i2:ClearAllPoints()
	if not(O["autoicon"]) then
		i1:SetHeight(O["iconsize"])
		i2:SetHeight(O["iconsize"])
		i1:SetPoint("RIGHT",f,"LEFT",i1:GetHeight(),0)
		i2:SetPoint("RIGHT",i1,"RIGHT",i2:GetHeight(),0)
	else
		i1:SetHeight(0)
		i2:SetHeight(0)
		
		i1:SetPoint("TOPLEFT",f,"TOPLEFT")
		i2:SetPoint("TOPLEFT",i1,"TOPRIGHT")
		i1:SetPoint("RIGHT",f,"LEFT",f:GetHeight(),0)
		i2:SetPoint("RIGHT",i1,"RIGHT",f:GetHeight(),0)
	end
	i1:SetPoint("LEFT",f,"LEFT")
	i2:SetPoint("LEFT",i1,"RIGHT")
	
	
	local outline
	ft1:SetTextColor(O["font:val:r"],O["font:val:v"],O["font:val:b"],O["font:val:a"])
	if O["contour"] then outline = "OUTLINE" else outline = nil end
	ft1:SetFont(O["font:val"], O["font:val:size"],outline)


   
   
   
	--------------------------------------------------------------------------------
	
	bgtar:SetParent(UIParent)
	bgtar:ClearAllPoints()
	bgtar:SetPoint(Ot["f:pos:1"],Ot["f:pos:2"],Ot["f:pos:3"],Ot["f:pos:4"],Ot["f:pos:5"])
	bgtar:SetWidth(Ot["f:largeur"])
	bgtar:SetHeight(Ot["f:hauteur"])
	bgtar:SetFrameLevel(Ot["level"])
	
	fbcktar:SetBackdrop(
		{
			bgFile = Ot["f:tex:fond"], 
			edgeFile = Ot["f:tex:border"],
			edgeSize = Ot["border:size"],
			insets = {
				left = Ot["insets:left"],
				right = Ot["insets:right"],
				top = Ot["insets:top"],
				bottom = Ot["insets:bottom"],
			},
		}
	)
	fbcktar:SetBackdropColor(Ot["f:SBC:r"],Ot["f:SBC:v"],Ot["f:SBC:b"],Ot["f:SBC:a"])
	
	ftar:SetBackdropColor(Ot["f:SBC:r"],Ot["f:SBC:v"],Ot["f:SBC:b"],Ot["f:SBC:a"])
	ftar:SetPoint("TOPLEFT",bgtar,"TOPLEFT",Ot["insets:left"],-Ot["insets:top"])
	ftar:SetPoint("BOTTOMRIGHT",bgtar,"BOTTOMRIGHT",-Ot["insets:right"],Ot["insets:bottom"])
	
	i1tar:ClearAllPoints()
	i2tar:ClearAllPoints()
	if not(Ot["autoicon"]) then
		i1tar:SetHeight(Ot["iconsize"])
		i2tar:SetHeight(Ot["iconsize"])
		
		i1tar:SetPoint("RIGHT",ftar,"LEFT",i1tar:GetHeight(),0)
		i2tar:SetPoint("RIGHT",i1tar,"RIGHT",i2tar:GetHeight(),0)
	else
		i1tar:SetHeight(0)
		i2tar:SetHeight(0)
		
		i1tar:SetPoint("TOPLEFT",ftar,"TOPLEFT")
		i2tar:SetPoint("TOPLEFT",i1tar,"TOPRIGHT")
		i1tar:SetPoint("RIGHT",ftar,"LEFT",f:GetHeight(),0)
		i2tar:SetPoint("RIGHT",i1tar,"RIGHT",f:GetHeight(),0)
	end
	i1tar:SetPoint("LEFT",ftar,"LEFT")
	i2tar:SetPoint("LEFT",i1tar,"RIGHT")
	
	
	ft1tar:SetTextColor(Ot["font:val:r"],Ot["font:val:v"],Ot["font:val:b"],Ot["font:val:a"])
	if Ot["contour"] then outline = "OUTLINE" else outline = nil end
	ft1tar:SetFont(Ot["font:val"], Ot["font:val:size"], outline)

	for j=1,getnB do
		Bf[j]:SetStatusBarTexture(O["tex_barre"])
		Bf[j]:SetStatusBarColor(O[j .. ":r"],O[j .. ":v"],O[j .. ":b"],(O["b:a"]/100))
		
		Bftar[j]:SetStatusBarTexture(Ot["tex_barre"])
		Bftar[j]:SetStatusBarColor(Ot[j .. ":r"],Ot[j .. ":v"],Ot[j .. ":b"],(Ot["b:a"]/100))
		
		
		color_tex[j]:SetTexture(O["tex_barre"])
		color_tex[j+20]:SetTexture(Ot["tex_barre"])
		
		if O["contour"] then outline = "OUTLINE" else outline = nil end
		color_text[j]:SetFont(O["font:val"],12,outline)
		color_text[j]:SetTextColor(O["font:val:r"],O["font:val:v"],O["font:val:b"],O["font:val:a"])
		
		if Ot["contour"] then outline = "OUTLINE" else outline = nil end
		color_text[j+20]:SetFont(Ot["font:val"],12,outline)
		color_text[j+20]:SetTextColor(Ot["font:val:r"],Ot["font:val:v"],Ot["font:val:b"],Ot["font:val:a"])
	end
	
	
	cooldownFRAME:ClearAllPoints()
	if not(Oo["cooldown"]["anchored"]) then
		cooldownFRAME:SetPoint(Oo["cooldown"]["pos:1"],Oo["cooldown"]["pos:2"],Oo["cooldown"]["pos:3"],Oo["cooldown"]["pos:4"],Oo["cooldown"]["pos:5"])
	else
		cooldownFRAME:SetPoint("CENTER",bg,"LEFT",Oo["cooldown"]["anchor"],0)
	end
	if Oo["cooldown"]["border"] then
		cooldownFRAME:SetBackdrop(
			{
				edgeFile = Oo["cooldown"]["tex:border"],
				edgeSize = Oo["cooldown"]["border:width"],
			}
		)
	else
		cooldownFRAME:SetBackdrop(
			{
				edgeFile = nil,
			}
		)
	end
	
	if CLASS == "PRIEST" then
		Oo["cooldown"]["tex"] = Oo["cooldown"]["tex:rapture"]
	elseif CLASS == "PALADIN" then
		Oo["cooldown"]["tex"] = Oo["cooldown"]["tex:holy"]
	end
	cooldownTEX:SetTexture(Oo["cooldown"]["tex"])
	cooldownFRAME:SetWidth(Oo["cooldown"]["largeur"])
	cooldownFRAME:SetHeight(Oo["cooldown"]["hauteur"])
	
	cooldownCD:SetPoint("TOPLEFT",cooldownFRAME,"TOPLEFT",Oo["cooldown"]["inset"],-Oo["cooldown"]["inset"])
	cooldownCD:SetPoint("BOTTOMRIGHT",cooldownFRAME,"BOTTOMRIGHT",-Oo["cooldown"]["inset"],Oo["cooldown"]["inset"])
	
	-------- Refresh ColorPicker
		
	Color_fontval_tex[1]:SetVertexColor(O["font:val:r"],O["font:val:v"],O["font:val:b"],O["font:val:a"])
	
	Color_fontval_tex[2]:SetTexture(O["f:tex:fond"])
	Color_fontval_tex[2]:SetVertexColor(O["f:SBC:r"],O["f:SBC:v"],O["f:SBC:b"],O["f:SBC:a"])
			
			
	Color_fontval_tex[21]:SetVertexColor(Ot["font:val:r"],Ot["font:val:v"],Ot["font:val:b"],Ot["font:val:a"])
	
	Color_fontval_tex[22]:SetTexture(Ot["f:tex:fond"])
	Color_fontval_tex[22]:SetVertexColor(Ot["f:SBC:r"],Ot["f:SBC:v"],Ot["f:SBC:b"],Ot["f:SBC:a"])
	
	
 
	
	
	

   	Sh_test()
	Sh_OnEvent("player")
	Sh_OnEvent("target")
end



function Sh_refresh_options()
--------- Refresh des options
	local function slider_refresh(nb,var)
	var = math.ceil(var)
	Slider[nb]:SetValue(var)
	getglobal(Slider[nb]:GetName() .. 'Text'):SetText(var)
	end
	slider_refresh(1,O["b:a"])
	slider_refresh(2,O["font:val:size"])
	slider_refresh(3,O["f:largeur"])
	slider_refresh(4,O["f:hauteur"])
	slider_refresh(5,O["border:size"])
	slider_refresh(6,O["iconsize"])
	slider_refresh(7,O["level"])
	
	slider_refresh(21,Ot["b:a"])
	slider_refresh(22,Ot["font:val:size"])
	slider_refresh(23,Ot["f:largeur"])
	slider_refresh(24,Ot["f:hauteur"])
	slider_refresh(25,Ot["border:size"])
	slider_refresh(26,Ot["iconsize"])
	slider_refresh(27,Ot["level"])

	
	slider_refresh(10,O["insets:left"])
	slider_refresh(11,O["insets:right"])
	slider_refresh(12,O["insets:top"])
	slider_refresh(13,O["insets:bottom"])
	
	slider_refresh(30,Ot["insets:left"])
	slider_refresh(31,Ot["insets:right"])
	slider_refresh(32,Ot["insets:top"])
	slider_refresh(33,Ot["insets:bottom"])
	
	slider_refresh(60,Oo["cooldown"]["hauteur"])
	slider_refresh(61,Oo["cooldown"]["largeur"])
	slider_refresh(62,Oo["cooldown"]["border:width"])
	slider_refresh(63,Oo["cooldown"]["inset"])
	
	
	
	-- Checkbox
	-- Cb[].refresh = function() Cb[]:SetChecked() end
	for k,v in pairs(Cb) do
		if Cb[k].refresh then
			Cb[k].refresh()
		end
	end
	-- DropDownMenu

	Sh_DDM[1]:SetText(Sh_LSM_Find(O["tex_barre"],M_statusbar,"statusbar"))
	Sh_opt_createMenuTable(Sh_DDM_items["player"][1],M_statusbar, O, "tex_barre", "statusbar")
	Sh_DDM[2]:SetText(Sh_LSM_Find(O["font:val"],M_font,"font"))
	Sh_opt_createMenuTable(Sh_DDM_items["player"][2],M_font, O, "font:val", "font")
	Sh_DDM[3]:SetText(Sh_LSM_Find(O["f:tex:border"],M_border,"border"))
	Sh_opt_createMenuTable(Sh_DDM_items["player"][3],M_border, O, "f:tex:border", "border")
	Sh_DDM[4]:SetText(Sh_LSM_Find(O["f:tex:fond"],M_background,"background"))
	Sh_opt_createMenuTable(Sh_DDM_items["player"][4],M_background, O, "f:tex:fond", "background")
	
	Sh_DDM[21]:SetText(Sh_LSM_Find(Ot["tex_barre"],M_statusbar,"statusbar"))
	Sh_opt_createMenuTable(Sh_DDM_items["target"][1],M_statusbar, Ot, "tex_barre", "statusbar")
	Sh_DDM[22]:SetText(Sh_LSM_Find(Ot["font:val"],M_font,"font"))
	Sh_opt_createMenuTable(Sh_DDM_items["target"][2],M_font, Ot, "font:val", "font")
	Sh_DDM[23]:SetText(Sh_LSM_Find(Ot["f:tex:border"],M_border,"border"))
	Sh_opt_createMenuTable(Sh_DDM_items["target"][3],M_border, Ot, "f:tex:border", "border")
	Sh_DDM[24]:SetText(Sh_LSM_Find(Ot["f:tex:fond"],M_background,"background"))
	Sh_opt_createMenuTable(Sh_DDM_items["target"][4],M_background, Ot, "f:tex:fond", "background")
	
	----------
	for j=1,getnB do
		--color_tex[j]:SetVertexColor(O[j .. ":r"],O[j .. ":v"],O[j .. ":b"])
		--color_tex[j+20]:SetVertexColor(Ot[j .. ":r"],Ot[j .. ":v"],Ot[j .. ":b"])
		
		Ordre["ordre"][j]:SetBackdropColor(O[j .. ":r"],O[j .. ":v"],O[j .. ":b"],0.2)
	
		color_tex[j]:SetVertexColor(O[j .. ":r"],O[j .. ":v"],O[j .. ":b"])
		color_tex[j+20]:SetVertexColor(Ot[j .. ":r"],Ot[j .. ":v"],Ot[j .. ":b"])
		

		Bftar[j]:SetStatusBarTexture(Ot["tex_barre"])
		Bftar[j]:SetStatusBarColor(Ot[j .. ":r"],Ot[j .. ":v"],Ot[j .. ":b"],(Ot["b:a"]/100))
		
		Bf[j]:SetStatusBarTexture(O["tex_barre"])
		Bf[j]:SetStatusBarColor(O[j .. ":r"],O[j .. ":v"],O[j .. ":b"],(O["b:a"]/100))

	
	end
		
	
	-- Refresh ordre :
	for i,j in pairs(Oo["Ord"]) do
		if Ordre["ordre"][j] then
			Ordre["ordre"][j]:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,-10-(30*i))
			Ordre["ordre"][j]:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,-10-(30*i)-30)
			Ordre["toggle"][j]:SetChecked(Oo["Ord:toggle"][j])
		end
	end
	
	
	Sh_profile_createlist()
end































------------------------------------------------------------------------------------
------------------------------------------ OPTION LOAD

function Sh_opt_LOAD()
	if Sh_DB then
		if	Sh_DB["Profile"] then 
			if Sh_DB["Profile"]["version"] ~= nil then
				if Sh_DB["Profile"]["version"] < 2.30 then
					Sh_DB = nil
				end
				
			end
		end
	end
	
	
	if not(Sh_DB) then
		Sh_DB = {}
		Sh_DB["Profile"] = {}
		Sh_DB["Profile"][NAME .. "-" .. REALM] = {}
		Sh_DB["Profile"][NAME .. "-" .. REALM][1] = "Default"
		Sh_DB["Profile"][NAME .. "-" .. REALM][2] = "Default"
		PROFILE = "Default"
		
		Sh_DB["Default"] = {}
		Sh_DB["Default"]["nb"] = 1
		Sh_DB["Default"]["O"] = Sh_deep(O)
		Sh_DB["Default"]["Ot"] = Sh_deep(Ot)
		Sh_DB["Default"]["Oo"] = Sh_deep(Oo)
	end
	
	
	
	local x1 = true
	if Sh_DB["Profile"] == nil or Sh_DB["Profile"][NAME .. "-" .. REALM] == nil or Sh_DB["Profile"][NAME .. "-" .. REALM][1] == nil or Sh_DB["Profile"][NAME .. "-" .. REALM][2] == nil or Sh_DB[Sh_DB["Profile"][NAME .. "-" .. REALM][1]] == nil or Sh_DB[Sh_DB["Profile"][NAME .. "-" .. REALM][2]] == nil then
		PROFILE = "Default"
		if Sh_DB["Profile"] == nil then Sh_DB["Profile"] = {} end
		Sh_DB["Profile"][NAME .. "-" .. REALM] = {}
		Sh_DB["Profile"][NAME .. "-" .. REALM][1] = "Default"
		Sh_DB["Profile"][NAME .. "-" .. REALM][2] = "Default"
		if Sh_DB[PROFILE] == nil then
			Sh_DB["Default"] = {}
			Sh_DB["Default"]["nb"] = 1
			Sh_DB["Default"]["O"] = Sh_deep(O)
			Sh_DB["Default"]["Ot"] = Sh_deep(Ot)
			Sh_DB["Default"]["Oo"] = Sh_deep(Oo)
		end
	end
	
	PROFILE = Sh_DB["Profile"][NAME .. "-" .. REALM][SPE_ACTIVE]
	local tempinfo = {}
	tempinfo["level"] = UnitLevel("player")
	tempinfo["classe"] = CLASS
	if GetSpecialization() ~= nil then
		_,tempinfo["spe1"] = GetSpecializationInfo(1)
		_,tempinfo["spe2"] = GetSpecializationInfo(2)
	else
		tempinfo["spe1"] = L["below_lvl_10"]
		tempinfo["spe2"] = L["below_lvl_10"]
	end
	Sh_DB["Profile"][NAME .. "-" .. REALM]["info"] = tempinfo

	
	
	O = Sh_deep(Sh_DB[PROFILE]["O"])
	Ot = Sh_deep(Sh_DB[PROFILE]["Ot"])
	Oo = Sh_deep(Sh_DB[PROFILE]["Oo"])

	if Sh_DB[PROFILE]["version"] ~= nil then
		if Sh_DB[PROFILE]["version"] >= VERSION then
			x1 = false
		end
	end
	
	
	if x1 then
		if Sh_DB["Profile"]["version"] then
			Sh_print("ShieldHealth has been updated : |cff00ff00v" .. Sh_DB["Profile"]["version"] .. "|r ==> |cff00ff00v" .. VERSION .. "|r !")
			
			O = {}
			Ot = {}
			Oo = {}
			Sh_options()
			for b,c in pairs(Sh_DB) do
				if b ~= "Profile" then
					if  Sh_DB[b]["O"] == nil then
						Sh_DB[b]["O"] = O
					end
					for k,v in pairs(O) do
						if Sh_DB[b]["O"][k] == nil then
							Sh_DB[b]["O"][k] = v
						end
					end
					
					if  Sh_DB[b]["Ot"] == nil then
						Sh_DB[b]["Ot"] = Ot
					end
					for k,v in pairs(O) do
						if Sh_DB[b]["Ot"][k] == nil then
							Sh_DB[b]["Ot"][k] = v
						end
					end
					
					if  Sh_DB[b]["Oo"] == nil then
						Sh_DB[b]["Oo"] = Oo
					end
					for k,v in pairs(Oo) do
						if Sh_DB[b]["Oo"][k] == nil then
							Sh_DB[b]["Oo"][k] = v
						end
					end
					
						
					if getn(Sh_DB[b]["Oo"]["Ord"]) < getn(Oo["Ord"]) then
						table.insert(Sh_DB[b]["Oo"]["Ord"],getn(Oo["Ord"]))
						table.insert(Sh_DB[b]["Oo"]["Ord:toggle"],true)
						table.insert(Sh_DB[b]["Oo"]["Ord:icon"],true)
					end
				end
			end
			
			O = Sh_deep(Sh_DB[PROFILE]["O"])
			Ot = Sh_deep(Sh_DB[PROFILE]["Ot"])
			Oo = Sh_deep(Sh_DB[PROFILE]["Oo"])
		else
			Sh_print("ShieldHealth has been installed : |cff00ff00v" .. VERSION .. "|r !")
		end
		if getn(Oo["Ord"]) ~= getnB then
			for i=1,getnB do
				Oo["Ord"][i] = i
				Oo["Ord:toggle"][i] = true
				Oo["Ord:icon"][i] = true
			end
		end
		
		Sh_DB["Profile"]["version"] = VERSION
		Sh_DB[PROFILE]["version"] = VERSION
	end
	
	Sh_EventFrame1:RegisterEvent("UNIT_AURA")
	Sh_EventFrame1:RegisterEvent("PLAYER_TARGET_CHANGED")
	Sh_EventFrame1bisbis:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	Sh_EventFrame3:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	Sh_EventFrame4:RegisterEvent("PLAYER_ENTERING_WORLD")
	Sh_EventFrame5:RegisterEvent("PLAYER_REGEN_DISABLED")
	Sh_EventFrame6:RegisterEvent("PLAYER_REGEN_ENABLED")
	--Sh_EventFrame7:RegisterEvent("CHAT_MSG_ADDON")
	
	
	
	Sh_opt()
	Sh_refresh()
	
end






function Sh_opt_OK()
   Sh_DB[PROFILE]["O"] = Sh_deep(O)
   Sh_DB[PROFILE]["Ot"] = Sh_deep(Ot)
	Sh_DB[PROFILE]["Oo"] = Sh_deep(Oo)
end

function Sh_spe_change()
if not(FIRST_CALL_ACTIVE_TALENT_GROUP_CHANGED) then
	SPE_ACTIVE = GetActiveSpecGroup()
	if SPE_ACTIVE == 1 then
		SPE_INACTIVE = 2
	else
		SPE_INACTIVE = 1
	end
	
	PROFILE = Sh_DB["Profile"][NAME .. "-" .. REALM][SPE_ACTIVE]
	profile_list = {}
	for k, v in pairs(Sh_DB) do
		if k ~= "Profile" then 
			if k == PROFILE then
				PROFILENB = Sh_DB[k]["nb"]
			end
			profile_list[Sh_DB[k]["nb"]] = k
		end
	end
	PROFILESELECTED = PROFILENB
	
	
	Sh_profile_appliquer(SPE_ACTIVE)
	
	Sh_refresh()
	Sh_refresh_options()
else
FIRST_CALL_ACTIVE_TALENT_GROUP_CHANGED = false
end
end

function Sh_cleanSV()
	if Sh_DB["Profile"][NAME .. "-" .. REALM]["info"]["time"] == nil then Sh_DB["Profile"][NAME .. "-" .. REALM]["info"]["time"] = DATE end
	for k,v in pairs(Sh_DB["Profile"]) do
		if k ~= "version" and k ~= NAME .. "-" .. REALM then
			if Sh_DB["Profile"][k]["info"]["level"] < 10 then
				Sh_DB["Profile"][k] = nil
			elseif (DATE - Sh_DB["Profile"][k]["info"]["time"]) > 14 then
				Sh_DB["Profile"][k] = nil
			end
		end
	end
	Sh_print(L["SVcleaned"])
end













------------------------------------------------------------------------------------




function Sh_EventFrame_OnEvent(self, event, unit)
	if unit == nil then
		unit = "target"
	end
	Sh_OnEvent(unit)
end

function Sh_EventFrame3_OnEvent(self,event,...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		if DEBUG_COMBAT_LOG ~= false then
			local x = {}
			x[1],x[2],x[3],x[4],x[5],x[6],x[7],x[8],x[9],x[10],x[11],x[12],x[13],x[14],x[15],x[16],x[17],x[18],x[19],x[20],x[21],x[22],x[23],x[24],x[25] = select(1, ...)
			x[26] = ""
			for i=1,25 do
				if x[i] ~= nil then
					x[26] = x[26] .. " | " .. i .. "-" .. tostring(x[i])
				end
			end
			if DEBUG_COMBAT_LOG == true then 
				print(x[26])
			elseif x[2] == DEBUG_COMBAT_LOG then
				print(x[26])
			end
		end
		
		local Type = select(2,...)
		
		
		if CLASS == "PRIEST" then
			if Type == "SPELL_ENERGIZE" and  Oo["cooldown"]["enable"] and Oo["cooldown"]["modules"]["rapture"] then
				if select(12, ...) == 47755 and select(5, ...) == NAME then
					cooldownTEX:SetTexture("Interface\\Icons\\spell_holy_rapture")
					cooldownTIME = GetTime() +12
					cooldownCD:SetCooldown(cooldownTIME-12,12)
					cooldownFRAME:Show()
				end
			end
		end
		
	end
end

























------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-------------------------------------]]--[[-----------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------ MENU DANS INTERFACE>ADDONS
function Sh_opt_menu()
   -- Crée le menu des options
   ------------------------------------------
	ShieldHealth = {}
	ShieldHealth.panel = CreateFrame( "Frame", "ShieldHealthPanel", UIParent)
	ShieldHealth.panel.name = "ShieldHealth"
	InterfaceOptions_AddCategory(ShieldHealth.panel)
	ShieldHealth.panel.okay = function ()  Sh_opt_OK() end
	ShieldHealth.panel.cancel = function () Sh_opt_OK() end
	ShieldHealth.panel.default = function ()  Sh_opt_OK() end



	ShieldHealth.childpanel_player = CreateFrame( "Frame", "ShieldHealthChildPlayer", ShieldHealth.panel)
	ShieldHealth.childpanel_player.name = L["Joueur"]
	ShieldHealth.childpanel_player.parent = ShieldHealth.panel.name
	InterfaceOptions_AddCategory(ShieldHealth.childpanel_player)
	
	ShieldHealth.childpanel_target = CreateFrame( "Frame", "ShieldHealthChildTarget", ShieldHealth.panel)
	ShieldHealth.childpanel_target.name = L["Cible"]
	ShieldHealth.childpanel_target.parent = ShieldHealth.panel.name
	InterfaceOptions_AddCategory(ShieldHealth.childpanel_target)
	
	
	
	ShieldHealth.childpanel_divers = CreateFrame( "Frame", "ShieldHealthChildDivers", ShieldHealth.panel)
	ShieldHealth.childpanel_divers.name = L["diverspanel"]
	ShieldHealth.childpanel_divers.parent = ShieldHealth.panel.name
	InterfaceOptions_AddCategory(ShieldHealth.childpanel_divers)
	
end


------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------ SLIDER
function Sh_opt_createSlider(nb,nom,parent,val,min,max,var,lock,unit)
	-- Règle les options du Slider
	------------------------------------------
	Slider[nb] = CreateFrame("Slider", nom, parent, "OptionsSliderTemplate")
	Slider[nb]:ClearAllPoints()
	Slider[nb]:SetMinMaxValues(min,max)
	Slider[nb]:SetValue(val)
	Slider[nb]:SetWidth(125)
	getglobal(Slider[nb]:GetName() .. 'Low'):SetText(min)
	getglobal(Slider[nb]:GetName() .. 'Text'):SetTextHeight(OPTIONTEXTHEIGHT)
	getglobal(Slider[nb]:GetName() .. 'High'):SetText(max)
	getglobal(Slider[nb]:GetName() .. 'Text'):SetTextHeight(OPTIONTEXTHEIGHT)
	getglobal(Slider[nb]:GetName() .. 'Text'):SetText(val)  
	getglobal(Slider[nb]:GetName() .. 'Text'):SetTextHeight(OPTIONTEXTHEIGHT)   
	Slider[nb]:SetValueStep(1)
	Slider[nb]:Show()


	Slidermoins[nb] = CreateFrame("Button", "Btn-_" .. nom, Slider[nb], "UIPanelButtonTemplate")
	Slidermoins[nb]:SetPoint("LEFT", -33, 0)
	Slidermoins[nb]:SetText("-")
	Slidermoins[nb]:SetWidth (17)
	Slidermoins[nb]:Show()

	Sliderplus[nb] = CreateFrame("Button", "Btn+_" .. nom, Slider[nb], "UIPanelButtonTemplate")
	Sliderplus[nb]:SetPoint("LEFT", -19, 0)
	Sliderplus[nb]:SetText("+")
	Sliderplus[nb]:SetWidth(17)
	Sliderplus[nb]:Show()

	-- met à jour la valeur au dessus su Slider
	Slider[nb]:SetScript("OnValueChanged", function() Sh_opt_SliderUpdate(nb,var,unit) end)
	Slidermoins[nb]:SetScript("OnClick",function() Slider[nb]:SetValue(Slider[nb]:GetValue()-1) Sh_opt_SliderUpdate(nb,var,unit) end)
	Sliderplus[nb]:SetScript("OnClick",function() Slider[nb]:SetValue(Slider[nb]:GetValue()+1) Sh_opt_SliderUpdate(nb,var,unit) end)
	
	-- permet de 'dévérouiller' le Slider
	if not(lock) then
		Slider[nb]:SetScript("OnMouseUp",  function() Sh_opt_SliderVal(nb) end)
		Sliderplus[nb]:SetScript("OnClick",function() Slider[nb]:SetValue(Slider[nb]:GetValue()+1) Sh_opt_SliderUpdate(nb,var,unit) Sh_opt_SliderVal(nb) end)
		Slidermoins[nb]:SetScript("OnClick",function() Slider[nb]:SetValue(Slider[nb]:GetValue()-1) Sh_opt_SliderUpdate(nb,var,unit) Sh_opt_SliderVal(nb) end)
	end
	   
end

function Sh_opt_SliderUpdate(nb,var,unit)
	local Sliderval =  math.ceil(Slider[nb]:GetValue())
	getglobal(Slider[nb]:GetName() .. 'Text'):SetText(Sliderval)
	if unit == "target" then
		Ot[var] = Sliderval
	elseif unit == "player" then
		O[var] = Sliderval
	else
		Oo["cooldown"][var] = Sliderval
	end
	Sh_refresh() 
end

function Sh_opt_SliderVal(nb)
   local slideval =  math.ceil(Slider[nb]:GetValue())
   Slider[nb]:SetMinMaxValues(slideval-100,slideval+100)
   Slider[nb]:SetValue(slideval)
   getglobal(Slider[nb]:GetName() .. 'Low'):SetText(slideval-100)
   getglobal(Slider[nb]:GetName() .. 'High'):SetText(slideval+100)
end

------------------------------------------
function Sh_opt_Slider(Slider,val,min,max)
   -- retourne la valeur de Slider ou le met aux valeurs précisés
   ------------------------------------------
   if val then
      Slider:SetMinMaxValues(min,max)
      Slider:SetValue(val)
      getglobal(Slider:GetName() .. 'Low'):SetText(min)
      getglobal(Slider:GetName() .. 'High'):SetText(max)
      Slider:SetValueStep(1)
   else 
      return  math.ceil(Slider:GetValue())
   end
end

------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------ CHECKBOX
function Sh_opt_createCheckbox(nom,texte,parent)
   -- règles les options de la checkbox
   ------------------------------------------
   local cbtemp = CreateFrame("CheckButton", nom, parent, "UICheckButtonTemplate")
   cbtemp:ClearAllPoints()
   _G[nom .. "Text"]:SetText(texte)
   _G[nom .. "Text"]:SetTextHeight(OPTIONTEXTHEIGHT)
   _G[nom .. "Text"]:SetTextColor(1,1,1,1)
   cbtemp:SetScript("OnClick", function()
			Sh_refresh()
		end
   )
   
   
   return cbtemp
end




function Sh_opt_createMenuTable(tabl,items,unit,var,type)
	for k,v in pairs(items) do
		local path =  LSM:Fetch(type,v)
		tabl[k] = {
		text = v,
		
		func = function()
			unit[var] = path
			Sh_refresh_options()
			Sh_refresh()
		end,
		}
		if unit[var] == path then
			tabl[k]["checked"] = true
		end
		if type == "background" or type == "statusbar" then
			tabl[k]["icon"] = path
		end
		if type == "font" then
			local font = CreateFont("fontddm" .. k)
			font:SetFont(path,11)
			tabl[k]["fontObject"] = font
		end
	end
end


	


------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------ COLOR PICKER

------------------------------------------
function Sh_opt_showCP(r, v, b, a, Sh_opt_CPCallback,n,unit,frame)
	-- Appel le ColorPicker puis la fonction de CallBack
	------------------------------------------ 
	ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = function() Sh_opt_CPCallback(false,n,unit,frame) end, Sh_opt_CPCallbackOK, function(restore) Sh_opt_CPCallback(restore,n,unit,frame) end
	ColorPickerFrame:SetColorRGB(r,v,b)
	ColorPickerFrame.hasOpacity, ColorPickerFrame.opacity = (a ~= nil), a
	ColorPickerFrame.previousValues = {r,v,b,a}
	ColorPickerFrame:Hide()
	ColorPickerFrame:Show()
end

------------------------------------------
function Sh_opt_CPCallback(restore,var,unit,frame)
   -- Fonction de CallBack du ColorPicker
   ------------------------------------------
	local newR, newV, newB, newA
	if restore then
		newR, newV, newB, newA = unpack(restore)
	else
		newA, newR, newV, newB = OpacitySliderFrame:GetValue(), ColorPickerFrame:GetColorRGB()
	end
	
	if frame.SetVertexColor ~= nil then
		frame:SetVertexColor(newR, newV, newB)
	elseif frame.SetBackdropColor ~= nil then
		frame:SetBackdropColor(newR, newV, newB, newA)
	end
	
	
	if unit == "target" then
		Ot[var .. ":r"], Ot[var .. ":v"], Ot[var .. ":b"], Ot[var .. ":a"] = newR, newV, newB, newA
		if type(var) == "number" then
			Bftar[var]:SetStatusBarColor(newR, newV, newB)
		end
	elseif unit == "player" then
		O[var .. ":r"], O[var .. ":v"], O[var .. ":b"], O[var .. ":a"] = newR, newV, newB, newA
		if type(var) == "number" then
			Bf[var]:SetStatusBarColor(newR, newV, newB)
		end
	end

end


function Sh_opt_CPCallbackOK()
	Sh_refresh_options()
	Sh_refresh()
end

------------------------------------------
function Sh_opt_createCP(nb,texte,parent,r,v,b,a)
	-- Fonction de création d'un carré de couleur qui appel le CP
	------------------------------------------
	Cp[nb] = CreateFrame("Frame","ColorPickerFrame",parent)
	Cp[nb]:SetFrameStrata("HIGH")
	Cp[nb]:SetWidth(45)
	Cp[nb]:SetHeight(18)


	local text = Cp[nb]:CreateFontString("ColorPickerText","MEDIUM","GameFontNormal")
	text:SetText(texte)
	text:SetTextHeight(OPTIONTEXTHEIGHT)
	text:SetTextColor(1,1,1,1)
	text:SetPoint("RIGHT", Cp[nb], -55, 0)
	text:Show()
end


function Sh_opt_texte(texte,parent)
	local text = parent:CreateFontString("TexteOption","MEDIUM","GameFontNormal")
	text:SetText(texte)
	text:SetTextHeight(OPTIONTEXTHEIGHT)
	text:SetTextColor(1,1,1,1)
	text:Show()
	return text  
end
   
   
   
  
  
  
---------------------------------------------------------------------------------------
--------------------- PROFILE

function Sh_profile_appliquer(spe)
	if SPE_ACTIVE == spe then	
		Sh_DB[PROFILE]["O"] = Sh_deep(O)
		Sh_DB[PROFILE]["Ot"] = Sh_deep(Ot)
		Sh_DB[PROFILE]["Oo"] = Sh_deep(Oo)
		
		Profile_SF_text[PROFILENB]:SetTextColor(1,1,1,1)
		
		PROFILE = profile_list[PROFILESELECTED]
		Sh_DB["Profile"][NAME .. "-" .. REALM][SPE_ACTIVE] = PROFILE
		PROFILENB = PROFILESELECTED
		
		O = Sh_deep(Sh_DB[PROFILE]["O"])
		Ot = Sh_deep(Sh_DB[PROFILE]["Ot"])
		Oo = Sh_deep(Sh_DB[PROFILE]["Oo"])
		
		
		Sh_refresh_options()
		Sh_refresh()
		Sh_profile_createlist()
	else
		Sh_DB["Profile"][NAME .. "-" .. REALM][spe] = profile_list[PROFILESELECTED]
		
		
		Sh_profile_createlist()
	end
end


function Sh_profile_rename(text)
	if text ~= nil and text ~= "Profile" and text ~= "" then
		local xcheck = true
		for k,v in pairs(Sh_DB) do
			if text == k then
				xcheck = false
				break
			end
		end
		
		if xcheck then
			Sh_DB[text] = Sh_deep(Sh_DB[profile_list[PROFILESELECTED]])
			Sh_DB[profile_list[PROFILESELECTED]] = nil
			if PROFILE == profile_list[PROFILESELECTED] then
				Sh_DB["Profile"][NAME .. "-" .. REALM][SPE_ACTIVE] = text
				PROFILE = text
				local x1 = 1
				for k,v in pairs(Sh_DB) do
					if PROFILE == k then
						PROFILENB = x1			
					end
					x1 = x1 + 1
				end
				x1 = nil
			end
			if Sh_DB["Profile"][NAME .. "-" .. REALM][SPE_ACTIVE] == profile_list[PROFILESELECTED] then
				Sh_DB["Profile"][NAME .. "-" .. REALM][SPE_ACTIVE] = text
			end
			
			Sh_profile_createlist()
		end
	end
end

function Sh_profile_saveas(text)
	if text ~= nil and text ~= "Profile" and text ~= "" then
		local xcheck = true
		for k,v in pairs(Sh_DB) do
			if text == k then
				xcheck = false
				break
			end
		end
		
		if xcheck then
			local x1 = {}
			local i = 1
			for k,v in pairs(Sh_DB) do
				if k ~= "Profile" then
					x1[i] = Sh_DB[k]["nb"]
					i = i + 1
				end
			end
			i = nil
			table.sort(x1)
			for i=1,(getn(x1)+1) do
				if x1[i] ~= i then
					x1 = i
					break
				end
			end
			Sh_DB[text] = Sh_deep(Sh_DB[profile_list[PROFILESELECTED]])
			Sh_DB[text]["nb"] = x1
			ccf:SetHeight(ccf:GetHeight()+25)
			
			Sh_profile_createlist()
		end
	end
end

function Sh_profile_new(text)
	if text ~= nil and text ~= "Profile" and text ~= "" then
		local xcheck = true
		for k,v in pairs(Sh_DB) do
			if text == k then
				xcheck = false
				break
			end
		end
		
		if xcheck then
			
			local x1 = {}
			local i = 1
			for k,v in pairs(Sh_DB) do
				if k ~= "Profile" then
					x1[i] = Sh_DB[k]["nb"]
					i = i + 1
				end
			end
			i = nil
			table.sort(x1)
			for i=1,(getn(x1)+1) do
				if x1[i] ~= i then
					x1 = i
					break
				end
			end
			Sh_DB[text] = {}
			Sh_options()
			
			Sh_DB[text]["nb"] = x1
			Sh_DB[text]["O"] = Sh_deep(O)
			Sh_DB[text]["Ot"] = Sh_deep(Ot)
			Sh_DB[text]["Oo"] = Sh_deep(Oo)
			
			Sh_profile_createlist()
		end
	end
end

function Sh_profile_delete()
	
	if profile_list[PROFILESELECTED] ~= PROFILE and profile_list[PROFILESELECTED] ~= Sh_DB["Profile"][NAME .. "-" .. REALM][SPE_INACTIVE] then
		for k,v in pairs(Sh_DB) do
			if k ~= "Profile" then
				if Sh_DB[k]["nb"] > Sh_DB[profile_list[PROFILESELECTED]]["nb"] then
					Sh_DB[k]["nb"] = Sh_DB[k]["nb"] - 1
				end
			end
		end
		Sh_DB[profile_list[PROFILESELECTED]] = nil
		
		PROFILESELECTED = PROFILENB
		Sh_profile_createlist(true)
	end
end



function Sh_profile_createlist(nchange)
	profile_list = {}
	for k, v in pairs(Sh_DB) do
		if k ~= "Profile" then 
			if k == PROFILE then
				PROFILENB = Sh_DB[k]["nb"]
			end
			profile_list[Sh_DB[k]["nb"]] = k
		end
	end
	if PROFILESELECTED == 0 then
		PROFILESELECTED = PROFILENB
	end
	
	ccf:SetSize(500, 25*(getn(Sh_DB)+1))
	
	if nchange then
		for k,v in pairs(Profile_SF_frame) do
			if Profile_SF_frame[k] ~= nil then
				Profile_SF_frame[k]:Hide()
			end
		end
	end
	
	local x1 = 1
	for i, k in pairs(profile_list) do
		if Profile_SF_frame[i] == nil then
			Profile_SF_frame[i] = CreateFrame("frame", "Profile_list_frame" .. i, ccf)
			Profile_SF_frame[i]:SetWidth(ccf:GetWidth())
			Profile_SF_frame[i]:SetHeight(25)
			Profile_SF_frame[i]:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
			edgeFile = nil,
			})
			Profile_SF_frame[i]:SetPoint("TOPLEFT", 0, -((i-x1)*25))

			Profile_SF_text[i] = Profile_SF_frame[i]:CreateFontString("Profile_list_text" .. i,"MEDIUM","GameFontNormal")
			Profile_SF_text[i]:SetTextHeight(OPTIONTEXTHEIGHT)
			Profile_SF_text[i]:SetPoint("LEFT", Profile_SF_frame[i], 5, 0)
			Profile_SF_text[i]:Show()
		end
		Profile_SF_frame[i]:SetBackdropColor(1,1,1,0)
		Profile_SF_frame[i]:Show()
		Profile_SF_text[i]:SetTextColor(1,1,1,1)
		Profile_SF_text[i]:SetText(k)
		if k == PROFILE then
			Profile_SF_frame[i]:SetBackdropColor(0,1,0,0.2)
		end

		
		if k == Sh_DB["Profile"][NAME .. "-" .. REALM][1] then
			Profile_SF_text[i]:SetText(C_BLEU .. k .. "|r")
		end
		if k == Sh_DB["Profile"][NAME .. "-" .. REALM][2] then
			Profile_SF_text[i]:SetText(C_ORANGE .. k .. "|r")
		end
		if k == Sh_DB["Profile"][NAME .. "-" .. REALM][1] and k == Sh_DB["Profile"][NAME .. "-" .. REALM][2] then
			Profile_SF_text[i]:SetText(C_VIOLET .. k .. "|r")
		end
		
		
		Profile_SF_frame[i]:SetScript("OnMouseDown",function(self)
				Profile_SF_frame[PROFILESELECTED]:SetBackdropColor(1,1,1,0)
				if profile_list[PROFILESELECTED] == PROFILE then
					Profile_SF_frame[PROFILESELECTED]:SetBackdropColor(0,1,0,0.2)
				end
				PROFILESELECTED = i
				self:SetBackdropColor(1,1,1,0.5)
				if k == PROFILE then
					self:SetBackdropColor(0,1,0,0.5)
				end
				
				Profile_SF_text[i]:SetPoint("LEFT", Profile_SF_frame[i], 6, -2)
			end
			)
		Profile_SF_frame[i]:SetScript("OnMouseUp",function(self)
				Profile_SF_text[i]:SetPoint("LEFT", Profile_SF_frame[i], 5, 0)
		end
		)
		Profile_SF_frame[i]:SetScript("OnEnter",function(self)
				if PROFILESELECTED ~= i then
					self:SetBackdropColor(1,1,1,0.1)
				end
				if k == PROFILE and PROFILESELECTED ~= i then
					self:SetBackdropColor(0,1,0,0.3)
				end
				GameTooltip:SetOwner(sftooltipanchor,"ANCHOR_BOTTOMLEFT",0,0)
				GameTooltip:SetText(L["tooltip_profile_list_titre"])
				local x1 = false
				if type(Sh_DB["Profile"][NAME .. "-" .. REALM]["info"]["time"]) ~= "number" then Sh_DB["Profile"][NAME .. "-" .. REALM]["info"]["time"] = DATE end
				for w,u in pairs(Sh_DB["Profile"]) do
					if w ~= "version" then
						if Sh_DB["Profile"][w][1] == k then
							x1 = true
							local x2 = "   "
							local info = Sh_DB["Profile"][w]["info"]
							
							if type(info["time"]) ~= number then
								info["time"] = DATE
							end
							if info["level"] < 10 or DATE-info["time"] > 14 then
								x2 = "X"
							end
							if NAME .. "-" .. REALM == w and SPE_ACTIVE == 1 then
								x2 = "> "
							end
							
							if info["spe1"] == nil then 
								_,Sh_DB["Profile"][NAME .. "-" .. REALM]["info"]["spe1"] = GetSpecializationInfo(1)
								_,info["spe1"] = GetSpecializationInfo(1)
							end
							GameTooltip:AddLine("|cffffffff" .. x2 .. "|r " .. w .. "  |cff55ff55lvl: " .. info["level"] .. "|r  |cffffffffspec 1: " .. info["spe1"] .. "|r  |cffbbbbbb(" .. DATE-info["time"] .. " days old)|r" , RAID_CLASS_COLORS[info["classe"]]["r"], RAID_CLASS_COLORS[info["classe"]]["g"], RAID_CLASS_COLORS[info["classe"]]["b"])
						end
						if Sh_DB["Profile"][w][2] == k then
							x1 = true
							local x2 = "   "
							local info = Sh_DB["Profile"][w]["info"]
							if info["level"] < 10 or DATE-info["time"] > 14 then
								x2 = "X"
							end
							if NAME .. "-" .. REALM == w and SPE_ACTIVE == 2 then
								x2 = "> "
							end
							
							if info["spe2"] == nil then 
								_,Sh_DB["Profile"][NAME .. "-" .. REALM]["info"]["spe2"] = GetSpecializationInfo(2)
								_,info["spe2"] = GetSpecializationInfo(2)
							end
							
							GameTooltip:AddLine("|cffffffff" .. x2 .. "|r " .. w .. "  |cff55ff55lvl: " .. info["level"] .. "|r  |cffffffffspec 2: " .. info["spe2"] .. "|r  |cffbbbbbb(" .. DATE-info["time"] .. " days old)|r" , RAID_CLASS_COLORS[info["classe"]]["r"], RAID_CLASS_COLORS[info["classe"]]["g"], RAID_CLASS_COLORS[info["classe"]]["b"])
						end
					end
				end
				if x1 then
					GameTooltip:Show()
				else
					GameTooltip:Hide()
				end
			end
		)
		Profile_SF_frame[i]:SetScript("OnLeave",function(self)
				if PROFILESELECTED ~= i then
					self:SetBackdropColor(1,1,1,0)
				end
				if PROFILESELECTED ~= i and k == PROFILE then
					self:SetBackdropColor(0,1,0,0.2)
				end
				GameTooltip:Hide()
			end
		)
	end
	Profile_SF_frame[PROFILESELECTED]:SetBackdropColor(1,1,1,0.5)
	if profile_list[PROFILESELECTED] == PROFILE then
		Profile_SF_frame[PROFILESELECTED]:SetBackdropColor(0,1,0,0.5)
	end
end


















function Sh_opt()
   Sh_opt_menu()


   
   ------------------------------------------------------------------------------------
   ------------------------------------------  CREATION DU MENU
   ------------------------------------------------------------------------------------
      
   ------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------
   ------------------------------------------ OPTIONS
   ------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------
	


	
	function Sh_opt_unlock()
		Sh_opt_moveframe(true)
		
		Btn[44]:Show()
		Btn[41]:SetText(L["Verouiller"])
		Sh_Tooltip(Btn[41],L["tooltip_lock"])
		Btn[41]:SetScript("OnClick",Sh_opt_lock)
	end
	
	function Sh_opt_lock()
		Sh_opt_moveframe(false)
		
		Btn[44]:Hide()
		Btn[41]:SetText(L["Deverouiller"])
		Sh_Tooltip(Btn[41],L["tooltip_unlock"])
		Btn[41]:SetScript("OnClick",Sh_opt_unlock)
	end
   
   	Btn[41] = CreateFrame("Button", "Btn41", ShieldHealth.panel, "UIPanelButtonTemplate")
	Btn[41]:SetPoint("LEFT",10,0)
	Btn[41]:SetText(L["Deverouiller"])
	Btn[41]:SetScript("OnClick",Sh_opt_unlock)
	Btn[41]:SetWidth (110)
	Btn[41]:Show()
	Sh_Tooltip(Btn[41],L["tooltip_unlock"])
	
   	Btn[42] = CreateFrame("Button", "Btn42", ShieldHealth.panel, "UIPanelButtonTemplate")
	Btn[42]:SetPoint("LEFT",120,0)
	Btn[42]:SetText(L["test"])
	Btn[42]:SetScript("OnClick",function()
			if TESTMODE then
				TESTMODE = false
			else
				TESTMODE = true
			end
			Sh_test()
			Sh_OnEvent("player")
			Sh_OnEvent("target")
		end
	)
	Btn[42]:SetWidth (110)
	Btn[42]:Show()
	Sh_Tooltip(Btn[42],L["tooltip_test"])
   
	Btn[44] = CreateFrame("Button", "Btn44", UIParent, "UIPanelButtonTemplate")
	Btn[44]:SetPoint("CENTER",0,50)
	Btn[44]:SetText(L["Verouiller"])
	Btn[44]:SetWidth (110)
	Btn[44]:SetScript("OnClick",Sh_opt_lock)
	Btn[44]:RegisterForDrag("LeftButton")
	Btn[44]:SetScript("OnDragStart", function()
			Btn[44]:StartMoving()
		end
	)
	Btn[44]:SetScript("OnDragStop", function()
			Btn[44]:StopMovingOrSizing()
		end
	)
	Btn[44]:SetMovable(true) 
	Btn[44]:EnableMouse(true)
	Btn[44]:Hide()
	Sh_Tooltip(Btn[44],L["tooltip_lock"])
	
	Btn[45] = CreateFrame("Button", "Btn" .. 45, ShieldHealth.panel, "UIPanelButtonTemplate")
	Btn[45]:SetPoint("LEFT",230,0)
	Btn[45]:SetText(L["reset_addon"])
	Btn[45]:SetScript("OnClick",function() StaticPopup_Show("SH_RESET_ADDON") end)
	Btn[45]:SetWidth(110)
	Btn[45]:Show()
	Sh_Tooltip(Btn[45],L["tooltip_resetall"])
	
	Btn[46] = CreateFrame("Button", "Btn" .. 46, ShieldHealth.panel, "UIPanelButtonTemplate")
	Btn[46]:SetPoint("LEFT",340,0)
	Btn[46]:SetText(L["cleanSV"])
	Btn[46]:SetScript("OnClick",Sh_cleanSV)
	Btn[46]:SetWidth(110)
	Btn[46]:Show()
	Sh_Tooltip(Btn[46],L["tooltip_cleanSV"])
	
	function Sh_opt_moveframe(bool)
		if bool then
			bg:RegisterForDrag("LeftButton")
			bg:SetMovable(true) 
			bg:EnableMouse(true)
			bg:SetScript("OnDragStart", function()
					bg:StartMoving()
				end
			)
			bg:SetScript("OnDragStop", function()
					bg:StopMovingOrSizing()
					O["f:pos:1"],O["f:pos:2"],O["f:pos:3"],O["f:pos:4"],O["f:pos:5"] = bg:GetPoint()
					Sh_DB[PROFILE]["O"]["f:pos:1"],Sh_DB[PROFILE]["O"]["f:pos:2"],Sh_DB[PROFILE]["O"]["f:pos:3"],Sh_DB[PROFILE]["O"]["f:pos:4"],Sh_DB[PROFILE]["O"]["f:pos:5"] = O["f:pos:1"],O["f:pos:2"],O["f:pos:3"],O["f:pos:4"],O["f:pos:5"]
				end
			)
			bg:SetFrameLevel(O["level"]+50)
			
			
			bgtar:RegisterForDrag("LeftButton")
			bgtar:SetMovable(true) 
			bgtar:EnableMouse(true)
			bgtar:SetScript("OnDragStart", function() bgtar:StartMoving() end)
			bgtar:SetScript("OnDragStop", function()
					bgtar:StopMovingOrSizing()
					Ot["f:pos:1"],Ot["f:pos:2"],Ot["f:pos:3"],Ot["f:pos:4"],Ot["f:pos:5"] = bgtar:GetPoint()
					Sh_DB[PROFILE]["Ot"]["f:pos:1"],Sh_DB[PROFILE]["Ot"]["f:pos:2"],Sh_DB[PROFILE]["Ot"]["f:pos:3"],Sh_DB[PROFILE]["Ot"]["f:pos:4"],Sh_DB[PROFILE]["Ot"]["f:pos:5"] = Ot["f:pos:1"],Ot["f:pos:2"],Ot["f:pos:3"],Ot["f:pos:4"],Ot["f:pos:5"]
				end
			)
			bgtar:SetFrameLevel(Ot["level"]+50)
			
			
			
			
			if not(Oo["cooldown"]["anchored"]) then
				cooldownFRAME:RegisterForDrag("LeftButton")
				cooldownFRAME:SetMovable(true) 
				cooldownFRAME:EnableMouse(true)
				cooldownFRAME:SetScript("OnDragStart", function() cooldownFRAME:StartMoving() end)
				cooldownFRAME:SetScript("OnDragStop", function()
						cooldownFRAME:StopMovingOrSizing()
						Oo["cooldown"]["pos:1"],Oo["cooldown"]["pos:2"],Oo["cooldown"]["pos:3"],Oo["cooldown"]["pos:4"],Oo["cooldown"]["pos:5"] = cooldownFRAME:GetPoint()
						Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:1"],Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:2"],Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:3"],Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:4"],Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:5"] = Oo["cooldown"]["pos:1"],Oo["cooldown"]["pos:2"],Oo["cooldown"]["pos:3"],Oo["cooldown"]["pos:4"],Oo["cooldown"]["pos:5"]
					end
				)
				cooldownFRAME:SetFrameLevel(Oo["cooldown"]["level"]+50)
			end
		else
		
			O["f:pos:1"],O["f:pos:2"],O["f:pos:3"],O["f:pos:4"],O["f:pos:5"] = bg:GetPoint()
			Sh_DB[PROFILE]["O"]["f:pos:1"],Sh_DB[PROFILE]["O"]["f:pos:2"],Sh_DB[PROFILE]["O"]["f:pos:3"],Sh_DB[PROFILE]["O"]["f:pos:4"],Sh_DB[PROFILE]["O"]["f:pos:5"] = O["f:pos:1"],O["f:pos:2"],O["f:pos:3"],O["f:pos:4"],O["f:pos:5"]
			bg:SetFrameLevel(O["level"])
			
			
			Ot["f:pos:1"],Ot["f:pos:2"],Ot["f:pos:3"],Ot["f:pos:4"],Ot["f:pos:5"] = bgtar:GetPoint()
			Sh_DB[PROFILE]["Ot"]["f:pos:1"],Sh_DB[PROFILE]["Ot"]["f:pos:2"],Sh_DB[PROFILE]["Ot"]["f:pos:3"],Sh_DB[PROFILE]["Ot"]["f:pos:4"],Sh_DB[PROFILE]["Ot"]["f:pos:5"] = Ot["f:pos:1"],Ot["f:pos:2"],Ot["f:pos:3"],Ot["f:pos:4"],Ot["f:pos:5"]
			bgtar:SetFrameLevel(Ot["level"])
			
			
			
			
			
			if not(Oo["cooldown"]["anchored"]) then
				Oo["cooldown"]["pos:1"],Oo["cooldown"]["pos:2"],Oo["cooldown"]["pos:3"],Oo["cooldown"]["pos:4"],Oo["cooldown"]["pos:5"] = cooldownFRAME:GetPoint()
				Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:1"],Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:2"],Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:3"],Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:4"],Sh_DB[PROFILE]["Oo"]["cooldown"]["pos:5"] = Oo["cooldown"]["pos:1"],Oo["cooldown"]["pos:2"],Oo["cooldown"]["pos:3"],Oo["cooldown"]["pos:4"],Oo["cooldown"]["pos:5"]
				cooldownFRAME:SetFrameLevel(Oo["cooldown"]["level"])
			end
			
			bg:SetMovable(false)
			bg:EnableMouse(false)
			bgtar:SetMovable(false)
			bgtar:EnableMouse(false)
			cooldownFRAME:SetMovable(false)
			cooldownFRAME:EnableMouse(false)
			
			TESTMODE = false
			Sh_test()
			Sh_OnEvent("player")
			Sh_OnEvent("target")
		end
	
	end
   
   
   
   
	--------------------------	--------------------------
	---------------------  PROFILE  ----------------------
	--------------------------	--------------------------
	
	
	local Shield_profile = CreateFrame("frame", "Shield_profile", ShieldHealth.panel)
	Shield_profile:SetFrameStrata("HIGH")
	Shield_profile:SetBackdrop({
		  bgFile = nil, 
		  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		  edgeSize = 11,
	})
	Shield_profile:SetBackdropColor(1,0,0,0)
	Shield_profile:SetPoint("TOPLEFT",ShieldHealth.panel,"TOPLEFT",5,-5)
	Shield_profile:SetPoint("BOTTOMRIGHT",ShieldHealth.panel,"RIGHT",-5,25)
	Shield_profile:Show()


	local text_Shield_profile = Sh_opt_texte(L["Profile"],Shield_profile)
	text_Shield_profile:SetFontObject("GameFontNormalLarge")
	text_Shield_profile:SetTextColor(0.8,0.8,0,1)
	text_Shield_profile:SetPoint("TOPLEFT", Shield_profile, 20, -5)
	text_Shield_profile:Show()
	

	sfborder = CreateFrame("frame", "Sh_SFborder_Profile", Shield_profile)
	sfborder:SetBackdrop({
		  bgFile = nil, 
		  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		  edgeSize = 11,
	})
	sfborder:SetPoint("TOPLEFT",Shield_profile,"TOPLEFT",10,-30)
	sfborder:SetPoint("BOTTOMRIGHT",Shield_profile,"BOTTOM",0,10)
	
	sftooltipanchor = CreateFrame("frame", "Sh_SFborder_Profile", Shield_profile)
	sftooltipanchor:SetPoint("TOPLEFT",sfborder,"TOPLEFT",0,0)
	sftooltipanchor:SetPoint("BOTTOMRIGHT",sfborder,"TOPLEFT",0,0)
	
	
	sf = CreateFrame("ScrollFrame", "Sh_SF_Profile", sfborder, "UIPanelScrollFrameTemplate")
	sf:SetPoint("TOPLEFT",sfborder,"TOPLEFT",3,-3)
	sf:SetPoint("BOTTOMRIGHT",sfborder,"BOTTOMRIGHT",-3,3)


	ccf = CreateFrame("Frame", "Sh_CF_Profile", sf)
	ccf:SetSize(500, 25*(getn(Sh_DB)+1))
	ccf:SetPoint("TOPLEFT")

	sf:SetScrollChild(ccf)


	Sh_profile_createlist()
	----------------------------
	------------- POPUP
	----------------------------
	
	StaticPopupDialogs["SH_PROFILE_RENAME"] = {
		text = L["Profile_Popup_rename"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnHide = function(self)

		end,
		hasEditBox = 1,
		maxLetters = 15,
		OnAccept = function(self)
			local text = self.editBox:GetText()
			Sh_profile_rename(text)
		end,
		EditBoxOnEnterPressed = function(self)
			local text = self:GetParent().editBox:GetText()
			Sh_profile_rename(text)
			self:GetParent():Hide()
		end,
		timeout = 60,
		hideOnEscape = 1
	}
	
	
	StaticPopupDialogs["SH_PROFILE_SAVEAS"] = {
		text = L["Profile_Popup_saveas"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnHide = function(self)

		end,
		hasEditBox = 1,
		maxLetters = 25,
		OnAccept = function(self)
			local text = self.editBox:GetText()
			Sh_profile_saveas(text)
		end,
		EditBoxOnEnterPressed = function(self)
			local text = self:GetParent().editBox:GetText()
			Sh_profile_saveas(text)
			self:GetParent():Hide()
		end,
		timeout = 60,
		hideOnEscape = 1
	}

	
	StaticPopupDialogs["SH_PROFILE_NEW"] = {
		text = L["Profile_Popup_new"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnHide = function(self)

		end,
		hasEditBox = 1,
		maxLetters = 25,
		OnAccept = function(self)
			local text = self.editBox:GetText()
			Sh_profile_new(text)
		end,
		EditBoxOnEnterPressed = function(self)
			local text = self:GetParent().editBox:GetText()
			Sh_profile_new(text)
			self:GetParent():Hide()
		end,
		timeout = 60,
		hideOnEscape = 1
	}	
	
	StaticPopupDialogs["SH_PROFILE_RESET"] = {
		text = L["Profile_Popup_reset"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnHide = function(self)

		end,
		OnAccept = Sh_reset,
		alert = 1,
		timeout = 60,
		hideOnEscape = 1
	}
	
	StaticPopupDialogs["SH_PROFILE_DELETE"] = {
		text = L["Profile_Popup_delete"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnHide = function(self)

		end,
		OnAccept = Sh_profile_delete,
		alert = 1,
		timeout = 60,
		hideOnEscape = 1
	}
	
	StaticPopupDialogs["SH_RESET_ADDON"] = {
		text = L["addon_Popup_reset"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnHide = function(self)

		end,
		OnAccept = function() StaticPopup_Show("SH_RESET_ADDON2") end,
		alert = 1,
		timeout = 60,
		hideOnEscape = 1
	}
	
	StaticPopupDialogs["SH_RESET_ADDON2"] = {
		text = L["addon_Popup_reset"],
		button1 = CANCEL,
		button2 = ACCEPT,
		OnHide = function(self)

		end,
		OnCancel = Sh_reset_addon,
		alert = 1,
		timeout = 60,
		hideOnEscape = 0
	}	
	-------------------------
	
	
	
	-------------------------
	-------------------------
	
	
	Btn[58] = CreateFrame("Button", "Btn58", sf, "UIPanelButtonTemplate")
	Btn[58]:SetPoint("LEFT",sf,"RIGHT",25,6*30-85)
	Btn[58]:SetText(C_BLEU .. L["Profile_appliquer_spe1"] .. "|r")
	Btn[58]:SetWidth (110)
	Btn[58]:SetScript("OnClick",function()
			Sh_profile_appliquer(1)
		end
	)
	Btn[58]:Show()
	Sh_Tooltip(Btn[58],L["tooltip_appliquer_spe1"])
	
	Btn[59] = CreateFrame("Button", "Btn59", sf, "UIPanelButtonTemplate")
	Btn[59]:SetPoint("LEFT",sf,"RIGHT",25,5*30-85)
	Btn[59]:SetText(C_ORANGE .. L["Profile_appliquer_spe2"] .. "|r")
	Btn[59]:SetWidth (110)
	Btn[59]:SetScript("OnClick",function()
			Sh_profile_appliquer(2)
		end
	)
	Btn[59]:Show()
	Sh_Tooltip(Btn[59],L["tooltip_appliquer_spe2"])
	
	
	
	
	Btn[51] = CreateFrame("Button", "Btn51", sf, "UIPanelButtonTemplate")
	Btn[51]:SetPoint("LEFT",sf,"RIGHT",25,4*30-85)
	Btn[51]:SetText(L["Profile_rename"])
	Btn[51]:SetWidth (110)
	Btn[51]:SetScript("OnClick",function()
			StaticPopup_Show("SH_PROFILE_RENAME")
		end
	)
	Btn[51]:Show()
	Sh_Tooltip(Btn[51],L["tooltip_rename"])
	
	Btn[52] = CreateFrame("Button", "Btn52", sf, "UIPanelButtonTemplate")
	Btn[52]:SetPoint("LEFT",sf,"RIGHT",25,3*30-85)
	Btn[52]:SetText(L["Profile_saveas"])
	Btn[52]:SetWidth (110)
	Btn[52]:SetScript("OnClick",function()
			StaticPopup_Show("SH_PROFILE_SAVEAS")
		end
	)
	Btn[52]:Show()
	Sh_Tooltip(Btn[52],L["tooltip_saveas"])
	
	Btn[53] = CreateFrame("Button", "Btn53", sf, "UIPanelButtonTemplate")
	Btn[53]:SetPoint("LEFT",sf,"RIGHT",25,2*30-85)
	Btn[53]:SetText(L["Profile_nouveau"])
	Btn[53]:SetWidth (110)
	Btn[53]:SetScript("OnClick",function()
			StaticPopup_Show("SH_PROFILE_NEW")
		end
	)
	Btn[53]:Show()
	Sh_Tooltip(Btn[53],L["tooltip_new"])
	
	Btn[54] = CreateFrame("Button", "Btn54", sf, "UIPanelButtonTemplate")
	Btn[54]:SetPoint("LEFT",sf,"RIGHT",25,1*30-85)
	Btn[54]:SetText(L["Profile_delete"])
	Btn[54]:SetWidth (110)
	Btn[54]:SetScript("OnClick",function()
			StaticPopup_Show("SH_PROFILE_DELETE")
		end
	)
	Btn[54]:Show()
	Sh_Tooltip(Btn[54],L["tooltip_delete"])
	
	Btn[55] = CreateFrame("Button", "Btn" .. 55, sf, "UIPanelButtonTemplate")
	Btn[55]:SetPoint("LEFT",sf,"RIGHT",25,0*30-85)
	Btn[55]:SetText(L["reset"])
	Btn[55]:SetScript("OnClick",function() StaticPopup_Show("SH_PROFILE_RESET") end)
	Btn[55]:SetWidth(110)
	Btn[55]:Show()
	Sh_Tooltip(Btn[55],L["tooltip_reset"])
	
	Btn[56] = CreateFrame("Button", "Btn" .. 56, Shield_profile, "UIPanelButtonTemplate")
	Btn[56]:SetPoint("LEFT",Shield_profile,"BOTTOMLEFT",0,0)
	Btn[56]:SetPoint("RIGHT",Shield_profile,"BOTTOM",0,0)
	Btn[56]:SetText(L["targettoplayer"])
	Sh_Tooltip(Btn[56],L["tooltip_targettoplayer"])
	Btn[56]:SetScript("OnClick",function() 
			local x2 = O["f:pos:1"]
			local x3 = O["f:pos:2"]
			local x4 = O["f:pos:3"]
			local x5 = O["f:pos:4"]
			local x6 = O["f:pos:5"] 


			O = Sh_deep(Ot)
			
			O["f:pos:1"] = x2
			O["f:pos:2"] = x3
			O["f:pos:3"] = x4
			O["f:pos:4"] = x5
			O["f:pos:5"] = x6
			
			
			Sh_refresh()
			Sh_opt_SliderVal(3)
			Sh_refresh_options()
			Sh_refresh()
			Sh_opt_SliderVal(3)

			
			Sh_opt_OK()
		end
	) 
	Btn[56]:Show()
	
	Btn[57] = CreateFrame("Button", "Btn" .. 57, Shield_profile, "UIPanelButtonTemplate")
	Btn[57]:SetPoint("LEFT",Shield_profile,"BOTTOM",0,0)
	Btn[57]:SetPoint("RIGHT",Shield_profile,"BOTTOMRIGHT",0,0)
	Btn[57]:SetText(L["playertotarget"])
	Sh_Tooltip(Btn[57],L["tooltip_playertotarget"])
	Btn[57]:SetScript("OnClick",function() 

			local x2 = Ot["f:pos:1"]
			local x3 = Ot["f:pos:2"]
			local x4 = Ot["f:pos:3"]
			local x5 = Ot["f:pos:4"]
			local x6 = Ot["f:pos:5"] 

			
			Ot = Sh_deep(O)

			Ot["f:pos:1"] = x2
			Ot["f:pos:2"] = x3
			Ot["f:pos:3"] = x4
			Ot["f:pos:4"] = x5
			Ot["f:pos:5"] = x6
			
			Sh_refresh()
			Sh_opt_SliderVal(23)
			Sh_refresh_options()
			Sh_refresh()
			Sh_opt_SliderVal(23)
			
			Sh_opt_OK()
		end
	) 
	Btn[57]:Show()
	
	
		

	
   ------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------
   ------------------------------------------ PLAYER&TARGET
   ------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------	
   ------------------------------------------ COULEUR DES BARRES

		function Sh_panel(var,parent,color_,slider_,ddm_,cp_,cb_,unit)

				local Shield_color = CreateFrame("frame", "Shield_color", parent)
				Shield_color:SetFrameStrata("HIGH")
				Shield_color:SetBackdrop({
					bgFile = nil, 
					edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
					edgeSize = 11,
				})
				Shield_color:SetBackdropColor(1,0,0,0)
				Shield_color:Show()

				
			
			Shield_color:SetPoint("TOPLEFT",parent,"TOP",0,-5)
			Shield_color:SetPoint("BOTTOMRIGHT",parent,"RIGHT",-5,-100)

			local x1 = -10

			for j=1,getnB do
				
				color[j+color_] = CreateFrame("Frame","ColorPickerFrame" .. j+color_,Shield_color)
				color[j+color_]:SetFrameStrata("HIGH")

				color_text[j+color_] = color[j+color_]:CreateFontString("ColorPickerText" .. j+color_,"MEDIUM","GameFontNormalSmall")
				color_text[j+color_]:SetText(B[j])
				color_text[j+color_]:SetTextColor(1,1,1,1)
				color_text[j+color_]:SetPoint("LEFT", color[j+color_], 21, 0)
				color_text[j+color_]:Show()

				
				
				
				color[j+color_]:SetPoint("TOPLEFT",Shield_color,"TOPLEFT",10,x1)
				color[j+color_]:SetPoint("BOTTOMRIGHT",Shield_color,"TOPRIGHT",-10,x1-20)
				color[j+color_]:SetScript("OnMouseDown", function() Sh_opt_showCP(var[j .. ":r"], var[j .. ":v"], var[j ..":b"],nil,Sh_opt_CPCallback,j,unit,color_tex[j+color_]) end)
						
				color_tex[j+color_] = color[j+color_]:CreateTexture(nil,"BACKGROUND")
				color_tex[j+color_]:SetTexture(var["tex_barre"])
				color_tex[j+color_]:SetVertexColor(var[j .. ":r"],var[j .. ":v"],var[j .. ":b"])
				color_tex[j+color_]:SetAllPoints(color[j+color_])
				
				
				
				local color_icon = CreateFrame("Frame","color_icon" .. j,color[j+color_])
				color_icon:SetHeight(18)
				color_icon:SetWidth(18)
				color_icon:SetPoint("LEFT",color[j+color_],"LEFT",2,0)
				color_icon:Show()
				local color_icon_tex = color_icon:CreateTexture(nil,"BACKGROUND")
				color_icon_tex:SetAllPoints(color_icon)
				color_icon_tex:SetTexture(Btex[j])
				x1 = x1 - 23
			end

			Sh_opt_createSlider(slider_,"Slider" .. slider_, Shield_color, var["b:a"], 0, 100, "b:a", true, unit)
			Slider[slider_]:SetPoint("RIGHT", Shield_color,"BOTTOMRIGHT",-5,20)
			Sh_Tooltip(Slider[slider_],L["tooltip_slider7"])

			local text_color_Shield1 = Sh_opt_texte(L["Transparence"], Shield_color)
			text_color_Shield1:SetPoint("LEFT", Shield_color,"BOTTOMLEFT", 5, 20)
				
			
			--[[ 
			if unit == "target" then
				
				Lockframe["colorshaman"] = CreateFrame("frame", parent, Shield_color)
				Lockframe["colorshaman"]:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background"})
				Lockframe["colorshaman"]:SetBackdropColor(0.3,0.3,0.3)
				Lockframe["colorshaman"]:SetFrameLevel(25)
				Lockframe["colorshaman"]:EnableMouse(true)
				Lockframe["colorshaman"]:SetPoint("TOPLEFT",Shield_color,"TOPLEFT",9,-9-(23*10))
				Lockframe["colorshaman"]:SetPoint("BOTTOMRIGHT",Shield_color,"TOPRIGHT",-9,-11-(23*10)-20)
				Lockframe["colorshaman"]:Show()
				
			end
			]]
		
			------------------------------------------------------------------------------------
			------------------------------------------ TEXTURE ET FONT DES BARRE
			local Shield_tex = CreateFrame("frame", "Shield_tex", parent)
			Shield_tex:SetFrameStrata("HIGH")
			Shield_tex:SetBackdrop({
				 bgFile = nil, 
				 edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				 edgeSize = 11,
			})
			Shield_tex:SetBackdropColor(1,0,0,0)
			Shield_tex:SetPoint("TOPLEFT",parent,"TOPLEFT",5,-50)
			Shield_tex:SetPoint("BOTTOMRIGHT",parent,"BOTTOM",0,5)
			Shield_tex:Show()

			Panel[unit .. "1"] = CreateFrame("frame", "Shield_panel_1", Shield_tex)
			Panel[unit .. "1"]:SetFrameStrata("HIGH")
			Panel[unit .. "1"]:SetBackdrop({
				 bgFile = nil, 
				 edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				 edgeSize = 11,
			})
			Panel[unit .. "1"]:SetBackdropColor(1,0,0,1)
			Panel[unit .. "1"]:SetPoint("TOPLEFT",Shield_tex,"TOPLEFT",0,0)
			Panel[unit .. "1"]:SetPoint("BOTTOMRIGHT",Shield_tex,"TOPRIGHT",0,-30*5)
			Panel[unit .. "1"]:Show()
			
			Panel[unit .. "2"] = CreateFrame("frame", "Shield_panel_1", Shield_tex)
			Panel[unit .. "2"]:SetFrameStrata("HIGH")
			Panel[unit .. "2"]:SetBackdrop({
				 bgFile = nil, 
				 edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				 edgeSize = 11,
			})
			Panel[unit .. "2"]:SetBackdropColor(1,0,0,1)
			Panel[unit .. "2"]:SetPoint("TOPLEFT",Panel[unit .. "1"],"BOTTOMLEFT",0,0)
			Panel[unit .. "2"]:SetPoint("BOTTOMRIGHT",Shield_tex,"BOTTOMRIGHT",0,0)
			Panel[unit .. "2"]:Show()




-- Titre			--------------------
			local text_Shield_panel1 = Sh_opt_texte(L[unit], Shield_tex)
			text_Shield_panel1:SetFontObject("GameFontNormalLarge")
			text_Shield_panel1:SetTextColor(0.8,0.8,0,1)
			text_Shield_panel1:SetPoint("LEFT", Shield_tex,"TOPLEFT", 20, 30)


-- Texture barre			----------
-- DDM
			local text_Shield_panel12 = Sh_opt_texte(L["Texture_barre_boucliers"], Panel[unit .. "1"])
			text_Shield_panel12:SetPoint("LEFT", Panel[unit .. "1"],"TOPLEFT", 5, -30*1)
			

			Sh_DDM_items[unit][1] = {}
			local ddm_frame = CreateFrame("Frame", "MenuFrame" .. ddm_, UIParent, "UIDropDownMenuTemplate")
			Sh_DDM[ddm_] = CreateFrame("Button", "DDM" .. ddm_, Panel[unit .. "1"], "UIPanelButtonTemplate")
			Sh_DDM[ddm_]:SetText(Sh_LSM_Find(var["tex_barre"],M_statusbar,"statusbar"))
			Sh_DDM[ddm_]:SetWidth (175)
			Sh_DDM[ddm_]:SetScript("OnClick",function()
				EasyMenu(Sh_DDM_items[unit][1], ddm_frame, "cursor", 0 , 0, "MENU")
			end
			)
			Sh_DDM[ddm_]:SetPoint("RIGHT",Panel[unit .. "1"],"TOPRIGHT",-5, -30*1)
			Sh_opt_createMenuTable(Sh_DDM_items[unit][1],M_statusbar, var, "tex_barre", "statusbar")
			Sh_Tooltip(Sh_DDM[ddm_],L["tooltip_DDM1"])

-- Police			----------
-- DDM
			local text_Shield_panel13 = Sh_opt_texte(L["Police_vie_boucliers"], Panel[unit .. "1"])
			text_Shield_panel13:SetPoint("LEFT", Panel[unit .. "1"],"TOPLEFT", 5, -30*2)

			Sh_DDM_items[unit][2] = {}
			local ddm_frame = CreateFrame("Frame", "MenuFrame" .. ddm_+1, UIParent, "UIDropDownMenuTemplate")
			Sh_DDM[ddm_+1] = CreateFrame("Button", "DDM" .. ddm_+1, Panel[unit .. "1"], "UIPanelButtonTemplate")
			Sh_DDM[ddm_+1]:SetText(Sh_LSM_Find(var["font:val"],M_font,"font"))
			Sh_DDM[ddm_+1]:SetWidth (175)
			Sh_DDM[ddm_+1]:SetScript("OnClick",function()
				EasyMenu(Sh_DDM_items[unit][2], ddm_frame, "cursor", 0 , 0, "MENU")
			end
			)
			Sh_DDM[ddm_+1]:SetPoint("RIGHT",Panel[unit .. "1"],"TOPRIGHT",-5, -30*2)
			Sh_opt_createMenuTable(Sh_DDM_items[unit][2],M_font, var, "font:val", "font")
			Sh_Tooltip(Sh_DDM[ddm_+1],L["tooltip_DDM2"])
			
-- Contour texte			----------
-- CB
			Cb[cb_+4] = Sh_opt_createCheckbox("Cb" .. cb_+4, L["Contour"], Panel[unit .. "1"])
			Cb[cb_+4]:SetPoint("LEFT",Panel[unit .. "1"],"TOPLEFT",5,-30*3)
			Cb[cb_+4]:SetChecked(var["contour"])
			Cb[cb_+4].refresh = function() Cb[cb_+4]:SetChecked(var["contour"]) end
			Cb[cb_+4]:SetScript("OnClick",function() var["contour"] = Cb[cb_+4]:GetChecked() Sh_refresh() end)
			Cb[cb_+4]:Show()
			Sh_Tooltip(Cb[cb_+4],L["tooltip_CB5"])
			
-- Couleur texte			----------
-- CP
			Sh_opt_createCP(cp_,L["Couleur_texte"], Panel[unit .. "1"], var["font:val:r"], var["font:val:v"], var["font:val:b"])
			Cp[cp_]:SetPoint("RIGHT",Panel[unit .. "1"],"TOPRIGHT",-10,-30*3)

			Cp[cp_]:SetScript("OnMouseDown", function() Sh_opt_showCP(var["font:val:r"], var["font:val:v"], var["font:val:b"], var["font:val:a"],Sh_opt_CPCallback,"font:val",unit,Color_fontval_tex[cp_]) end)

			Color_fontval_tex[cp_] = Cp[cp_]:CreateTexture(nil,"BACKGROUND")
			Color_fontval_tex[cp_]:SetTexture("Interface\\Buttons\\WHITE8X8")
			Color_fontval_tex[cp_]:SetVertexColor(var["font:val:r"],var["font:val:v"],var["font:val:b"],var["font:val:a"])
			Color_fontval_tex[cp_]:SetAllPoints(Cp[cp_])
			Sh_Tooltip(Cp[cp_],L["tooltip_CP1"])
				 
-- Taille texte			----------
-- SLIDER
			Sh_opt_createSlider(slider_+1, "Slider" .. slider_+1, Panel[unit .. "1"], var["font:val:size"], 1, 30, "font:val:size", true, unit)
			Slider[slider_+1]:SetPoint("RIGHT", Panel[unit .. "1"],"TOPRIGHT",-10,-30*4)
			Sh_Tooltip(Slider[slider_+1],L["tooltip_slider2"])

			local text_Shield_panel10 = Sh_opt_texte(L["Taille_texte"], Panel[unit .. "1"])
			text_Shield_panel10:SetPoint("LEFT", Panel[unit .. "1"],"TOPLEFT", 5, -30*4)
			
			
			
			--------------------
			--------------------
			

-- Largeur barre			----------
-- SLIDER
			Sh_opt_createSlider(slider_+2, "Slider" .. slider_+2, Panel[unit .. "2"], var["f:largeur"], var["f:largeur"]-100, var["f:largeur"]+100, "f:largeur", false, unit)
			Slider[slider_+2]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10,-30*1)
			Sh_Tooltip(Slider[slider_+2],L["tooltip_slider3"])

			local text_Shield_panel25 = Sh_opt_texte(L["Largeur_globale"], Panel[unit .. "2"])
			text_Shield_panel25:SetPoint("LEFT", Panel[unit .. "2"],"TOPLEFT", 5, -30*1)

-- Hauteur barre			----------
-- SLIDER
			Sh_opt_createSlider(slider_+3, "Slider" .. slider_+3, Panel[unit .. "2"], var["f:hauteur"], 1, 100, "f:hauteur", true, unit)
			Slider[slider_+3]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10,-30*2)
			Sh_Tooltip(Slider[slider_+3],L["tooltip_slider4"])
			
			local text_Shield_panel26 = Sh_opt_texte(L["Hauteur_globale"], Panel[unit .. "2"])
			text_Shield_panel26:SetPoint("LEFT", Panel[unit .. "2"],"TOPLEFT", 5, -30*2)

-- Bordure			----------
-- DDM
			local text_Shield_panel27 = Sh_opt_texte(L["Texture_bordure_generale"], Panel[unit .. "2"])
			text_Shield_panel27:SetPoint("LEFT", Panel[unit .. "2"],"TOPLEFT", 5, -30*3)

			Sh_DDM_items[unit][3] = {}
			local ddm_frame = CreateFrame("Frame", "MenuFrame" .. ddm_+2, UIParent, "UIDropDownMenuTemplate")
			Sh_DDM[ddm_+2] = CreateFrame("Button", "DDM" .. ddm_+2, Panel[unit .. "2"], "UIPanelButtonTemplate")
			Sh_DDM[ddm_+2]:SetText(Sh_LSM_Find(var["f:tex:border"],M_border,"border"))
			Sh_DDM[ddm_+2]:SetWidth (175)
			Sh_DDM[ddm_+2]:SetScript("OnClick",function()
				EasyMenu(Sh_DDM_items[unit][3], ddm_frame, "cursor", 0 , 0, "MENU")
			end
			)
			Sh_DDM[ddm_+2]:SetPoint("RIGHT",Panel[unit .. "2"],"TOPRIGHT",-5, -30*3)
			Sh_opt_createMenuTable(Sh_DDM_items[unit][3],M_border, var, "f:tex:border", "border")
			Sh_Tooltip(Sh_DDM[ddm_+2],L["tooltip_DDM3"])

-- Bordure épaisseur			----------
-- SLIDER
			Sh_opt_createSlider(slider_+4, "Slider" .. slider_+4, Panel[unit .. "2"], var["border:size"], 0, 50, "border:size", true, unit)
			Slider[slider_+4]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10,-30*4)
			Sh_Tooltip(Slider[slider_+4],L["tooltip_slider5"])

			local text_Shield_panel211 = Sh_opt_texte(L["Taille_bordure"], Panel[unit .. "2"])
			text_Shield_panel211:SetPoint("LEFT", Panel[unit .. "2"],"TOPLEFT", 5, -30*4)

-- Bordure marge			---------
-- SLIDERS
			local text_Shield_panel216 = Sh_opt_texte(L["insets"], Panel[unit .. "2"])
			text_Shield_panel216:SetPoint("LEFT", Panel[unit .. "2"],"TOPLEFT", 5, -30*5)  
			---------

			Sh_opt_createSlider(slider_+9, "Slider" .. slider_+9, Panel[unit .. "2"], var["insets:left"], 0, 20, "insets:left", true, unit)
			Slider[slider_+9]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10,-30*5-15)
			Slider[slider_+9]:SetWidth(50)
			Slidermoins[slider_+9]:Hide()
			Sliderplus[slider_+9]:Hide()
			local text_Shield_panel214 = Sh_opt_texte(L["left"], Panel[unit .. "2"])
			text_Shield_panel214:SetPoint("CENTER", Slider[slider_+9],"CENTER", 0, -20)
			Sh_Tooltip(Slider[slider_+9],L["tooltip_slider10"])

			
			Sh_opt_createSlider(slider_+10, "Slider" .. slider_+10, Panel[unit .. "2"], var["insets:right"], 0, 20, "insets:right", true, unit)
			Slider[slider_+10]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10-65*1,-30*5-15)
			Slider[slider_+10]:SetWidth(50)
			Slidermoins[slider_+10]:Hide()
			Sliderplus[slider_+10]:Hide()
			local text_Shield_panel215 = Sh_opt_texte(L["right"], Panel[unit .. "2"])
			text_Shield_panel215:SetPoint("CENTER", Slider[slider_+10],"CENTER", 0, -20)
			Sh_Tooltip(Slider[slider_+10],L["tooltip_slider11"])
			
			
			Sh_opt_createSlider(slider_+11, "Slider" .. slider_+11, Panel[unit .. "2"], var["insets:top"], 0, 20, "insets:top", true, unit)
			Slider[slider_+11]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10-65*2,-30*5-15)
			Slider[slider_+11]:SetWidth(50)
			Slidermoins[slider_+11]:Hide()
			Sliderplus[slider_+11]:Hide()
			local text_Shield_panel215 = Sh_opt_texte(L["top"], Panel[unit .. "2"])
			text_Shield_panel215:SetPoint("CENTER", Slider[slider_+11],"CENTER", 0, -20) 
			Sh_Tooltip(Slider[slider_+11],L["tooltip_slider12"])

			
			Sh_opt_createSlider(slider_+12, "Slider" .. slider_+12, Panel[unit .. "2"], var["insets:bottom"], 0, 20, "insets:bottom", true, unit)
			Slider[slider_+12]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10-65*3,-30*5-15)
			Slider[slider_+12]:SetWidth(50)
			Slidermoins[slider_+12]:Hide()
			Sliderplus[slider_+12]:Hide()
			local text_Shield_panel215 = Sh_opt_texte(L["bottom"], Panel[unit .. "2"])
			text_Shield_panel215:SetPoint("CENTER", Slider[slider_+12],"CENTER", 0, -20)
			Sh_Tooltip(Slider[slider_+12],L["tooltip_slider13"])

-- Background barre			-----------------------------------------------------------------------
-- DDM
			local text_Shield_panel28 = Sh_opt_texte(L["Texture_fond"], Panel[unit .. "2"])
			text_Shield_panel28:SetPoint("LEFT", Panel[unit .. "2"],"TOPLEFT", 5, -30*7)
			
			
			Sh_DDM_items[unit][4] = {}
			local ddm_frame = CreateFrame("Frame", "MenuFrame" .. ddm_+3, UIParent, "UIDropDownMenuTemplate")
			Sh_DDM[ddm_+3] = CreateFrame("Button", "DDM" .. ddm_+3, Panel[unit .. "2"], "UIPanelButtonTemplate")
			Sh_DDM[ddm_+3]:SetText(Sh_LSM_Find(var["f:tex:fond"],M_background,"background"))
			Sh_DDM[ddm_+3]:SetWidth (175)
			Sh_DDM[ddm_+3]:SetScript("OnClick",function()
				EasyMenu(Sh_DDM_items[unit][4], ddm_frame, "cursor", 0 , 0, "MENU")
			end
			)
			Sh_DDM[ddm_+3]:SetPoint("RIGHT",Panel[unit .. "2"],"TOPRIGHT",-5, -30*7)
			Sh_opt_createMenuTable(Sh_DDM_items[unit][4],M_background, var, "f:tex:fond", "background")
			Sh_Tooltip(Sh_DDM[ddm_+3],L["tooltip_DDM4"])
			

-- Background couleur			---------
-- CP
			Sh_opt_createCP(cp_+1,L["Couleur_fond"], Panel[unit .. "2"], var["f:SBC:r"], var["f:SBC:v"], var["f:SBC:b"])
			Cp[cp_+1]:SetPoint("RIGHT",Panel[unit .. "2"],"TOPRIGHT",-5,-30*8)

			Cp[cp_+1]:SetScript("OnMouseDown", function() Sh_opt_showCP(var["f:SBC:r"], var["f:SBC:v"], var["f:SBC:b"], var["f:SBC:a"],Sh_opt_CPCallback,"f:SBC",unit,Color_fontval_tex[cp_+1]) end)
			
			Color_fontval_tex[cp_+1] = Cp[cp_+1]:CreateTexture(nil,"BACKGROUND")
			Color_fontval_tex[cp_+1]:SetTexture(var["f:tex:fond"])
			Color_fontval_tex[cp_+1]:SetVertexColor(var["f:SBC:r"],var["f:SBC:v"],var["f:SBC:b"],var["f:SBC:a"])
			Color_fontval_tex[cp_+1]:SetAllPoints(Cp[cp_+1])
			Sh_Tooltip(Cp[cp_+1],L["tooltip_CP2"])

-- Taille icone			----------
-- SLIDER
			
			
			Sh_opt_createSlider(slider_+5, "Slider" .. slider_+5, Panel[unit .. "2"], var["iconsize"], 0, 100, "iconsize", true, unit)
			Slider[slider_+5]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10,-30*9)

			local text_Shield_panel29 = Sh_opt_texte(L["Taille_icones"], Panel[unit .. "2"])
			text_Shield_panel29:SetPoint("LEFT", Panel[unit .. "2"],"TOPLEFT", 5, -30*9)
			Sh_Tooltip(Slider[slider_+5],L["tooltip_slider6"])
		
		
		
-- Contour texte			----------
-- CB
		
			
			Cb[cb_+6] = Sh_opt_createCheckbox("Cb" .. cb_+6, "", Panel[unit .. "2"])
			Cb[cb_+6]:SetPoint("LEFT",Panel[unit .. "2"],"TOPRIGHT",-200,-30*9)
			Cb[cb_+6]:SetChecked(var["autoicon"])
			Cb[cb_+6].refresh = function() Cb[cb_+6]:SetChecked(var["autoicon"]) end
			Cb[cb_+6]:SetScript("OnClick",function() var["autoicon"] = Cb[cb_+6]:GetChecked() Sh_refresh() end)
			Cb[cb_+6]:Show()
			Sh_Tooltip(Cb[cb_+6],L["tooltip_CB7"])
				

			
-- Frame level			--------
-- SLIDER
			
			Sh_opt_createSlider(slider_+6, "Slider" .. slider_+6, Panel[unit .. "2"], var["level"], 1, 100, "level", true, unit)
			Slider[slider_+6]:SetPoint("RIGHT", Panel[unit .. "2"],"TOPRIGHT",-10,-30*10)
			Sh_Tooltip(Slider[slider_+6],L["tooltip_slider7"])

			local text_Shield_panel210 = Sh_opt_texte(L["level"], Panel[unit .. "2"])
			text_Shield_panel210:SetPoint("LEFT", Panel[unit .. "2"],"TOPLEFT", 5, -30*10)
			
			------------------------------------
			------------------------------------
			
			local Shield_check = CreateFrame("frame", "Shield_check", parent)
			Shield_check:SetFrameStrata("HIGH")
			Shield_check:SetBackdrop({
				bgFile = nil, 
				edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
				edgeSize = 11,
			})
			Shield_check:SetBackdropColor(1,0,0,0)
			Shield_check:SetPoint("TOPLEFT",Shield_color,"BOTTOMLEFT",0,0)
			Shield_check:SetPoint("BOTTOMRIGHT",parent,"BOTTOMRIGHT",-5,5)
			Shield_check:Show()


			local text_Shield_check = Shield_check:CreateFontString("texteOption","MEDIUM","GameFontNormalLarge")
			text_Shield_check:SetText(L["Options"])
			text_Shield_check:SetPoint("TOPLEFT", Shield_check, 20, -5)
			text_Shield_check:Show()

			-----------------
			
			Cb[cb_] = Sh_opt_createCheckbox("Cb" .. cb_, L["Activer"], Shield_check)
			Cb[cb_]:SetPoint("TOPLEFT",10,-30)
			Cb[cb_]:SetChecked(var["enable"])
			Cb[cb_].refresh = function() Cb[cb_]:SetChecked(var["enable"]) end
			Cb[cb_]:SetScript("OnClick",function() var["enable"] = Cb[cb_]:GetChecked() Sh_refresh() end)
			Cb[cb_]:Show()
			Sh_Tooltip(Cb[cb_],L["tooltip_CB1"])
			

			-- Cooldown

			Cb[cb_+2] = Sh_opt_createCheckbox("Cb" .. cb_+2, L["short"], Shield_check)
			Cb[cb_+2]:SetPoint("TOP",10,-30)
			Cb[cb_+2]:SetChecked(var["short"])
			Cb[cb_+2].refresh = function() Cb[cb_+2]:SetChecked(var["short"]) end
			Cb[cb_+2]:SetScript("OnClick",function() var["short"] = Cb[cb_+2]:GetChecked() Sh_refresh() end)
			Cb[cb_+2]:Show()
			Sh_Tooltip(Cb[cb_+2],L["tooltip_CB3"])

			if unit == "player" or unit == "target" then
				Cb[cb_+3] = Sh_opt_createCheckbox("Cb" .. cb_+3, L["blink"], Shield_check)
				Cb[cb_+3]:SetPoint("TOP",10,-65)
				Cb[cb_+3]:SetChecked(var["blink"])
				Cb[cb_+3].refresh = function() Cb[cb_+3]:SetChecked(var["blink"]) end
				Cb[cb_+3]:SetScript("OnClick",function() var["blink"] = Cb[cb_+3]:GetChecked() Sh_refresh() end)
				Cb[cb_+3]:Show()
				Sh_Tooltip(Cb[cb_+3],L["tooltip_CB4"])
			end
			
			Cb[cb_+5] = Sh_opt_createCheckbox("Cb" .. cb_+5, L["show_only_in_combat"], Shield_check)
			Cb[cb_+5]:SetPoint("TOPLEFT",10,-65)
			Cb[cb_+5]:SetChecked(var["show_only_in_combat"])
			Cb[cb_+5].refresh = function() Cb[cb_+5]:SetChecked(var["show_only_in_combat"]) end
			Cb[cb_+5]:SetScript("OnClick",function() var["show_only_in_combat"] = Cb[cb_+5]:GetChecked() Sh_refresh() end)
			Cb[cb_+5]:Show()
			Sh_Tooltip(Cb[cb_+5],L["tooltip_CB6"])
		
		end
		
		
		
		
		Sh_panel(O,ShieldHealth.childpanel_player,0,1,1,1,1,"player")
		Sh_panel(Ot,ShieldHealth.childpanel_target,20,21,21,21,21,"target")

   
   
   
   ------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------
   --------------------------------- ORDRE DES BOUCLIERS
   ------------------------------------------------------------------------------------
   ------------------------------------------------------------------------------------
    

   	local Shield_ordre = CreateFrame("frame", "Shield_ordre", ShieldHealth.childpanel_divers)
	Shield_ordre:SetFrameStrata("HIGH")
	Shield_ordre:SetBackdrop({
        bgFile = nil, 
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 11,
	})
	Shield_ordre:SetBackdropColor(1,0,0,0)
	Shield_ordre:SetPoint("TOPLEFT",ShieldHealth.childpanel_divers,"TOPLEFT",5,-5)
	Shield_ordre:SetPoint("BOTTOMRIGHT",ShieldHealth.childpanel_divers,"BOTTOM",0,5)
	Shield_ordre:Show()
	local text_Shield_ordre = Shield_ordre:CreateFontString("Ordre","MEDIUM","GameFontNormalLarge")
	text_Shield_ordre:SetText(L["Ordre"])
	text_Shield_ordre:SetTextColor(0.8,0.8,0,1)
	text_Shield_ordre:SetPoint("TOPLEFT", Shield_ordre,"TOPLEFT", 10, -5)
	text_Shield_ordre:Show()
	
	
	
	
	for j=1,getnB do
		Ordre["ordre"][j] = CreateFrame("Frame","Ordre" .. j,Shield_ordre)
		Ordre["ordre"][j]:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", 
			edgeFile = nil,
		})
		Ordre["ordre"][j]:SetBackdropColor(O[j .. ":r"],O[j .. ":v"],O[j .. ":b"],0.3)
		Ordre["ordre"][j]:Show()
		
		Ordre["icon"][j] = CreateFrame("Frame","OrdreIcon" .. j,Ordre["ordre"][j])
		Ordre["icon"][j]:SetHeight(20)
		Ordre["icon"][j]:SetWidth(20)
		Ordre["icon"][j]:SetPoint("LEFT",Ordre["ordre"][j],"LEFT",2,0)
		Ordre["icon"][j]:Show()
		Ordre["icontex"][j] = Ordre["icon"][j]:CreateTexture(nil,"BACKGROUND")
		Ordre["icontex"][j]:SetAllPoints(Ordre["icon"][j])
		Ordre["icontex"][j]:SetTexture(Btex[j])
		
		Ordre["text"][j] = Ordre["ordre"][j]:CreateFontString("text","MEDIUM","GameFontNormal")
		Ordre["text"][j]:SetText(B[j])
		Ordre["text"][j]:SetTextColor(1,1,1)
		Ordre["text"][j]:SetPoint("LEFT", Ordre["ordre"][j],"LEFT", 24, 0)
		Ordre["text"][j]:Show()
		
		
		local speed = 3
		Ordre["up"][j] =  CreateFrame("Button", "OrdreUp" .. j, Ordre["ordre"][j], "UIPanelScrollUpButtonTemplate")
		Ordre["up"][j]:SetPoint("RIGHT",Ordre["ordre"][j],"RIGHT",-100, 0)
		Ordre["up"][j]:SetScript("OnClick",function(self)
				for k=1,getnB do 
					if Oo["Ord"][k] == j then
						if k ~= 1 then
							local _,_,_,_,x1 = Ordre["ordre"][j]:GetPoint(1)
							local x2,x3 = 0,0
							Ordre["ordre"][j]:SetScript("OnUpdate",function(self)
									if speed*x2 >= 30 then
										self:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,x1+30)
										self:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,x1)
										self:SetScript("OnUpdate",nil)
									else
										self:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,x1 +speed*x2)
										self:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,x1-30 +speed*x2)
										x2 = x2 + 1
									end
								end
							)
							
							Ordre["ordre"][Oo["Ord"][k-1]]:SetScript("OnUpdate",function(self)
									if speed*x3 >= 30 then
										self:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,x1)
										self:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,x1-30)
										self:SetScript("OnUpdate",nil)
									else
										self:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,x1+30 -speed*x3)
										self:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,x1 -speed*x3)
										x3 = x3 + 1
									end
								end
							)
							Oo["Ord"][k],Oo["Ord"][k-1] = Oo["Ord"][k-1],Oo["Ord"][k]
							Sh_DB[PROFILE]["Oo"]["Ord"] = Oo["Ord"]
							Sh_refresh()
							break
						end
					end
				end
			end
		)
		Ordre["up"][j]:SetWidth(20)
		Ordre["up"][j]:Show()
		
		
		Ordre["down"][j] =  CreateFrame("Button", "OrdreDown" .. j, Ordre["ordre"][j], "UIPanelScrollDownButtonTemplate")
		Ordre["down"][j]:SetPoint("RIGHT",Ordre["ordre"][j],"RIGHT", -80, 0)
		Ordre["down"][j]:SetScript("OnClick",function(self)
					for k=1,getnB do 
						if Oo["Ord"][k] == j then
							if k ~= getnB then
								local _,_,_,_,x1 = Ordre["ordre"][Oo["Ord"][k+1]]:GetPoint()
								local x2,x3 = 0,0
								Ordre["ordre"][Oo["Ord"][k+1]]:SetScript("OnUpdate",function(self)
										if speed*x2 >= 30 then
											self:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,x1+30)
											self:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,x1)
											self:SetScript("OnUpdate",nil)
										else
											self:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,x1 +speed*x2)
											self:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,x1-30 +speed*x2)
											x2 = x2 + 1
										end
									end
								)
								Ordre["ordre"][j]:SetScript("OnUpdate",function(self)
										if speed*x3 >= 30 then
											self:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,x1)
											self:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,x1-30)
											self:SetScript("OnUpdate",nil)
										else
											self:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,x1+30 -speed*x3)
											self:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,x1 -speed*x3)
											x3 = x3 + 1
										end
									end
								)
								Oo["Ord"][k],Oo["Ord"][k+1] = Oo["Ord"][k+1],Oo["Ord"][k]
								Sh_DB[PROFILE]["Oo"]["Ord"] = Oo["Ord"]
								Sh_refresh()
								break
							end
						end
					end
				end
			)
		Ordre["down"][j]:SetWidth(20)
		Ordre["down"][j]:Show()
		
		
		Ordre["toggle"][j] = Sh_opt_createCheckbox("OrdreToggleCb" .. j, "", Ordre["ordre"][j])
		Ordre["toggle"][j]:SetPoint("RIGHT",Ordre["ordre"][j],"RIGHT",-45,0)
		Ordre["toggle"][j]:SetChecked(Oo["Ord:toggle"][j])
		Ordre["toggle"][j]:SetScript("OnClick",function(self)
					Oo["Ord:toggle"][j] = Ordre["toggle"][j]:GetChecked()
					Sh_OnEvent("player")
					Sh_OnEvent("target")
				end
			)
		Ordre["toggle"][j]:Show()
		
		
		Ordre["icon_toggle"][j] = Sh_opt_createCheckbox("OrdreIconCb" .. j, "", Ordre["ordre"][j])
		Ordre["icon_toggle"][j]:SetPoint("RIGHT",Ordre["ordre"][j],"RIGHT",0,0)
		Ordre["icon_toggle"][j]:SetChecked(Oo["Ord:icon"][j])
		Ordre["icon_toggle"][j]:SetScript("OnClick",function()
					Oo["Ord:icon"][j] = Ordre["icon_toggle"][j]:GetChecked()
					Sh_OnEvent("player")
					Sh_OnEvent("target")
				end
			)
		Ordre["icon_toggle"][j]:Show()
	end
	local ordre_toggle_text = Sh_opt_texte(L["Activer"], Shield_ordre)
	ordre_toggle_text:SetPoint("RIGHT", Shield_ordre,"TOPRIGHT", -45, -30)
	
	local ordre_icon_toggle_text = Sh_opt_texte(L["Icone"], Shield_ordre)
	ordre_icon_toggle_text:SetPoint("RIGHT", Shield_ordre,"TOPRIGHT", -7, -30)
	
   
   ------------------------------------------------------------------------------------
   ------------------------------------------
   
   	local Shield_cooldown = CreateFrame("frame", "Shield_cooldown", ShieldHealth.childpanel_divers)
	Shield_cooldown:SetFrameStrata("HIGH")
	Shield_cooldown:SetBackdrop({
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 11,
	})
	Shield_cooldown:SetBackdropColor(1,0,0,0)
	Shield_cooldown:SetPoint("TOPLEFT",ShieldHealth.childpanel_divers,"TOP",0,-5)
	Shield_cooldown:SetPoint("BOTTOMRIGHT",ShieldHealth.childpanel_divers,"RIGHT",-5,-25)
	Shield_cooldown:Show()
	local text_Shield_cooldown = Shield_cooldown:CreateFontString("cooldown","MEDIUM","GameFontNormalLarge")
	text_Shield_cooldown:SetText(L["Cooldown"])
	text_Shield_cooldown:SetTextColor(0.8,0.8,0,1)
	text_Shield_cooldown:SetPoint("TOPLEFT", Shield_cooldown,"TOPLEFT", 10, -5)
	text_Shield_cooldown:Show()
	
	
	
-- Activation globale			----------
-- CB
	Cb[60] = Sh_opt_createCheckbox("Cb" .. 60, L["cooldown_enable"], Shield_cooldown)
	Cb[60]:SetPoint("TOPLEFT", Shield_cooldown,"TOPLEFT", 130, -1)
	Cb[60]:SetChecked(Oo["cooldown"]["enable"])
	Cb[60].refresh = function() Cb[60]:SetChecked(Oo["cooldown"]["enable"]) end
	Cb[60]:SetScript("OnClick",function() Oo["cooldown"]["enable"] = Cb[60]:GetChecked() Sh_refresh() end)
	Cb[60]:Show()
	Sh_Tooltip(Cb[60],L["tooltip_cooldown_cb_60"])
	
-- Modules			----------
-- Frame	
	
   	local Shield_cooldown_modules = CreateFrame("frame", "Shield_cooldown_modules", Shield_cooldown)
	Shield_cooldown_modules:SetFrameStrata("HIGH")
	Shield_cooldown_modules:SetBackdrop({
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        edgeSize = 11,
	})
	Shield_cooldown_modules:SetBackdropColor(1,0,0,0)
	Shield_cooldown_modules:SetPoint("TOPLEFT",Shield_cooldown,"TOPLEFT",5,-30*1)
	Shield_cooldown_modules:SetPoint("BOTTOMRIGHT",Shield_cooldown,"TOPRIGHT",-5,-30*3)
	Shield_cooldown_modules:Show()
	
	
-- Modules			----------
-- CB	
	
	Cb[65] = Sh_opt_createCheckbox("Cb" .. 65, L["cooldown_module_rapture"], Shield_cooldown_modules)
	Cb[65]:SetPoint("TOPLEFT", Shield_cooldown_modules,"TOPLEFT", 5, -5)
	Cb[65]:SetChecked(Oo["cooldown"]["enable"])
	Cb[65].refresh = function() Cb[65]:SetChecked(Oo["cooldown"]["modules"]["rapture"]) end
	Cb[65]:SetScript("OnClick",function() Oo["cooldown"]["modules"]["rapture"] = Cb[65]:GetChecked() Sh_refresh() end)
	Cb[65]:Show()
	Sh_Tooltip(Cb[65],L["tooltip_cooldown_cb_65"])




-- Hauteur			----------
-- SLIDER
	Sh_opt_createSlider(60, "Slider" .. 60, Shield_cooldown, Oo["cooldown"]["hauteur"], 1, 100, "hauteur", true, "cooldown")
	Slider[60]:SetPoint("RIGHT", Shield_cooldown,"TOPRIGHT",-10,-30*4)
	Sh_Tooltip(Slider[60],L["tooltip_cooldown_slider_60"])

	local text_Cooldown_panel1 = Sh_opt_texte(L["Hauteur_globale"], Shield_cooldown)
	text_Cooldown_panel1:SetPoint("LEFT", Shield_cooldown,"TOPLEFT", 5, -30*4)

	
	
-- Largeur			----------
-- SLIDER	
	Sh_opt_createSlider(61, "Slider" .. 61, Shield_cooldown, Oo["cooldown"]["largeur"], 1, 100, "largeur", true, "cooldown")
	Slider[61]:SetPoint("RIGHT", Shield_cooldown,"TOPRIGHT",-10,-30*5)
	Sh_Tooltip(Slider[61],L["tooltip_cooldown_slider_61"])

	local text_Cooldown_panel2 = Sh_opt_texte(L["Largeur_globale"], Shield_cooldown)
	text_Cooldown_panel2:SetPoint("LEFT", Shield_cooldown,"TOPLEFT", 5, -30*5)
	
	
		--[[
-- Texture			----------
-- Editbox
	
	Sh_btn[60] = CreateFrame("Button", "Button" .. 60, Shield_cooldown, "UIPanelButtonTemplate")
	Sh_btn[60]:SetText("R")
	Sh_btn[60]:SetWidth (175)
	Sh_btn[60]:SetScript("OnClick",function()
		
	end
	)
	Sh_btn[60]:SetPoint("RIGHT",Shield_cooldown,"TOPRIGHT",-5, -30*3)
	Sh_Tooltip(Sh_btn[60],L["tooltip_DDM2"])
	
	]]
	
	
	
-- Bordure toggle			----------
-- CB
	Cb[61] = Sh_opt_createCheckbox("Cb" .. 61, L["cooldown_border"], Shield_cooldown)
	Cb[61]:SetPoint("LEFT",Shield_cooldown,"TOPLEFT",5,-30*6)
	Cb[61]:SetChecked(Oo["cooldown"]["border"])
	Cb[61].refresh = function() Cb[61]:SetChecked(Oo["cooldown"]["border"]) end
	Cb[61]:SetScript("OnClick",function() Oo["cooldown"]["border"] = Cb[61]:GetChecked() Sh_refresh() end)
	Cb[61]:Show()
	Sh_Tooltip(Cb[61],L["tooltip_cooldown_cb_61"])
	
	
	
-- Border width			----------
-- SLIDER
	Sh_opt_createSlider(62, "Slider" .. 62, Shield_cooldown, Oo["cooldown"]["border:width"], 1, 25, "border:width", true, "cooldown")
	Slider[62]:SetPoint("RIGHT", Shield_cooldown,"TOPRIGHT",-10,-30*7)
	Sh_Tooltip(Slider[62],L["tooltip_cooldown_slider_62"])

	local text_Cooldown_panel3 = Sh_opt_texte(L["Taille_bordure"], Shield_cooldown)
	text_Cooldown_panel3:SetPoint("LEFT", Shield_cooldown,"TOPLEFT", 5, -30*7)
	
	
-- Cooldown inset			--------
-- SLIDER

	Sh_opt_createSlider(63, "Slider" .. 63, Shield_cooldown, Oo["cooldown"]["inset"], 0, 100, "inset", true, "cooldown")
	Slider[63]:SetPoint("RIGHT", Shield_cooldown,"TOPRIGHT",-10,-30*8)
	Sh_Tooltip(Slider[63],L["tooltip_cooldown_slider_63"])

	local text_Cooldown_panel3 = Sh_opt_texte(L["cooldown_inset"], Shield_cooldown)
	text_Cooldown_panel3:SetPoint("LEFT", Shield_cooldown,"TOPLEFT", 5, -30*8)
	
	
-- Bordure toggle			----------
-- CB	
	Cb[62] = Sh_opt_createCheckbox("Cb" .. 62, L["cooldown_anchor"], Shield_cooldown)
	Cb[62]:SetPoint("LEFT",Shield_cooldown,"TOPLEFT",5,-30*9)
	Cb[62]:SetChecked(Oo["cooldown"]["anchored"])
	Cb[62].refresh = function() Cb[62]:SetChecked(Oo["cooldown"]["anchored"]) end
	Cb[62]:SetScript("OnClick",function() Oo["cooldown"]["anchored"] = Cb[62]:GetChecked() Sh_refresh() end)
	Cb[62]:Show()
	Sh_Tooltip(Cb[62],L["tooltip_cooldown_cb_62"])
	
-- Cooldown inset			--------
-- SLIDER

	Sh_opt_createSlider(64, "Slider" .. 64, Shield_cooldown, Oo["cooldown"]["anchor"], -115, 85 , "anchor", false, "cooldown")
	Slider[64]:SetPoint("RIGHT", Shield_cooldown,"TOPRIGHT",-10,-30*9)
	Sh_Tooltip(Slider[64],L["tooltip_cooldown_slider_64"])


   ---------------------
   
   
  
	
	
	Sh_refresh()
	Sh_refresh_options()
end
------------------------------------------







function Sh_test()


	slot[30] = {}
	if TESTMODE then

		--- Target
		ftar:Show()
		for i=1,getnB do
			Bvtar[i] = 0
			Bttar[i] = 0
			Bmttar[i] = 0
			slot[30][i] = 30
		end
		Bvtar[3] = 60
		Bttar[3] = 45
		Bmttar[3] = 60
		slot[30][3] = 75
		
		Bvtar[4] = 25
		Bttar[4] = 8
		Bmttar[4] = 8
		slot[30][4] =  25 
		
		Sh_tar_update(75,100,30)
		
		ft1tar:SetText(L["target"])

		
		for i=1,getnB do
			Bvtar[i] = 0
			Bttar[i] = 0
			Bmttar[i] = 0
		end

		
		--- Player
		f:Show()
		for i=1,getnB do
			Bv[i] = 0
			Bmv[i] = 0
			Bt[i] = 0
			Bmt[i] = 0
		end
		
		Bv[8] = 35
		Bmv[8] = 40
		Bt[8] = 12
		Bmt[8] = 15
		
		Bv[9] = 30
		Bmv[9] = 40
		Bt[9] = 15
		Bmt[9] = 15
		
		Bv[10] = 15
		Bmv[10] = 15
		Bt[10] = 15
		Bmt[10] = 15
		Sh_update("player")
		i1CD:SetCooldown(GetTime()-4, Bmt[8])
		i2CD:SetCooldown(GetTime(), Bmt[9])
		
		ft1:SetText(L["player"])
		
		for i=1,getnB do
			Bv[i] = 0
			Bmv[i] = 0
			Bt[i] = 0
			Bmt[i] = 0
		end
		
	
		
		
		-- Cooldown
		if Oo["cooldown"]["enable"] then
			cooldownFRAME:Show()
			cooldownCD:SetCooldown(GetTime(),12)
		else
			cooldownFRAME:Hide()
		end
		
	else
		cooldownFRAME:Hide()
	end
end

function Sh_reset()
	for j=1,getnB do
	Ordre["ordre"][j]:SetPoint("TOPLEFT",Shield_ordre,"TOPLEFT",5,-10-(30*Oo["Ord"][j]))
	Ordre["ordre"][j]:SetPoint("BOTTOMRIGHT",Shield_ordre,"TOPRIGHT",-5,-10-(30*Oo["Ord"][j])-30)
	end

	Sh_options()
	Sh_DB[PROFILE]["O"] = O
	Sh_DB[PROFILE]["Ot"] = Ot
	Sh_DB[PROFILE]["Oo"] = Oo
	Sh_refresh_options()
	Sh_refresh()
	Sh_print(L["reset3"] .. PROFILE .. L["reset4"])
end

function Sh_reset_addon()
	Sh_DB = nil
	ReloadUI()
end


-----------------------------
function Sh_deep (t, done)
-- Copie de tables
-- Source : http://www.gammon.com.au/forum/?id=8042
-----------------------------
  assert (type (t) == "table", "You must specify a table to copy")

  local result = {}
  done = done or {}

  assert (not done [t], "table is defined within itself")

  done [t] = true -- we will disallow recopying table t

  for k, v in pairs (t) do
    if type (v) == "table"  then
      result [k] = Sh_deep (v, done)
    else
      result [k] = v
    end -- if table or not
  end -- for each table element

  done [t] = nil -- table t can be copied again

  -- copy the metatable
  return setmetatable (result, getmetatable (t))

end -- function deep


function Sh_Tooltip(var,strings)
	if strings ~= nil and var ~= nil then
	
	local function cut(s)
		local strings = {}
		local sub
		local sub2 = s
		local j = 1
		while string.len(sub2) > 46 do
			sub = string.sub(sub2,1,50)
			j = 1
			for i=1,20 do
				if string.sub(sub,45-i,45-i) == " " then
					table.insert(strings,string.sub(sub2,1,44-i))
					j = i
					break
				end
			end
			sub2 = string.sub(sub2,46-j)
		end
		
		table.insert(strings,sub2)
		return strings
	end	
	
		var:SetScript("OnEnter",function(self)
				GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
				for k,v in pairs(strings) do
					if k == 1 then
						GameTooltip:SetText(v)
					else
						if string.len(v) > 50 then
							local sub = cut(v)
							for c,b in pairs(sub) do
								GameTooltip:AddLine(b,1,1,1)
							end
						else
							GameTooltip:AddLine(v, 1, 1, 1)
						end
					end
				end
				GameTooltip:Show()
			end
		)
		var:SetScript("OnLeave",function()
				GameTooltip:Hide()
			end
		)
	end
end

function Sh_print(text)
	DEFAULT_CHAT_FRAME:AddMessage("|cff00ffff[ShieldHealth] |r" .. text)
end

function Sh_error(text)
	ERRORCOUNT = ERRORCOUNT + 1
	if ERRORCOUNT == 10 then
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ffff[ShieldHealth] |r|cffdd1111ERROR : |rToo many error messages to display. Please help me to correct this bug by opening a ticket at http://wow.curseforge.com/addons/shieldhealth/tickets/")
	end
	if ERRORCOUNT <= 10 then
		DEFAULT_CHAT_FRAME:AddMessage("|cff00ffff[ShieldHealth] |r|cffdd1111ERROR : |r" .. text)
	end
end

function Sh_debug(text)
	if DEBUG then
		_G["ChatFrame7"]:AddMessage(tostring(text))
	end
end

local print=function(...)
	if DEBUG then
		print(...)
	end
end

function Sh_getpoint(frame,anchor)
	num = frame:GetNumPoints()
	for i=1,num do
		local point = select(1,frame:GetPoint(i))
		if point == anchor then
			return frame:GetPoint(i)
		end
	end
	Sh_error("GetPoint error on frame |cff99ffff" .. frame:GetName() .. "|r with anchor |cff00ee33\"" .. anchor .. "\"|r.")
	return frame:GetPoint()
end





Sh_OnLoad()
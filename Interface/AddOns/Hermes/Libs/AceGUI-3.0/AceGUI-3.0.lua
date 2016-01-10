--- **AceGUI-3.0** provides access to numerous widgets which can be used to create GUIs.
-- AceGUI is used by AceConfigDialog to create the option GUIs, but you can use it by itself
-- to create any custom GUI. There are more extensive examples in the test suite in the Ace3 
-- stand-alone distribution.
--
-- **Note**: When using AceGUI-3.0 directly, please do not modify the frames of the widgets directly,
-- as any "unknown" change to the widgets will cause addons that get your widget out of the widget pool
-- to misbehave. If you think some part of a widget should be modifiable, please open a ticket, and we"ll
-- implement a proper API to modify it.
-- @usage
-- local AceGUI = LibStub("AceGUI-3.0")
-- -- Create a container frame
-- local f = AceGUI:Create("Frame")
-- f:SetCallback("OnClose",function(widget) AceGUI:Release(widget) end)
-- f:SetTitle("AceGUI-3.0 Example")
-- f:SetStatusText("Status Bar")
-- f:SetLayout("Flow")
-- -- Create a button
-- local btn = AceGUI:Create("Button")
-- btn:SetWidth(170)
-- btn:SetText("Button !")
-- btn:SetCallback("OnClick", function() print("Click!") end)
-- -- Add the button to the container
-- f:AddChild(btn)
-- @class file
-- @name AceGUI-3.0
-- @release $Id: AceGUI-3.0.lua 1102 2013-10-25 14:15:23Z nevcairiel $
local ACEGUI_MAJOR, ACEGUI_MINOR = "AceGUI-3.0", 34
local AceGUI, oldminor = LibStub:NewLibrary(ACEGUI_MAJOR, ACEGUI_MINOR)

if not AceGUI then return end -- No upgrade needed

-- Lua APIs
local tconcat, tremove, tinsert = table.concat, table.remove, table.insert
local select, pairs, next, type = select, pairs, next, type
local error, assert, loadstring = error, assert, loadstring
local setmetatable, rawget, rawset = setmetatable, rawget, rawset
local math_max = math.max

-- WoW APIs
local UIParent = UIParent

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: geterrorhandler, LibStub

--local con = LibStub("AceConsole-3.0",true)

AceGUI.WidgetRegistry = AceGUI.WidgetRegistry or {}
AceGUI.LayoutRegistry = AceGUI.LayoutRegistry or {}
AceGUI.WidgetBase = AceGUI.WidgetBase or {}
AceGUI.WidgetContainerBase = AceGUI.WidgetContainerBase or {}
AceGUI.WidgetVersions = AceGUI.WidgetVersions or {}
 
-- local upvalues
local WidgetRegistry = AceGUI.WidgetRegistry
local LayoutRegistry = AceGUI.LayoutRegistry
local WidgetVersions = AceGUI.WidgetVersions

--[[
	 xpcall safecall implementation
]]
local xpcall = xpcall

local function errorhandler(err)
	return geterrorhandler()(err)
end

local function CreateDispatcher(argCount)
	local code = [[
		local xpcall, eh = ...
		local method, ARGS
		local function call() return method(ARGS) end
	
		local function dispatch(func, ...)
			method = func
			if not method then return end
			ARGS = ...
			return xpcall(call, eh)
		end
	
		return dispatch
	]]
	
	local ARGS = {}
	for i = 1, argCount do ARGS[i] = "arg"..i end
	code = code:gsub("ARGS", tconcat(ARGS, ", "))
	return assert(loadstring(code, "safecall Dispatcher["..argCount.."]"))(xpcall, errorhandler)
end

local Dispatchers = setmetatable({}, {__index=function(self, argCount)
	local dispatcher = CreateDispatcher(argCount)
	rawset(self, argCount, dispatcher)
	return dispatcher
end})
Dispatchers[0] = function(func)
	return xpcall(func, errorhandler)
end
 
local function safecall(func, ...)
	return Dispatchers[select("#", ...)](func, ...)
end

-- Recycling functions
local newWidget, delWidget
do
	-- Version Upgrade in Minor 29
	-- Internal Storage of the objects changed, from an array table
	-- to a hash table, and additionally we introduced versioning on
	-- the widgets which would discard all widgets from a pre-29 version
	-- anyway, so we just clear the storage now, and don't try to 
	-- convert the storage tables to the new format.
	-- This should generally not cause *many* widgets to end up in trash,
	-- since once dialogs are opened, all addons should be loaded already
	-- and AceGUI should be on the latest version available on the users
	-- setup.
	-- -- nevcairiel - Nov 2nd, 2009
	if oldminor and oldminor < 29 and AceGUI.objPools then
		AceGUI.objPools = nil
	end
	
	AceGUI.objPools = AceGUI.objPools or {}
	local objPools = AceGUI.objPools
	--Returns a new instance, if none are available either returns a new table or calls the given contructor
	function newWidget(type)
		if not WidgetRegistry[type] then
			error("Attempt to instantiate unknown widget type", 2)
		end
		
		if not objPools[type] then
			objPools[type] = {}
		end
		
		local newObj = next(objPools[type])
		if not newObj then
			newObj = WidgetRegistry[type]()
			newObj.AceGUIWidgetVersion = WidgetVersions[type]
		else
			objPools[type][newObj] = nil
			-- if the widget is older then the latest, don't even try to reuse it
			-- just forget about it, and grab a new one.
			if not newObj.AceGUIWidgetVersion or newObj.AceGUIWidgetVersion < WidgetVersions[type] then
				return newWidget(type)
			end
		end
		return newObj
	end
	-- Releases an instance to the Pool
	function delWidget(obj,type)
		if not objPools[type] then
			objPools[type] = {}
		end
		if objPools[type][obj] then
			error("Attempt to Release Widget that is already released", 2)
		end
		objPools[type][obj] = true
	end
end


-------------------
-- API Functions --
-------------------

-- Gets a widget Object

--- Create a new Widget of the given type.
-- This function will instantiate a new widget (or use one from the widget pool), and call the
-- OnAcquire function on it, before returning.
-- @param type The type of the widget.
-- @return The newly created widget.
function AceGUI:Create(type)
	if WidgetRegistry[type] then
		local widget = newWidget(type)

		if rawget(widget, "Acquire") then
			widget.OnAcquire = widget.Acquire
			widget.Acquire = nil
		elseif rawget(widget, "Aquire") then
			widget.OnAcquire = widget.Aquire
			widget.Aquire = nil
		end
		
		if rawget(widget, "Release") then
			widget.OnRelease = rawget(widget, "Release") 
			widget.Release = nil
		end
		
		if widget.OnAcquire then
			widget:OnAcquire()
		else
			error(("Widget type %s doesn't supply an OnAcquire Function"):format(type))
		end
		-- Set the default Layout ("List")
		safecall(widget.SetLayout, widget, "List")
		safecall(widget.ResumeLayout, widget)
		return widget
	end
end

--- Releases a widget Object.
-- This function calls OnRelease on the widget and places it back in the widget pool.
-- Any data on the widget is being erased, and the widget will be hidden.\\
-- If this widget is a Container-Widget, all of its Child-Widgets will be releases as well.
-- @param widget The widget to release
function AceGUI:Release(widget)
	safecall(widget.PauseLayout, widget)
	widget:Fire("OnRelease")
	safecall(widget.ReleaseChildren, widget)

	if widget.OnRelease then
		widget:OnRelease()
--	else
--		error(("Widget type %s doesn't supply an OnRelease Function"):format(widget.type))
	end
	for k in pairs(widget.userdata) do
		widget.userdata[k] = nil
	end
	for k in pairs(widget.events) do
		widget.events[k] = nil
	end
	widget.width = nil
	widget.relWidth = nil
	widget.height = nil
	widget.relHeight = nil
	widget.noAutoHeight = nil
	widget.frame:ClearAllPoints()
	widget.frame:Hide()
	widget.frame:SetParent(UIParent)
	widget.frame.width = nil
	widget.frame.height = nil
	if widget.content then
		widget.content.width = nil
		widget.content.height = nil
	end
	delWidget(widget, widget.type)
end

-----------
-- Focus --
-----------


--- Called when a widget has taken focus.
-- e.g. Dropdowns opening, Editboxes gaining kb focus
-- @param widget The widget that should be focused
function AceGUI:SetFocus(widget)
	if self.FocusedWidget and self.FocusedWidget ~= widget then
		safecall(self.FocusedWidget.ClearFocus, self.FocusedWidget)
	end
	self.FocusedWidget = widget
end


--- Called when something has happened that could cause widgets with focus to drop it
-- e.g. titlebar of a frame being clicked
function AceGUI:ClearFocus()
	if self.FocusedWidget then
		safecall(self.FocusedWidget.ClearFocus, self.FocusedWidget)
		self.FocusedWidget = nil
	end
end

-------------
-- Widgets --
-------------
--[[
	Widgets must provide the following functions
		OnAcquire() - Called when the object is acquired, should set everything to a default hidden state
		
	And the following members
		frame - the frame or derivitive object that will be treated as the widget for size and anchoring purposes
		type - the type of the object, same as the name given to :RegisterWidget()
		
	Widgets contain a table called userdata, this is a safe place to store data associated with the wigdet
	It will be cleared automatically when a widget is released
	Placing values directly into a widget object should be avoided
	
	If the Widget can act as a container for other Widgets the following
		content - frame or derivitive that children will be anchored to
		
	The Widget can supply the following Optional Members
		:OnRelease() - Called when the object is Released, should remove any additional anchors and clear any data
		:OnWidthSet(width) - Called when the width of the widget is changed
		:OnHeightSet(height) - Called when the height of the widget is changed
			Widgets should not use the OnSizeChanged events of thier frame or content members, use these methods instead
			AceGUI already sets a handler to the event
		:LayoutFinished(width, height) - called after a layout has finished, the width and height will be the width and height of the
			area used for controls. These can be nil if the layout used the existing size to layout the controls.

]]

--------------------------
-- Widget Base Template --
--------------------------
do
	local WidgetBase = AceGUI.WidgetBase 
	
	WidgetBase.SetParent = function(self, parent)
		local frame = self.frame
		frame:SetParent(nil)
		frame:SetParent(parent.content)
		self.parent = parent
	end
	
	WidgetBase.SetCallback = function(self, name, func)
		if type(func) == "function" then
			self.events[name] = func
		end
	end
	
	WidgetBase.Fire = function(self, name, ...)
		if self.events[name] then
			local success, ret = safecall(self.events[name], self, name, ...)
			if success then
				return ret
			end
		end
	end
	
	WidgetBase.SetWidth = function(self, width)
		self.frame:SetWidth(width)
		self.frame.width = width
		if self.OnWidthSet then
			self:OnWidthSet(width)
		end
	end
	
	WidgetBase.SetRelativeWidth = function(self, width)
		if width <= 0 or width > 1 then
			error(":SetRelativeWidth(width): Invalid relative width.", 2)
		end
		self.relWidth = width
		self.width = "relative"
	end
	
	WidgetBase.SetHeight = function(self, height)
		self.frame:SetHeight(height)
		self.frame.height = height
		if self.OnHeightSet then
			self:OnHeightSet(height)
		end
	end
	
	--[[ WidgetBase.SetRelativeHeight = function(self, height)
		if height <= 0 or height > 1 then
			error(":SetRelativeHeight(height): Invalid relative height.", 2)
		end
		self.relHeight = height
		self.height = "relative"
	end ]]

	WidgetBase.IsVisible = function(self)
		return self.frame:IsVisible()
	end
	
	WidgetBase.IsShown= function(self)
		return self.frame:IsShown()
	end
		
	WidgetBase.Release = function(self)
		AceGUI:Release(self)
	end
	
	WidgetBase.SetPoint = function(self, ...)
		return self.frame:SetPoint(...)
	end
	
	WidgetBase.ClearAllPoints = function(self)
		return self.frame:ClearAllPoints()
	end
	
	WidgetBase.GetNumPoints = function(self)
		return self.frame:GetNumPoints()
	end
	
	WidgetBase.GetPoint = function(self, ...)
		return self.frame:GetPoint(...)
	end	
	
	WidgetBase.GetUserDataTable = function(self)
		return self.userdata
	end
	
	WidgetBase.SetUserData = function(self, key, value)
		self.userdata[key] = value
	end
	
	WidgetBase.GetUserData = function(self, key)
		return self.userdata[key]
	end
	
	WidgetBase.IsFullHeight = function(self)
		return self.height == "fill"
	end
	
	WidgetBase.SetFullHeight = function(self, isFull)
		if isFull then
			self.height = "fill"
		else
			self.height = nil
		end
	end
	
	WidgetBase.IsFullWidth = function(self)
		return self.width == "fill"
	end
		
	WidgetBase.SetFullWidth = function(self, isFull)
		if isFull then
			self.width = "fill"
		else
			self.width = nil
		end
	end
	
--	local function LayoutOnUpdate(this)
--		this:SetScript("OnUpdate",nil)
--		this.obj:PerformLayout()
--	end
	
	local WidgetContainerBase = AceGUI.WidgetContainerBase
		
	WidgetContainerBase.PauseLayout = function(self)
		self.LayoutPaused = true
	end
	
	WidgetContainerBase.ResumeLayout = function(self)
		self.LayoutPaused = nil
	end
	
	WidgetContainerBase.PerformLayout = function(self)
		if self.LayoutPaused then
			return
		end
		safecall(self.LayoutFunc, self.content, self.children)
	end
	
	--call this function to layout, makes sure layed out objects get a frame to get sizes etc
	WidgetContainerBase.DoLayout = function(self)
		self:PerformLayout()
--		if not self.parent then
--			self.frame:SetScript("OnUpdate", LayoutOnUpdate)
--		end
	end
	
	WidgetContainerBase.AddChild = function(self, child, beforeWidget)
		if beforeWidget then
			local siblingIndex = 1
			for _, widget in pairs(self.children) do
				if widget == beforeWidget then
					break
				end
				siblingIndex = siblingIndex + 1 
			end
			tinsert(self.children, siblingIndex, child)
		else
			tinsert(self.children, child)
		end
		child:SetParent(self)
		child.frame:Show()
		self:DoLayout()
	end
	
	WidgetContainerBase.AddChildren = function(self, ...)
		for i = 1, select("#", ...) do
			local child = select(i, ...)
			tinsert(self.children, child)
			child:SetParent(self)
			child.frame:Show()
		end
		self:DoLayout()
	end
	
	WidgetContainerBase.ReleaseChildren = function(self)
		local children = self.children
		for i = 1,#children do
			AceGUI:Release(children[i])
			children[i] = nil
		end
	end
	
	WidgetContainerBase.SetLayout = function(self, Layout)
		self.LayoutFunc = AceGUI:GetLayout(Layout)
	end

	WidgetContainerBase.SetAutoAdjustHeight = function(self, adjust)
		if adjust then
			self.noAutoHeight = nil
		else
			self.noAutoHeight = true
		end
	end

	local function FrameResize(this)
		local self = this.obj
		if this:GetWidth() and this:GetHeight() then
			if self.OnWidthSet then
				self:OnWidthSet(this:GetWidth())
			end
			if self.OnHeightSet then
				self:OnHeightSet(this:GetHeight())
			end
		end
	end
	
	local function ContentResize(this)
		if this:GetWidth() and this:GetHeight() then
			this.width = this:GetWidth()
			this.height = this:GetHeight()
			this.obj:DoLayout()
		end
	end

	setmetatable(WidgetContainerBase, {__index=WidgetBase})

	--One of these function should be called on each Widget Instance as part of its creation process
	
	--- Register a widget-class as a container for newly created widgets.
	-- @param widget The widget class
	function AceGUI:RegisterAsContainer(widget)
		widget.children = {}
		widget.userdata = {}
		widget.events = {}
		widget.base = WidgetContainerBase
		widget.content.obj = widget
		widget.frame.obj = widget
		widget.content:SetScript("OnSizeChanged", ContentResize)
		widget.frame:SetScript("OnSizeChanged", FrameResize)
		setmetatable(widget, {__index = WidgetContainerBase})
		widget:SetLayout("List")
		return widget
	end
	
	--- Register a widget-class as a widget.
	-- @param widget The widget class
	function AceGUI:RegisterAsWidget(widget)
		widget.userdata = {}
		widget.events = {}
		widget.base = WidgetBase
		widget.frame.obj = widget
		widget.frame:SetScript("OnSizeChanged", FrameResize)
		setmetatable(widget, {__index = WidgetBase})
		return widget
	end
end




------------------
-- Widget API   --
------------------

--- Registers a widget Constructor, this function returns a new instance of the Widget
-- @param Name The name of the widget
-- @param Constructor The widget constructor function
-- @param Version The version of the_^]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhğp`d¡    Pd‰%    ƒì<‹E‹0+ÑSVW3öVP»   èëù; ‹ø‰}ä‰uü‰uğ9wLÿ   ‰uìd$ ‹wPuì‹À Ñ‹j Pèºù; ‰EèÆEü‹¸   …Éx	;H Œ›   ‹j MØQU¸RÇEØ)   ‰EÜè¥z9 ‹øÆEü‹Ej MĞQUÄRÇEĞ(   ‰EÔèƒz9 ƒÄ‹ØÆEü‹Eè‹H Q‹Ïèle ‹–¸   P‹EğRP‹ËèYe Ph ƒj jjèØe ƒÄ$ÆEüMÄèI"e ÆEüM¸è="e ‹}ä‹Eè3ÛÆEü MàQ‹À Ñ‰EàèOj; ‹EğEìÀ   @‰Eğ;GLŒÿÿÿÇEüÿÿÿÿ‹0+ÑUàR‰}àèj; ‹Mô_^‹Ã[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhq`d¡    Pd‰%    ƒì,SVWh¤ƒ3ÛSjjè!e ‹=Ä+Õ‹d	  ‹	ƒÄ¸ÿÿ  Uğf‰EìREìP3ö‰]ğè…ûÿÿ…À„§   MÔèe ‰]üMÈQ‹MğƒÁè#A ÆEüPMÔèö"e ˆ]üMÈè;!e MàèÓe ÆEüMÔèe PVUàhœƒRèW!e ƒÄMàèìe PSjjèe ƒÄFˆ]üMàèò e ÇEüÿÿÿÿMÔèã e ‹—d	  EğPMìQ‹
èŞúÿÿ…À…Yÿÿÿ‹Mô_^[d‰    ‹å]ÃÌÌÌÌÌU‹ìd¡    jÿhAq`Pd‰%    ƒìV‹ñƒ¾   u$ƒ¾   t	è+ûÿÿ…ÀuƒÈÿ^‹Môd‰    ‹å]Ã·†  S·ØW‹ûiÿ¬   ¾  ‰Eğf‹Gh¬   W‰}ìf‰†  èïœd ƒÄ‰}èƒÉÿ‰Mü·†    ÁàÃ‰Q;Áuf–  ·  ÁáË‰f–  –  ·†  ºÿÿ  f;Âtf;Eğsf‹Eğf‰†  ‹‹Mô_[^d‰    ‹å]ÃÌU‹ì‹†d  ì(  SWƒÏÿ3Û…Àtƒøud‹†h  j j PèqÔüÿƒÄƒøÿ„¤   ‹Ä+Õ‹‰8	  …É„   Pè;ÑÎÿ…À„‚   ÷†d     tö€  t	ƒÈÿ_[‹å]Ã‹˜x  ë\ƒøu	‹h  Qëƒøu+‹–h  RènÁ÷ÿƒÄ…Àt6‹€Œ  Pè»h÷ÿƒÄ…Àt#‹X ëƒøu‹h  QèşÀ ƒÄ…Àt‹˜¨#  VèõÿÿƒÄ…Àu†‹F0ƒø‡[  ÿ$… UÅ 3ÿ9}t¿   ‹V8Rè|F ƒÄ…ÀuƒÏ‹F8ƒøÿt$‹M‹UóEjÿSWQRQó$PèŸıÿƒÄ‹øë‹~@Wè=êÎÿƒÄ…ÀuƒÏÿ‹†h  ‹l  ‹UPQRWè;7ıÿƒÄ‹Ç_[‹å]Ã‹E‹N8PQDÿÿÿè™Ïÿ‹URlÿÿÿè>¶òÿƒ¾x   ‹†l  ‰E˜‰]œtó†|  óE DÿÿÿQè€2øÿ‹øƒÄƒÿÿ„ˆ  Wèlg÷ÿ‹U‰Eü‹PèöÿÿƒÄ„À„i  ‹ø,®Q  SÿŒˆ{ƒÄ…À„J  j@U´SRèX“»ÿ‹h  ƒÄE´PQ‹MühôXàÇEô    è6Ê÷ÿ‹Ç_[‹å]Ã‹U‹P3ÿè±õÿÿƒÄ„Àt ‹h  WWQè,ÒüÿPè&ÑÓÿƒÄ…Àt¿   ‹U‹F8SWRPj èy‚ ‹M‹øQWèıq ƒÄ‹Ç_[‹å]Ã‹¾d  Áï	ƒçƒ~<EÇEüÿÿÿÿu‹V@‰Uü‹†d  P3Éè5õÿÿƒÄ„Àt"QQ‹h  Qè°ÑüÿPè:ÇÒÿ‹ˆ(  ÑéƒÄƒá‹U‹Eüóà=“ƒÂ‰UØUÔ‰EÜ‹F8‰Mä‹NRóEìó†   PÇEè    ‰]Ô‰}àóEğ‰Môèpëòÿ‹øWèx¥ÓÿƒÄ…À„  ‹MQ‹ÈèbÅòÿ‹Ç_[‹å]Ã‹–d  RèôÿÿƒÄ„À„Ë   ‹†h  j j PèÑüÿPèíçÎÿƒÄ‰Eü…À„§   ‹ˆˆ   QÇEøÿÿÿÿèlƒA ƒÄ…Àt‹Uü‹‚ˆ   ë[‹Mü‹‘ˆ   Rè+¨A ƒÄ…Àt‹Eü‹ˆˆ   Qè%¤H ë1‹Uü‹‚ˆ   PèDçÎÿƒÄ…Àt!Q‹ÌÇëôÿÿ‹Èèm^C ƒøÿtPèÂ¥H ƒÄ‰Eø‹MøQèçÎÿƒÄ…Àt‹UøRèóÎÓÿƒÄ…À„  ‹E‹N8SPQè
¬ ‹U‹øRWè¨ ƒÄ‹Ç_[‹å]ÃWÀ‹Ej Q‹N8ó$SPQèú ‹øWèâ‚éÿƒÄ…À„½   ‹UR‹ÈèL ‹Ç_[‹å]Ã¡Ä+Õ‹ˆD	  ‹U‹F8SRP‰Müèè­ ‹øƒÿÿ„ƒ   ‹MQ‹MüWè ª ‹Ç_[‹å]Ã‹–h  Rè,ÅÒÿ¸˜   …ØşÿÿPèZÔS è…»Ôÿ‹V8j j Sj jjÿjÿWPØşÿÿQjÿRèT ‹ø‹EPWèˆ* ƒÄ@‹Ç_[‹å]Ãh¼ƒj jjèÍe ƒÄ‹Ç_[‹å]Ã‹ÿ¯PÅ 0QÅ RÅ ^RÅ UÅ -TÅ lTÅ UÅ UÅ ¨TÅ UÅ &SÅ UÅ ÌÌÌÌÌÌÌÌÌÌÌÌU‹ìóE‹UV‹u‹†Œ  ƒÉÿ…ÀGÈ‹EWPQQ‹Mó$QRèúÿÿ‹øƒÄƒÿÿ„  ƒÆVèÆ•? HƒÄƒø,‡í   ¶€ÔVÅ ÿ$…¨VÅ WèÄÒÿƒÄ_ˆh  ^]é$BøÿWè®ÎñÿƒÄ_ˆ   ^]éBøÿ‹Ä+Õ‹‰D	  Wèë¥ _HT^]éğAøÿ¡(iÎ‹ˆ  ·×iÒ  _Œ
Ü   ^]éÍAøÿWè¢ ƒÄ_Hh^]é¹AøÿWèƒôÿÿƒÄ_ˆœ   ^]é¢AøÿWèœb÷ÿƒÄ_ˆ”   ^]é‹Aøÿjh%  hpà{j è(¬d ƒÄjèîCe jh)  ëájh-  ëØ_^]ÃÅUÅ GVÅ óUÅ ÜUÅ ^VÅ ’VÅ uVÅ 3VÅ VÅ ›VÅ ¤VÅ  


































	ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E‹HIƒù,‡   ¶‰üXÅ Vÿ$ĞXÅ ‹PRèäÎÿ‹ğƒÄ…öt]j j VèbıÿƒÄ†\  …ÀtF‹0…öt@‹Ä+Õ‹‹‚d	  ‹v‹ƒùÿt$·Á;‚   siÀ¬   ‚  9u	PèvÿÿÿƒÄ…öuÀ^]Ã‹@Pèsa÷ÿ‹ğƒÄ…ötë‹Îè³ä÷ÿ†À  ë’‹HQè¢D÷ÿ‹ğƒÄ…ötÊVèÃ ƒÄ†X  élÿÿÿ‹P¡Ä+Õ‹ˆ,	  Rè¡Îæÿ…ÀtPè×l ƒÄ^]Ã‹HQèh ÓÿƒÄ…Àt‚j‹Èè¸¯òÿ^]Ã‹Ä+Õ‹@‹ŠD	  PèĞ£ …À„Yÿÿÿ‹È^]éŸ¢ ‹HQè&  ƒÄ…À„<ÿÿÿPè5¡ ƒÄ^]Ã‹PRè¶~éÿƒÄ…À„ÿÿÿj‹Èè’ ^]Ã‹@Pèæ¸ ƒÄ…À„üşÿÿƒÀ\éªşÿÿ‹HQè& ƒÄ…À„àşÿÿPèé& ƒÄ^]ÃI 2WÅ qXÅ +XÅ ëWÅ ¤WÅ ‘XÅ ÅWÅ QXÅ XÅ ­XÅ ¡WÅ  


































	ÌÌÌÌÌÌÌU‹ì‹EW‹8…ÿ„  V‹‹5Ä+Õ‹–d	  ‹‹ƒùÿ„ø   ·Á;‚   ƒé   iÀ¬   ‚  9…Õ   ‹Hƒù-u)‹@Pè>% ƒÄ…À„¹   ‹Ä+Õ‹Q8B‰`Z  é¤   ƒùu4‹@ƒøÿ„“   ‹8	  …É„…   PèiÇÎÿ…Àt{\  PèJÿÿÿƒÄëkƒùuf‹@Pè'_÷ÿ‹ğƒÄ…ötTÀ  Qè"ÿÿÿ‹¶T  ƒÄ…öt;ëI ‹‹vƒøÿt(‹Ä+Õ‹Š8	  …ÉtPè ÇÎÿ…Àt\  PèáşÿÿƒÄ…öuÊ…ÿ…äşÿÿ^_]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹ˆ    ƒùw~ÿ$[Å ‹€¨   ƒøÿt‹Ä+Õ‹‰8	  …Ét
PèÆÎÿ…Àu3ÀÃ\  Ã‹€¨   Pèd^÷ÿƒÄ…ÀtäÀ  Ã‹ˆ¨   Qè«¶ ƒÄ…ÀtËƒÀ\Ã‹¨   Rè„A÷ÿƒÄ…Àt´X  Ãjh<  hpà{j è¤§d ƒÄjèj?e ‹ÿ‚ZÅ °ZÅ °ZÅ ÉZÅ àZÅ ‚ZÅ U‹ì‹EW‹8…ÿ„¯   S‹]Vë¤$    ‹Ä+Õ‹‹‚d	  ‹‹ƒùÿt~·Á;‚   ssiÀ¬   ‚  9uc‹pƒşÿt[‹@HtƒèuPVè„]÷ÿƒÄ…ÀtCjS‹ÈèC‡÷ÿë7;'  u#‹Ä+Õ‹‰8	  …ÉtVèsÅÎÿ…Àtƒ¸¨   ujSVèÿÿƒÄ…ÿ…bÿÿÿ^[_]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìV‹u‹Nƒùÿ„‚   ‹VJ3ÀƒúC‡ä   ¶’T]Å ÿ$•$]Å Qè
ßÎÿƒÄ÷ØÀ@^]ÃQèÙ\÷ÿƒÄ÷ØÀ@^]Ã¡Ä+ÕQ‹ˆ,	  è=Êæÿ÷ØÀ@^]ÃQ‹Ä+Õ‹‰D	  è“Ÿ ÷ØÀ@^]Ãèòÿ…ÀuÇFÿÿÿÿ¸   ^]Ã‹VRèÚ›ÓÿƒÄ÷ØÀ@^]ÃQè	œ ƒÄ÷ØÀ@^]ÃQèhzéÿƒÄ÷ØÀ@^]ÃQè—?÷ÿƒÄ÷ØÀ@^]ÃQè–´ ƒÄ÷ØÀ@^]ÃQèÕ! ƒÄ÷ØÀ@^]Ãjh¿  hpà{j è—¥d ƒÄjè]=e 0\Å Â\Å k\Å R\Å A\Å ä\Å Ó\Å ±\Å …\Å õ\Å š\Å ]Å  	
ÌÌÌÌÌÌÌÌU‹ìjÿhaq`d¡    Pd‰%    ƒì¡Ä+Õ‹€d	  ‹èãğÿÿ‰EìƒøÿuÀ‹Môd‰    ‹å]Ã‹Ä+Õ‹‘d	  ‹
‹UV·ğiö¬   ±  W‹}GP‰VèZ? ‹O8‰F‰N‹d  ‰N‹W<‰V‹‡d  ‰†    ‹‡h  ƒÄƒ¾    ‰†¤   uPèh³÷ÿƒÄ…Àt‹ˆø   ‰¨   ë‰†¨   S^Ç¤  ÇEğ   j@WSè£†»ÿƒÄƒÇ`ƒÃDÿMğué‹ÆèÎûÿÿ‹ø‹O3Û3öè€ÃÉÿ‰Eğ;Ãt‰Eè‰]ü‰X‰XÇEüÿÿÿÿ‹ğ‹Eì‰ÿG‰^‰^‹O;Ë[t‰q‹W‰V‰w_^‹Môd‰    ‹å]Ã‹Mô‰7‰w_^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿh€q`Pd‰%    ƒìVW‹}‹Çè)ûÿÿ…Àt*‹…Òt‹9
„®   ‹R…Òuñh0ƒj jjènüd ƒÄè–”Ôÿ…Àt=EàPèùæÿÿƒÄÇEü    ‹Èè¸e Phƒj jjè7üd ƒÄÇEüÿÿÿÿMàè¥e ‹G‹O‹wÇGÿÿÿÿ‹Ä+Õ‰Mì‰Eğ‹‚d	  ‹Wè[èÿÿƒşÿ„ï   ‹EìHƒøC‡Ÿ   ¶ˆaÅ ÿ$ğ`Å …Ò„QÿÿÿR‹Èè7öéÿéWÿÿÿVè| ıÿƒÄ_^‹Môd‰    ‹å]ÃVèãX÷ÿ‹ğƒÄ…ö„“   ‹ÎèÏK÷ÿ‹Îè¨/øÿ_^‹Môd‰    ‹å]ÃVèò½ ƒÄ_^‹Môd‰    ‹å]ÃVè‰˜ ƒÄ_^‹Môd‰    ‹å]Ãj UìREàPè§f9 ƒÄÇEü   ‹Èè–e PhÜƒj jjèûd ƒÄÇEüÿÿÿÿMàèƒe ‹Mô_^d‰    ‹å]ÃI `Å 7`Å h`Å `Å İ`Å š`Å  ÌÌÌÌU‹ìd¡    jÿh˜q`Pd‰%    ƒìSVW‹}‹Çèøøÿÿ…Àt*‹…Òt‹9
„™   ‹R…Òuñhƒj jjè=úd ƒÄèe’Ôÿ…Àt=EèPèÈäÿÿƒÄÇEü    ‹Èè‡e Phtƒj jjèúd ƒÄÇEüÿÿÿÿMèète ‹Ä+Õ‹‘d	  ‹
‹_‹wWè:æÿÿƒşÿt8CÿƒøC‡?  ¶€¤cÅ ÿ$…tcÅ …Ò„fÿÿÿR‹ÈèôéÿélÿÿÿVè°•ıÿƒÄ_^[‹Môd‰    ‹å]ÃVèVøÿƒÄ_^[‹Môd‰    ‹å]ÃVè,v ƒÄ_^[‹Môd‰    ‹å]Ã‹Ä+Õ‹‰D	  Vè†œ _^[‹Môd‰    ‹å]ÃVèß©òÿƒÄ_^[‹Môd‰    ‹å]ÃVè™ ƒÄ_^[‹Môd‰    ‹å]ÃVèKtéÿƒÄ…À„Sÿÿÿ‹Èèéı _^[‹Môd‰    ‹å]ÃVèb ƒÄ_^[‹Môd‰    ‹å]ÃVè˜â ƒÄ_^[‹Môd‰    ‹å]ÃVèÎ ‹MôƒÄ_^[d‰    ‹å]Ãjhg  hpà{j èGŸd ƒÄjè7e :bÅ ßbÅ ˆbÅ nbÅ TbÅ "cÅ cÅ ÅbÅ «bÅ <cÅ CbÅ VcÅ  	
ÌÌÌÌÌÌÌÌU‹ìd¡    jÿhÀq`Pd‰%    ƒìVW‹}‹GƒÀå3öƒø)‡  ¶€deÅ ÿ$…LeÅ ‹OQè(º ƒÄ¾   é”   ‹WRèÒT÷ÿƒÄ…Àt‹Èè¤+øÿ¾   ëv‹GPè¤” ƒÄ¾   ëc‹OQè”ÓÿƒÄ…À„§   ‹@0‹0+ÑSj Pè”á; ‹Ø‰]ÇEü    öCt‹WRèÙ§òÿƒÄ¾   ÇEüÿÿÿÿ‹0+ÑEP‰]è¸R; [è2Ôÿ…ÀtXMèQè•áÿÿƒÄÇEü   ‹ÈèT e PhÄƒj jjèÓöd ƒÄÇEüÿÿÿÿMèèA
e _‹Æ^‹Môd‰    ‹å]ÃWèüÿÿƒÄ‹Mô_‹Æ^d‰    ‹å]ÃEdÅ /dÅ cdÅ vdÅ ;dÅ 1eÅ  ÌÌU‹ì‹EV‹0…ötSW‹ÿ‹Ä+Õ‹‹‚d	  ‹v‹ƒùÿt3·Á;‚   s(iÀ¬   ‚  ‹ø9uWèşÿÿƒÄ…Àt	Wè8ùÿÿƒÄ…öu±_^]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìd¡    jÿháq`Pd‰%    SVW‹}jWjh$  èÓˆd ‹ğ‹Eh   PVèò~»ÿ‹E‰†   iÀ¬   j Wh€   Pè¥ˆd ƒÄ,‹Î‰†  Ç†  ¬   ‰¾   èuâÿÿVèÿd %ÿ    w  f‰†  ‹\fà‹KƒÄ3ÿè‹»Éÿ3É‰E;Át‰E‰Mü‰H‰HÇEüÿÿÿÿ‹ø‰7ÿC‰O‰O‹C;Át‰x‹K‰Oë‰;‹Mô‰{_‹Æ^d‰    [‹å]ÃÌÌÌÌÌÌÌÌU‹ìV‹u‹…Òtc‹\fà‹…Àt¤$    9t	‹@…Àuõë
…ÀtPèIÌËÿ‹‹ˆ   ‹  QRè„„d ‹Ç€      ‹‹ˆ   QPèi„d ƒÄÇ    ^]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌV‹5Ä+Õ‹†d	  PèmÿÿÿèH‹9 ‹d	  PQè+„d ƒÄÇ†d	      ^ÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EóE‹UV‹uPjÿQ‹Mó$QRèËçÿÿƒÄƒøÿuÀ^]ÃPVè§õÿÿƒÄ^]ÃÌU‹ìƒìW‹=Ä+Õ¸ÿÿ  Müf‰Eø‹‡d	  Q‹UøRÇEü    è>áÿÿ…Àt4V‹uüVèÀóÿÿƒÄ…Àt	VèùÿÿƒÄ‹‡d	  MüQ‹UøRèáÿÿ…ÀuÎ^_‹å]ÃÌè»„Ôÿ‹Èè$7; ƒøt
ƒøtƒøuépÿÿÿÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EV‹0…öteS‹]W‹}ë	¤$    ‹ÿ‹Ä+Õ‹‹‚d	  ‹v‹ƒùÿt4·Á;‚   s)iÀ¬   ‚  9u9XuP…ÿtèîúÿÿëèGøÿÿƒÄ…öu°_[^]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EV‹0…ötJW‹}‹Ä+Õ‹‹‚d	  ‹v‹ƒùÿt)·Á;‚   siÀ¬   ‚  9u9xu	Pè±õÿÿƒÄ…öu»_^]ÃÌÌÌÌÌÌU‹ì‹E‹M‹UPQRèlüÿÿƒÄÇ€     ]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌV‹5Ä+Õjj jjè<…d ƒÄ‰†d	  è^ƒÔÿ‹ÈèÇ5; ƒøt,èıˆ9 h   Phü}èüÿÿÇ€     ‹d	  ƒÄ‰^Ãh   èÌˆ9 Phü}èáûÿÿ‹–d	  ƒÄ‰^ÃÌÌÌÌU‹ì‹ESV‹ñ‹Èá  €yIƒÉàA™ƒâ»   ÓãÂÁø#\†0^÷ÛÛ÷ÛŠÃ[]Â ÌÌÌÌÌU‹ì‹ESV‹ñ‹Èá  €yIƒÉàA™ƒâ»   ÓãÂÁø#\†^÷ÛÛ÷ÛŠÃ[]Â ÌÌÌÌÌ‹A0ÁèƒàÃÌÌÌÌÌÌ‹A(…Àu¡tœÛ‹@(Ã‹AƒàÃÌÌÌÌÌÌÌÌÌ‹A…Àu¡|œÛ‹@Ã€  ÃÌÌÌÌÌÌÌÌÌ(
  ÃÌÌÌÌÌÌÌÌÌU‹ìV‹u‹Æ™ƒâÂÁøD@‹Îá  €yIƒÉàAº   Óâ^	]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìQ‹EÇEü    ƒI@‰A‹å]Â ÌÌÌÌÌ‹ÃÌÌÌÌÌÌÌÌÌÌÌÌÌAÃÌÌÌÌÌÌÌÌÌÌÌÌVqVèæğÉÿƒÄ…Àu¸à*­^
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
-- @param Version The version of the_^]�������������U��j�h�p`d�    Pd�%    ��<�E�0+�SVW3�VP�   ���; ���}�u��u�9wL��   �u�d$ �wPu�� ��j P��; �E��E����   ��x	;H ��   �j �M�Q�U�R�E�)   �E��z9 ���E��Ej �M�Q�U�R�E�(   �E��z9 �����E��E�H Q���le ���   P�E�RP���Ye Ph �j jj��e ��$�E��M��I"e �E��M��="e �}�E�3��E� �M�Q�� ��E��Oj; �E��E��   @�E�;GL�����E������0+��U�R�}��j; �M�_^��[d�    ��]�������������U��j�hq`d�    Pd�%    ��,SVWh��3�Sjj�!e �=�+���d	  �	�����  �U�f�E�R�E�P3��]���������   �M��e �]��M�Q�M����#A �E�P�M���"e �]��M��;!e �M���e �E��M��e PV�U�h��R�W!e ���M���e PSjj�e ��F�]��M��� e �E������M��� e ��d	  �E�P�M�Q�
��������Y����M�_^[d�    ��]������U��d�    j�hAq`Pd�%    ��V��   u$��   t	�+�����u���^�M�d�    ��]���  S��W��i��   �  �E�f�Gh�   W�}�f��  ��d ���}����M���  �  ��É�Q;�uf�  ��  ��ˉf�  �  ��  ���  f;�tf;E�sf�E�f��  ��M�_[^d�    ��]��U�싆d  ��(  SW���3ۅ�t��ud��h  j j P�q����������   ��+���8	  ����   P�;�������   ��d     t��  t	���_[��]Ë�x  �\��u	��h  Q���u+��h  R�n�������t6���  P�h������t#�X ���u��h  Q��� ����t���#  V��������u��F0���[  �$� U� 3�9}t�   �V8R�|F ����u���F8���t$�M�U�Ej�SWQRQ�$P����������~@W�=�������u�����h  ��l  �UPQRW�;7������_[��]ËE�N8PQ��D���蝙���UR��l����>�����x   ��l  �E��]�t��|  �E���D���Q�2�����������  W�lg���U�E��P���������i  ��,�Q��  S���{�����J  j@�U�SR�X�����h  ���E�PQ�M�h�X��E�    �6�����_[��]ËU�P3���������t ��h  WWQ�,���P�&�������t�   �U�F8SWRPj �y� �M��QW��q ����_[��]Ë�d  ��	���~<E�E�����u�V@�U���d  P3��5�������t"QQ��h  Q����P�:�����(  ������U�E���=����U؍UԉE܋F8�M�NR�E����  P�E�    �]ԉ}��E��M��p�����W�x��������  �MQ���b�����_[��]Ë�d  R����������   ��h  j j P����P��������E�����   ���   Q�E������l�A ����t�U����   �[�M����   R�+�A ����t�E����   Q�%�H �1�U����   P�D�������t!Q����������m^C ���tP�¥H ���E��M�Q��������t�U�R����������  �E�N8SPQ�
� �U��RW�� ����_[��]�W��Ej Q�N8�$SPQ�� ��W����������   �UR���L ��_[��]á�+���D	  �U�F8SRP�M��� �������   �MQ�M�W� � ��_[��]Ë�h  R�,������   ������P�Z�S 腻���V8j j Sj jj�j�WP������Qj�R�T� ���EPW�* ��@��_[��]�h��j jj��e ����_[��]Ë��P� 0Q� R� ^R� U� -T� lT� U� U� �T� U� &S� U� ������������U���E�UV�u���  �����GȋEWPQQ�M�$QR������������  ��V�ƕ? H����,��   ���V� �$��V� W������_��h  ^]�$B��W������_��   ^]�B����+���D	  W�� _�HT^]��A���(i���  ��i�  _��
�   ^]��A��W�� ��_�Hh^]�A��W������_���   ^]�A��W�b����_���   ^]�A��jh%  hp�{j �(�d ��j��Ce jh)  ��jh-  ��_^]��U� GV� �U� �U� ^V� �V� uV� 3V� V� �V� �V�  


































	���������������U��E�HI��,�   ���X� V�$��X� �PR����������t]j j V�b������\  ��tF�0��t@��+����d	  �v����t$��;�   si��   �  9u	P�v�������u�^]Ë@P�sa��������t���������  뒋HQ�D��������t�V�� ����X  �l����P��+���,	  R������t�P��l ��^]ËHQ�h�������t�j��踯��^]Ë�+��@��D	  P�У ���Y�����^]韢 �HQ�&� �����<���P�5� ��^]ËPR�~����������j��� ^]Ë@P�� �����������\�����HQ�& ���������P��& ��^]ÍI 2W� qX� +X� �W� �W� �X� �W� QX� X� �X� �W�  


































	�������U��EW�8���  V��5�+���d	  �������   ��;�   ��   i��   �  9��   �H��-u)�@P�>% ������   ��+��Q8B��`Z  �   ��u4�@�����   ��8	  ����   P�i�����t{\  P�J������k��uf�@P�'_��������tT���  Q�"�����T  ����t;��I ��v���t(��+���8	  ��tP� �����t\  P���������uʅ������^_]��������������̋��   ��w~�$�[� ���   ���t��+���8	  ��t
P������u3��\  Ë��   P�d^������t��  Ë��   Q諶 ����t˃�\Ë��   R�A������t�X  �jh<  hp�{j 褧d ��j�j?e ���Z� �Z� �Z� �Z� �Z� �Z� U��EW�8����   S�]V���$    ���+����d	  �����t~��;�   ssi��   �  9uc�p���t[�@Ht��uPV�]������tCjS���C����7�;'  u#��+���8	  ��tV�s�����t���   ujSV���������b���^[_]��������������U��V�u�N�����   �VJ3���C��   ��T]� �$�$]� Q�
��������@^]�Q��\�������@^]á�+�Q��,	  �=������@^]�Q��+���D	  蓟 ���@^]�������u�F�����   ^]ËVR�ڛ�������@^]�Q�	� �����@^]�Q�hz�������@^]�Q�?�������@^]�Q薴 �����@^]�Q��! �����@^]�jh�  hp�{j 藥d ��j�]=e �0\� �\� k\� R\� A\� �\� �\� �\� �\� �\� �\� ]�  	
��������U��j�haq`d�    Pd�%    ����+���d	  �������E���u��M�d�    ��]Ë�+���d	  �
�UV��i��   �  W�}�GP�V�Z�? �O8�F�N��d  �N�W<�V��d  ���   ��h  �����   ���   uP�h�������t���   ���   ����   S�^�Ǥ  �E�   j@WS裆������`��D�M�u����������O3�3������E�;�t�E�]��X�X�E��������E��G�^�^�O;�[t�q�W�V�w_^�M�d�    ��]ËM�7�w_^d�    ��]��������������U��d�    j�h�q`Pd�%    ��VW�}���)�����t*���t�9
��   �R��u�h0�j jj�n�d ��薔����t=�E�P��������E�    ���e Ph�j jj�7�d ���E������M��e �G�O�w�G������+��M�E���d	  �W�[��������   �E�H��C��   ��a� �$��`� ���Q���R���7����W���V�| ����_^�M�d�    ��]�V��X����������   ����K�����/��_^�M�d�    ��]�V�� ��_^�M�d�    ��]�V艘 ��_^�M�d�    ��]�j �U�R�E�P�f9 ���E�   ���e Ph��j jj��d ���E������M��e �M�_^d�    ��]ÍI `� 7`� h`� �`� �`� �`�  ����U��d�    j�h�q`Pd�%    ��SVW�}���������t*���t�9
��   �R��u�h��j jj�=�d ���e�����t=�E�P��������E�    ���e Pht�j jj��d ���E������M��te ��+���d	  �
�_�wW�:������t8�C���C�?  ���c� �$�tc� ���f���R�������l���V谕����_^[�M�d�    ��]�V�V����_^[�M�d�    ��]�V�,v ��_^[�M�d�    ��]Ë�+���D	  V膜 _^[�M�d�    ��]�V�ߩ����_^[�M�d�    ��]�V�� ��_^[�M�d�    ��]�V�Kt�������S�������� _^[�M�d�    ��]�V�b� ��_^[�M�d�    ��]�V�� ��_^[�M�d�    ��]�V�� �M��_^[d�    ��]�jhg  hp�{j �G�d ��j�7e �:b� �b� �b� nb� Tb� "c� c� �b� �b� <c� Cb� Vc�  	
��������U��d�    j�h�q`Pd�%    ��VW�}�G���3���)�  ��de� �$�Le� �OQ�(� ���   �   �WR��T������t���+���   �v�GP褔 ���   �c�OQ����������   �@0�0+�Sj P��; �؉]�E�    �Ct�WR�٧�����   �E������0+��EP�]�R; [�2�����tX�M�Q�������E�   ���T e Ph��j jj���d ���E������M��A
e _��^�M�d�    ��]�W�������M�_��^d�    ��]�Ed� /d� cd� vd� ;d� 1e�  ��U��EV�0��tSW����+����d	  �v����t3��;�   s(i��   �  ��9uW��������t	W�8�������u�_^]��������������U��d�    j�h�q`Pd�%    SVW�}jWjh$  �ӈd ���Eh   PV��~���E��   i��   j Wh�   P襈d ��,�Ή�  ǆ  �   ��   �u���V��d %�    w  f��  �\f��K��3�苻��3ɉE;�t�E�M��H�H�E��������7�C�O�O�C;�t�x�K�O��;�M�{_��^d�    [��]���������U��V�u���tc�\f����t��$    9t	�@��u��
��tP�I������   ��  QR脄d �ǀ      ���   QP�i�d ���    ^]��������������V�5�+���d	  P�m����H�9 ��d	  PQ�+�d ��ǆd	      ^�������������U��E�E�UV�uPj�Q�M�$QR����������u�^]�PV������^]��U���W�=�+����  �M�f�E���d	  Q��U�R�E�    �>�����t4V�u�V���������t	V��������d	  �M�Q��U�R������u�^_��]��軄�����$7; ��t
��t��u�p�������������������U��EV�0��teS�]W�}�	��$    ����+����d	  �v����t4��;�   s)i��   �  9u9XuP��t�������G�������u�_[^]������������U��EV�0��tJW�}��+����d	  �v����t)��;�   si��   �  9u9xu	P��������u�_^]�������U��E�M�UPQR�l�����ǀ     ]��������������V�5�+�jj jj�<�d ����d	  �^�������5; ��t,���9 h   Ph�}����ǀ     ��d	  ���^�h   �̈9 Ph�}�������d	  ���^�����U��ESV��ȁ�  �yI���A����   �����#\�0^����ۊ�[]� �����U��ESV��ȁ�  �yI���A����   �����#\�^����ۊ�[]� ����̋A0����������̋A(��u�t���@(ËA�����������̋A��u�|���@Í��  ���������̍�(
  ����������U��V�u�ƙ������D�@�΁�  �yI���A�   ��^	]� �������������U��Q�E�E�    �I@�A��]� ����̋�������������̍A�������������V�qV���������u��*�^
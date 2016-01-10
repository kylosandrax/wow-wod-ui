--- **AceAddon-3.0** provides a template for creating addon objects.
-- It'll provide you with a set of callback functions that allow you to simplify the loading
-- process of your addon.\\
-- Callbacks provided are:\\
-- * **OnInitialize**, which is called directly after the addon is fully loaded.
-- * **OnEnable** which gets called during the PLAYER_LOGIN event, when most of the data provided by the game is already present.
-- * **OnDisable**, which is only called when your addon is manually being disabled.
-- @usage
-- -- A small (but complete) addon, that doesn't do anything, 
-- -- but shows usage of the callbacks.
-- local MyAddon = LibStub("AceAddon-3.0"):NewAddon("MyAddon")
-- 
-- function MyAddon:OnInitialize()
--   -- do init tasks here, like loading the Saved Variables, 
--   -- or setting up slash commands.
-- end
-- 
-- function MyAddon:OnEnable()
--   -- Do more initialization here, that really enables the use of your addon.
--   -- Register Events, Hook functions, Create Frames, Get information from 
--   -- the game that wasn't available in OnInitialize
-- end
--
-- function MyAddon:OnDisable()
--   -- Unhook, Unregister Events, Hide frames that you created.
--   -- You would probably only use an OnDisable if you want to 
--   -- build a "standby" mode, or be able to toggle modules on/off.
-- end
-- @class file
-- @name AceAddon-3.0.lua
-- @release $Id: AceAddon-3.0.lua 1084 2013-04-27 20:14:11Z nevcairiel $

local MAJOR, MINOR = "AceAddon-3.0", 12
local AceAddon, oldminor = LibStub:NewLibrary(MAJOR, MINOR)

if not AceAddon then return end -- No Upgrade needed.

AceAddon.frame = AceAddon.frame or CreateFrame("Frame", "AceAddon30Frame") -- Our very own frame
AceAddon.addons = AceAddon.addons or {} -- addons in general
AceAddon.statuses = AceAddon.statuses or {} -- statuses of addon.
AceAddon.initializequeue = AceAddon.initializequeue or {} -- addons that are new and not initialized
AceAddon.enablequeue = AceAddon.enablequeue or {} -- addons that are initialized and waiting to be enabled
AceAddon.embeds = AceAddon.embeds or setmetatable({}, {__index = function(tbl, key) tbl[key] = {} return tbl[key] end }) -- contains a list of libraries embedded in an addon

-- Lua APIs
local tinsert, tconcat, tremove = table.insert, table.concat, table.remove
local fmt, tostring = string.format, tostring
local select, pairs, next, type, unpack = select, pairs, next, type, unpack
local loadstring, assert, error = loadstring, assert, error
local setmetatable, getmetatable, rawset, rawget = setmetatable, getmetatable, rawset, rawget

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS: LibStub, IsLoggedIn, geterrorhandler

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
	-- we check to see if the func is passed is actually a function here and don't error when it isn't
	-- this safecall is used for optional functions like OnInitialize OnEnable etc. When they are not
	-- present execution should continue without hinderance
	if type(func) == "function" then
		return Dispatchers[select('#', ...)](func, ...)
	end
end

-- local functions that will be implemented further down
local Enable, Disable, EnableModule, DisableModule, Embed, NewModule, GetModule, GetName, SetDefaultModuleState, SetDefaultModuleLibraries, SetEnabledState, SetDefaultModulePrototype

-- used in the addon metatable
local function addontostring( self ) return self.name end 

-- Check if the addon is queued for initialization
local function queuedForInitialization(addon)
	for i = 1, #AceAddon.initializequeue do
		if AceAddon.initializequeue[i] == addon then
			return true
		end
	end
	return false
end

--- Create a new AceAddon-3.0 addon.
-- Any libraries you specified will be embeded, and the addon will be scheduled for 
-- its OnInitialize and OnEnable callbacks.
-- The final addon object, with all libraries embeded, will be returned.
-- @paramsig [object ,]name[, lib, ...]
-- @param object Table to use as a base for the addon (optional)
-- @param name Name of the addon object to create
-- @param lib List of libraries to embed into the addon
-- @usage 
-- -- Create a simple addon object
-- MyAddon = LibStub("AceAddon-3.0"):NewAddon("MyAddon", "AceEvent-3.0")
--
-- -- Create a Addon object based on the table of a frame
-- local MyFrame = CreateFrame("Frame")
-- MyAddon = LibStub("AceAddon-3.0"):NewAddon(MyFrame, "MyAddon", "AceEvent-3.0")
function AceAddon:NewAddon(objectorname, ...)
	local object,name
	local i=1
	if type(objectorname)=="table" then
		object=objectorname
		name=...
		i=2
	else
		name=objectorname
	end
	if type(name)~="string" then
		error(("Usage: NewAddon([object,] name, [lib, lib, lib, ...]): 'name' - string expected got '%s'."):format(type(name)), 2)
	end
	if self.addons[name] then 
		error(("Usage: NewAddon([object,] name, [lib, lib, lib, ...]): 'name' - Addon '%s' already exists."):format(name), 2)
	end
	
	object = object or {}
	object.name = name

	local addonmeta = {}
	local oldmeta = getmetatable(object)
	if oldmeta then
		for k, v in pairs(oldmeta) do addonmeta[k] = v end
	end
	addonmeta.__tostring = addontostring
	
	setmetatable( object, addonmeta )
	self.addons[name] = object
	object.modules = {}
	object.orderedModules = {}
	object.defaultModuleLibraries = {}
	Embed( object ) -- embed NewModule, GetModule methods
	self:EmbedLibraries(object, select(i,...))
	
	-- add to queue of addons to be initialized upon ADDON_LOADED
	tinsert(self.initializequeue, object)
	return object
end


--- Get the addon object by its name from the internal AceAddon registry.
-- Throws an error if the addon object cannot be found (except if silent is set).
-- @param name unique name of the addon object
-- @param silent if true, the addon is optional, silently return nil if its not found
-- @usage 
-- -- Get the Addon
-- MyAddon = LibStub("AceAddon-3.0"):GetAddon("MyAddon")
function AceAddon:GetAddon(name, silent)
	if not silent and not self.addons[name] then
		error(("Usage: GetAddon(name): 'name' - Cannot find an AceAddon '%s'."):format(tostring(name)), 2)
	end
	return self.addons[name]
end

-- - Embed a list of libraries into the specified addon.
-- This function will try to embed all of the listed libraries into the addon
-- and error if a single one fails.
--
-- **Note:** This function is for internal use by :NewAddon/:NewModule
-- @paramsig addon, [lib, ...]
-- @param addon addon object to embed the libs in
-- @param lib List of libraries to embed into the addon
function AceAddon:EmbedLibraries(addon, ...)
	for i=1,select("#", ... ) do
		local libname = select(i, ...)
		self:EmbedLibrary(addon, libname, false, 4)
	end
end

-- - Embed a library into the addon object.
-- This function will check if the specified library is registered with LibStub
-- and if it has a :Embed function to call. It'll error if any of those conditions
-- fails.
--
-- **Note:** This function is for internal use by :EmbedLibraries
-- @paramsig addon, libname[, silent[, offset]]
-- @param addon addon object to embed the library in
-- @param libname name of the library to embed
-- @param silent marks an embed to fail silently if the library doesn't exist (optional)
-- @param offset will push the error messages back to said offset, defaults to 2 (optional)
function AceAddon:EmbedLibrary(addon, libname, silent, offset)
	local lib = LibStub:GetLibrary(libname, true)
	if not lib and not silent then
		error(("Usage: EmbedLibrary(addon, libname, silent, offset): 'libname' - Cannot find a library instance of %q."):format(tostring(libname)), offset or 2)
	elseif lib and type(lib.Embed) == "function" then
		lib:Embed(addon)
		tinsert(self.embeds[addon], libname)
		return true
	elseif lib then
		error(("Usage: EmbedLibrary(addon, libname, silent, offset): 'libname' - Library '%s' is not Embed capable"):format(libname), offset or 2)
	end
end

--- Return the specified module from an addon object.
-- Throws an error if the addon object cannot be found (except if silent is set)
-- @name //addon//:GetModule
-- @paramsig name[, silent]
-- @param name unique name of the module
-- @param silent if true, the module is optional, silently return nil if its not found (optional)
-- @usage 
-- -- Get the Addon
-- MyAddon = LibStub("AceAddon-3.0"):GetAddon("MyAddon")
-- -- Get the Module
-- MyModule = MyAddon:GetModule("MyModule")
function GetModule(self, name, silent)
	if not self.modules[name] and not silent then
		error(("Usage: GetModule(name, silent): 'name' - Cannot find module '%s'."):format(tostring(name)), 2)
	end
	return self.modules[name]
end

local function IsModuleTrue(self) return true end

--- Create a new module for the addon.
-- The new module can have its own embeded libraries and/or use a module prototype to be mixed into the module.\\
-- A module has the same functionality as a real addon, it can have modules of its own, and has the same API as
-- an addon object.
-- @name //addon//:NewModule
-- @paramsig name[, prototype|lib[, lib, ...]]
-- @param name unique name of the module
-- @param prototype object to derive this module from, methods and values from this table will be mixed into the module (optional)
-- @param lib List of libraries to embed into the addon
-- @usage 
-- -- Create a module with some embeded libraries
-- MyModule = MyAddon:NewModule("MyModule", "AceEvent-3.0", "AceHook-3.0")
-- 
-- -- Create a module with a prototype
-- local prototype = { OnEnable = function(self) print("OnEnable called!") end }
-- MyModule = MyAddon:NewModule("MyModule", prototype, "AceEvent-3.0", "AceHook-3.0")
function NewModule(self, name, prototype, ...)
	if type(name) ~= "string" then error(("Usage: NewModule(name, [prototype, [lib, lib, lib, ...]): 'name' - string expected got '%s'."):format(type(name)), 2) end
	if type(prototype) ~= "string" and type(prototype) ~= "table" and type(prototype) ~= "nil" then error(("Usage: NewModule(name, [prototype, [lib, lib, lib, ...]): 'prototype' - table (prototype), string (lib) or nil expected got '%s'."):format(type(prototype)), 2) end
	
	if self.modules[name] then error(("Usage: NewModule(name, [prototype, [lib, lib, lib, ...]): 'name' - Module '%s' already exists."):format(name), 2) end
	
	-- modules are basically addons. We treat them as such. They will be added to the initializequeue properly as well.
	-- NewModule can only be called after the parent addon is present thus the modules will be initialized after their parent is.
	local module = AceAddon:NewAddon(fmt("%s_%s", self.name or tostring(self), name))
	
	module.IsModule = IsModuleTrue
	module:SetEnabledState(self.defaultModuleState)
	module.moduleName = name

	if type(prototype) == "string" then
		AceAddon:EmbedLibraries(module, prototype, ...)
	else
		AceAddon:EmbedLibraries(module, ...)
	end
	AceAddon:EmbedLibraries(module, unpack(self.defaultModuleLibraries))

	if not prototype or type(prototype) == "string" then
		prototype = self.defaultModulePrototype or nil
	end
	
	if type(prototype) == "table" then
		local mt = getmetatable(module)
		mt.__index = prototype
		setmetatable(module, mt)  -- More of a Base class type feel.
	end
	
	safecall(self.OnModuleCreated, self, module) -- Was in Ace2 and I think it could be a cool thing to have handy.
	self.modules[name] = module
	tinsert(self.orderedModules, module)
	
	return module
end

--- Returns the real name of the addon or module, without any prefix.
-- @name //addon//:GetName
-- @paramsig 
-- @usage 
-- print(MyAddon:GetName())
-- -- prints "MyAddon"
function GetName(self)
	return self.moduleName or self.name
end

--- Enables the Addon, if possible, return true or false depending on success.
-- This internally calls AceAddon:EnableAddon(), thus dispatching a OnEnable callback
-- and enabling all modules of the addon (unless explicitly disabled).\\
-- :Enable() also sets the internal `enableState` variable to true
-- @name //addon//:Enable
-- @paramsig 
-- @usage 
-- -- Enable MyModule
-- MyAddon = LibStub("AceAddon-3.0"):GetAddon("MyAddon")
-- MyModule = MyAddon:GetModule("MyModule")
-- MyModule:Enable()
function Enable(self)
	self:SetEnabledState(true)

	-- nevcairiel 2013-04-27: don't enable an addon/module if its queued for init still
	-- it'll be enabled after the init process
	if not queuedForInitialization(self) then
		return AceAddon:EnableAddon(self)
	end
end

--- Disables the Addon, if possible, return true or false depending on success.
-- This internally calls AceAddon:DisableAddon(), thus dispatching a OnDisable callback
-- and disabling all modules of the addon.\\
-- :Disable() also sets the internal `enableState` variable to false
-- @name //addon//:Disable
-- @paramsig 
-- @usage 
-- -- Disable MyAddon
-- MyAddon = LibStub("AceAddon-3.0"):GetAddon("MyAddon")
-- MyAddon:Disable()
function Disable(self)
	self:SetEnabledState(false)
	return AceAddon:DisableAddon(self)
end

--- Enables the Module, if possible, return true or false depending on success.
-- Short-hand function that retrieves the module via `:GetModule` and calls `:Enable` on the module object.
-- @name //addon//:EnableModule
-- @paramsig name
-- @usage 
-- -- Enable MyModule using :GetModule
-- MyAddon = LibStub("AceAddon-3.0"):GetAddon("MyAddon")
-- MyModule = MyAddon:GetModule("MyModule")
-- MyModule:Enable()
--
-- -- Enable MyModule using the short-hand
-- MyAddon = LibStub("AceAddon-3.0"):GetAddon("MyAddon")
-- MyAddon:EnableModule("MyModule")
function EnableModule(self, name)
	local module = self:GetModule( name )
	return module:Enable()
end

--- Disables the Module, if possible, return true or false depending on success.
-- Short-hand function that retrieves the module via `:GetModule` and calls `:Disable` on the module object.
-- @name //addon//:DisableModule
-- @paramsig name
-- @usage 
-- -- Disable MyModule using :GetModule
-- MyAddon = LibStub("AceAddon-3.0"):GetAddon("MyAddon")
-- MyModule = MyAddon:GetModule("MyModule")
-- MyModule:Disable()
--
-- -- Disable MyModule using the short-hand
-- MyAddon = LibStub("AceAddon-3.0"):GetAddon("MyAddon")
-- MyAddon:DisableModule("MyModule")
function DisableModule(self, name)
	local module = self:GetModule( name )
	return module:Disable()
end

--- Set the default libraries to be mixed into all modules created by this object.
-- Note that you can only change the default module libraries before any module is created.
-- @name //addon//:SetDefaultModuleLibraries
-- @paramsig lib[, lib, ...]
-- @param lib List of libraries to embed into the addon
-- @usage 
-- -- Create the addon object
-- MyAddon = LibStub("AceAddon-3.0"):NewAddon("MyAddon")
-- -- Configure default libraries for modules (all modules need AceEvent-3.0)
-- MyAddon:SetDefaultModuleLibraries("AceEvent-3.0")
-- -- Create a module
-- MyModule = MyAddon:NewModule("MyModule")
function SetDefaultModuleLibraries(self, ...)
	if next(self.modules) then
		error("Usage: SetDefaultModuleLibraries(...): cannot change the module defaults after a module has been registered.", 2)
	end
	self.defaultModuleLibraries = {...}
end

--- Set the default st �� ����B$������B(������B,������B0������~BLfօ����~BTfօ����~B\fօ$����~Bdfօ,����~Blfօ4����~Btfօ<������,  �����   ���};�   ��   ��d  �d  �   �⋈   �<����,  J#Ui�4  �9
��   �B ��D����B$��H����B(��L����B,��P����B0��T����~BLfօX����~BTfօ`����~B\fօh����~Bdfօp����~Blfօx����~Btfօ�������,  �����   ���};�   ��   ��d  �d  �   �⋈   �<����,  J#Ui�4  �9
��   �B �������B$�������B(�������B,�������B0�������~BLfօ�����~BTfօ�����~B\fօ�����~Bdfօ�����~Blfօ�����~Btfօ������-  �����   ���};�   ��   ��d  �d  �   �⋈   �<���-  J#Ui�4  �9
��   �B �������B$�������B(�������B,�������B0�������~BLfօ�����~BTfօ�����~B\fօ�����~Bdfօ�����~Blfօ ����~Btfօ�����-  �����   ���};�   ��   ��d  �d  ��   �   �<���-  ��J#Ui�4  �9��   �B ������B$������B(������B,������B0�� ����~BLfօ$����~BTfօ,����~B\fօ4����~Bdfօ<����~BlfօD����~BtfօL�����D����
;' ��0����?J' ���=��~$W��0�����4���Pǅ0���   �SxQ���   ��8����$谅' ���   ��p  �M�E�x   t��+�   t��=��M�E�    �F ��\��Y��X��V �T������NI ��t\W���   �g���t"�E�U܋IP�E�RP�����M�A���I������>����U�M�R�U�Q�HR躾���E��@�������7����ȉM���tp��+���8	  ��ta��;�   sV��d  �d  �   ���M�J#ы�   i�T  �<��E�9:u#��:�   Q���` �����I���9GHv�GD��F �~8WQ�$������R��\���P�;����E�����  PQ�$WP�������   �\V(�M�Y��XV(�V(���   �\V,�Y��XV,�V,���   �\V0�Y��XV0�V0ǆ�     �z����M���   QR�Z������   ��;~�&  �~�t2�FP�f ����t�} t�NQ�% ������G= �F���������   �M��/E �\����h����`����l����d����p����h����t����l����x����p����|����t���M���d����E��E�    �E������D ��=��E��Y��E��Y�3���d����E��Y�R�E��E��E��E��[0 ���F�~�CtV�f���������������   �t
SV�������E싋�   j PjQ���  ���E���������UR�]�cI �M�_^[d�    ��]���������U��EV��p  jP�k������F8P���  色���F$���  �^ �~��  fֆ�  fֆ�  �щ��  ���  ^]�����U��j�h�_d�    Pd�%    ��SV�ٍ�`  W3��>�~�~�~�u����F0j���0�   h�   P�]�N�N�F   �~�~�~�~ �F(   �F$�G�r �F,�`�}��E��p�E�   ��  ��  ��  ��  ��  �u����F0j��(  �   h�   P�N�N�F�  �~�~�~�~ �F(   �F$�͖r ���F,�`�E��M��q�E���$-  ��(-  ��,-  �E������M�_^��[d�    ��]����������U��V���%����Et	V�)�r ����^]� ���������������U��j�h�_d�    Pd�%    ��8VWj3�Vjhh-  ��r ���E��E�u�;�t	���K���������}���=����  ���  ���  �~��  fֆ�  fֆ�  W��~�~�~�~�~�~�E��E��~U��ǉ��  �ω��  f��V��E��M��~U�f��V��E���V���[���V���[���V���[���V��E��E��~U�f��V��E��M��~U�f��V��E��E��~U�f��V��E��M��~U�f�W��E��E��~U�f�W��E��M��~U�f�W��E��E��~U��E��M�f�0W��~U���V���V���V���V���V��W�� W��$W��(W��,W�f�8W��E��E��E��~U�f�@W��M��~U�f�HW��E��E��~U�f�PW��E��M��~U�f�XW��E��E��~U�f�tW��E��M��~U�f�|W��E��E��~U�f��W��E��M��~U�f��W��E��E��~U�f��W��E��M��~U�f��W��E��E��~U�f��W��E��M��~U�f��W��E��E��~U�f��W��E��M��~U�f��W��E��E��~U�f��W��E��M��~U�f��W��E��E��~U��`W��dW��hW��lW��pW���W���W���W���W���W���W���W���W���W���W��E��M�f��W��~U�f�X��E��E��~U�f�X��E��M��~U�f�X��E��E��~U��E��M�f�X��~U�h�V��N8f�$X��,X��0X��4X��8X��'���h�V����  ����W���=��U�R�E��E��E��E��E��E��E���[�P�M��E���Z�Q��@  �M��E����t �M�ǆ\  ,  ��-  ��-  ��-  ��-  �� -  ���,  ���,  ���,  ���,  ���,  ���,  �� -  ��-  ��-  ��-  �~4��0-  _��^d�    ��]����������U��V�u��t���>���V�H�r ��^]��̋A�������������U��3��}���H]��V��p  P��[�������t  Q�� ��^�����������SV��W�K�C����s,�   ���4�����Ou�_^�K\[�#������VWj j ��`  ����j j P貯I ǆ`  �������   �   �N�j j j j Q����膯I �����j j j j R�p�I �F������������Ou�_^�����������SV��W�K�����s,�   ���������Ou�_^�K\[��������SV��W�K�c����s,�   ���T�����Ou�_^�K\[�C������SV��W�K��9���s,�   ����9����Ou�_^�K\[��9�����SV��W�K�C���s,�   ���4����Ou�_^�K\[�#�����V��Fxj P��_���N|Q��_����^�����U���   SV�u�ك����   �b����u~W��"����   �}����#�����Ej �   �}�P��o_��j��_���Cx��PjF�J\J ��P�qi���Kxj Q�F_���S|R�m_���E�P�tO���M�Q�+W����_^[��]� V�ya����^[��]� �������������̋A������������̋A������������̍A���������������i�������������苎������@I 3Ƀ����������������{�������������̡�+����	  �����3���A�A�����̋���������������U��EP�Gs ��]� �������������U��E��    Q�mGs ��]� ������U��E]���������U��E��U�
]��U��M�EV+�W�}���4�    VQW�|�{���>_^]��������������������U��j�h_d�    Pd�%    QV��u��E�������p  P��[��������t  Q�,� �M��^d�    ��]�����������S��+�VW�TX��M����lX��   �I ���9�����Ou�X��)������	  ��t	��W���3�P讌r ��_^ǃ�	      [��������������U��V��p  P��[�������t  Q�|� ���Et	V�]�r ����^]� ��̋���������������U��ES�]VW��j S�N��d  �����~,�E   ��$    j S����������Mu�j S�N\�����W��M�U�F�F�F�F    _��h  ��l  ^[]� �U���0SV���PW�M�Q�Ήu��ҋ}ԋ]Љ}؉}������t�S��������E���E�*   �B���E�3��E��M��M����M艌��   ����   ���7  ��g� �$��f� ������  ���  � �����  �3������   �%������   �������   ����   ��R����u�E��E����   �\o������&������  �   �    �E�   ���   �R������  ���   �����t�����t������\  �E�   ���Z�����t�u����t�k�����/  �E�   �)�T����t�J����t�@�����  �E�    �������E�    �����u`�E���t��uS�	������tH�������   �E�P�E�jjj jP�E�SP�ҋ������   �U�R�U�jjj jRSj�ЋM��E�j Q�M�jjj WV�U�RPQ�JD����P������U�M���(����   �����   �E���t7�U�j Rjjj WV�u��M�QPV�D����P�����U��(����   ���t2�u�}�E�@�E����������|�E��Q����t'���   �M��?h\�j jj��r ��_^3�[��]�������u�U�j j jj WSR�������E������t	���   �E��q����t@�"���M�j j jjj Q��R�M�QPj�E��8C����P�������(���   ����f����h"��j j jjj WS�U�RPj
�E���B����P������(���   ����+����-����t�#����t
�����u6�M�j j jjj WS�E�PQj�B����P�P�����(���   ���������U�Rh�[�j jj��r ��������t�����t���   ����   �M��Nx�F|�W����t;�U��E�j j Rjj WS�M�QPj�E��#B����P�������(���   ����Q��������t=�J!���U�j j Rjj WS�M�QPj�E���A����P������(���   ��������   ;��%      �E��$����|�]k������"����u	�E� �M�����  u�   9E�|�E�E�j j jjj PP�U�Rj h�[��E�    �������(��`  ��j�����g"����~?�~ ��j j jjj ��W��S�M�QPj�E��A����P������(���   ����=���_^�   [��]��a� b� �b� /b� �a� [b� �a� Hb� �b� ob� �b� �c�   	

������������U��E� �Y�@�Y�@�E�Y�A]� ���������������U��QW�V��W�~�E�踨��P��` ����t��Y��Y8=��E�j
�O�G ����t)�S����x<u��Y��XE�Q�$������]����E���l  Q�$WP����Wj������_^��]�������U��V�u�FPV��������^]� �����U��V�u�FPV�������^]� �����U����y �M��E�    vQSVW���I �ʋA�M��4��N������~,�   ��I ���������Ku�N\�����E��U�@�E�;Br�_^[��]������U����y �M��E�    vQSVW���I �ʋA�M��4��N�-.���~,�   ��I ���.����Ku�N\�.���E��U�@�E�;Br�_^[��]������U����y �M��E�    vQSVW���I �ʋA�M��4��N�=����~,�   ��I ���)�����Ku�N\�����E��U�@�E�;Br�_^[��]������U����y �M��E�    vQSVW���I �ʋA�M��<��O������w,�   ��I ���������Ku�O\������E��U�@�E�;Br�_^[��]������VW��3�9wv)��I �G����B�Ѕ�t�O����B��F;wr�_^���������̋A� ����������̋A� ����������̋�3ɉ�H�H����U��Q����U;�BA��P��;s ��]� ������������������������V������[��Vx�V|���   �   �I �P����Iu�3���`  ��d  ��h  ��l  �������p  �� ��t  ��^�̋P�;s Y�������U��UV��N;�vB�����;�BF��WP�G;s �N����ɋ���QPW�|�{�R�D;s ���>_^]� ���������U��j�h(_d�    Pd�%    QV��u������E�    �\��E������M��^d�    ��]��������U��j�hH_d�    Pd�%    QV��u��E�������p  P��[�������t  Q�� ���Et	V�̀r ���M��^d�    ��]� �������U��j�hk_d�    Pd�%    Q��3�� 8\��E��H�H�H�M��H�E������M�d�    ��]�������U��j�h�_d�    Pd�%    Q�M��8\��E������AP��9s �M��d�    ��]��������������U��VW�}��+>�N��9NuI�Q;�vB�����;�BF��SP�y9s �N����ɋ؋�QPS�|�{�R�v9s ���[�F�;�s�����F_^]� �U����F_^]� �������U��j�h�_d�    Pd�%    QV��u��8\��E������FP�9s ���Et	V�<r ���M��^d�    ��]� ������U��V��EP�N������~u�F@X�^]� ������������U��j�h�_d�    Pd�%    ��SV�5�+�j3�Sjj迀r ���E��E�]�;�t� 8\��X�X�X�E��X�]��3��E�����jSSS�@X����	  �6�����+����	  �M�Q�N�E�@X��H����~u�F@X��M�^[d�    ��]������������U��MI3���w(��o� �$�o� �   ]ø   ]ø   ]ø   ]��n� �n� �n� o�     ������������U���f�Ef�M�S�]f�E�I3�V�U���w(���o� �$��o� �   ��   ��   ��   ����w
�U��E����M���Mh�   jR�E�PQ�&ys �����v��E�Mh�   VRPQ�ys ��3^[��]Ë�`o� go� no� uo�     ������������U���P  SV��������rs �]���Ej j jP��~r �M�Uj�jj SQ���ERVP�u��ת���]j3��M�h<\�Qf�E�  �E�f�E��8�{�EP�������*   Qf�U��E�   �{s ��������DR�Dts ������jP�us �����s  Wh�   jj �M�Q������R�xs h�   jj�EP������Q�E
   ��ws �E�Mh�   j�4@j
�U�R�������   P�4�   �E�  �}��M��ws �Eh�   jj�M�Q������R�E� �}��E��|ws ��Ph�   �   j�E؉E�j"�E�P������Q�E�  �E�  �E� �u��=ws h�   jV�U�R������P�%ws h�   jj.�E���}��E� �}��}�P������Q��vs h�   j�   j:�U�EЉE�R������P�E� �}���vs �E؃�Ph�   jjF�M�Q������R�E� �}��E��vs h�   ���j�ẺE�jR�E�P������Q�E� �}��svs h�   jj^�M�Q������R�}��E�( �}��}��Jvs h�   jjj�U�R������P�u��E� �}��u��!vs ��Ph�   jjv�E�P������Q�]��E� �}��]���us h�   �E�    jh�   �U�R������P��us �M�h�   SVQ������R�us ������P�ts �u��@_j V�xr ��^[��]��������U���H  W�������os �}�}3�
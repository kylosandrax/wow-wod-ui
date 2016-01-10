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

--- Set the default st ó… şÿÿóB$ó…şÿÿóB(ó…şÿÿóB,ó…şÿÿóB0ó…şÿÿó~BLfÖ…şÿÿó~BTfÖ…şÿÿó~B\fÖ…$şÿÿó~BdfÖ…,şÿÿó~BlfÖ…4şÿÿó~BtfÖ…<şÿÿ‹ô,  ƒùÿ„Ù   ·ù‰};¸   ƒÇ   Šˆd  Óï‹ˆd  º   Óâ‹ˆ   ‹<¹‹ô,  J#UiÒ4  ×9
…   óB ó…DşÿÿóB$ó…HşÿÿóB(ó…LşÿÿóB,ó…PşÿÿóB0ó…Tşÿÿó~BLfÖ…Xşÿÿó~BTfÖ…`şÿÿó~B\fÖ…hşÿÿó~BdfÖ…pşÿÿó~BlfÖ…xşÿÿó~BtfÖ…€şÿÿ‹ü,  ƒùÿ„Ù   ·ù‰};¸   ƒÇ   Šˆd  Óï‹ˆd  º   Óâ‹ˆ   ‹<¹‹ü,  J#UiÒ4  ×9
…   óB ó…ˆşÿÿóB$ó…ŒşÿÿóB(ó…şÿÿóB,ó…”şÿÿóB0ó…˜şÿÿó~BLfÖ…œşÿÿó~BTfÖ…¤şÿÿó~B\fÖ…¬şÿÿó~BdfÖ…´şÿÿó~BlfÖ…¼şÿÿó~BtfÖ…Äşÿÿ‹-  ƒùÿ„Ù   ·ù‰};¸   ƒÇ   Šˆd  Óï‹ˆd  º   Óâ‹ˆ   ‹<¹‹-  J#UiÒ4  ×9
…   óB ó…ÌşÿÿóB$ó…ĞşÿÿóB(ó…ÔşÿÿóB,ó…ØşÿÿóB0ó…Üşÿÿó~BLfÖ…àşÿÿó~BTfÖ…èşÿÿó~B\fÖ…ğşÿÿó~BdfÖ…øşÿÿó~BlfÖ… ÿÿÿó~BtfÖ…ÿÿÿ‹-  ƒùÿ„Ù   ·ù‰};¸   ƒÇ   Šˆd  Óï‹ˆd  ‹€   º   ‹<¸‹†-  ÓâJ#UiÒ4  ×9…   óB ó…ÿÿÿóB$ó…ÿÿÿóB(ó…ÿÿÿóB,ó…ÿÿÿóB0ó… ÿÿÿó~BLfÖ…$ÿÿÿó~BTfÖ…,ÿÿÿó~B\fÖ…4ÿÿÿó~BdfÖ…<ÿÿÿó~BlfÖ…Dÿÿÿó~BtfÖ…LÿÿÿDüÿÿè
;' 0üÿÿè?J' ‹óà=“~$W…0üÿÿ‰4üÿÿPÇ…0üÿÿ   ‹SxQ‹€   ‰•8üÿÿó$è°…' ƒ¾ø   ó‹p  óMÇEìx   t÷è+Õ   tóà=“óMÇEì    óF óó\ĞóYÑóXĞóV èTœâÿ‹Èè½NI ƒøt\WÀéØ   ƒgş…Ét"‹E‹UÜ‹IP‹EèRPèä¾ÿÿ‹Mì‹AƒÄéIõÿÿ…À„>õÿÿ‹U‹MÜR‹UèQ‹HRèº¾ÿÿ‹Eğ‹@ƒÄéõÿÿè7Àáÿ‹È‰Mèƒùÿtp¡Ä+Õ‹€8	  …Àta·ù;¸   sVŠˆd  Óï‹ˆd  º   Óâ·MèJ#Ñ‹ˆ   iÒT  ‹<¹‹Eè9:u#‹Œ:à   QèóÓ` ƒÄ‹øèIâÿ9GHvóGDëóF ~8WQó$•àıÿÿR…\üÿÿPè;ÆÿÿóEƒÄ†¼  PQó$WPèÆÿÿó“Ü   ó\V(óMóYÑóXV(óV(ó“à   ó\V,óYÑóXV,óV,ó“ä   ó\V0óYÑóXV0óV0Ç†ø     èzÒÿÿ‹M‹“°   QRèZ«ÿÿ‹»´   ƒÄ;~„&  ƒ~ÿt2‹FPè‰f ƒÄ…Àtƒ} t‹NQè% ƒÄë‹ÈèG= ÇFÿÿÿÿƒÿÿ„â   MŒè/E ó\±¯ó…hÿÿÿó`±¯ó…lÿÿÿód±¯ó…pÿÿÿóh±¯ó…tÿÿÿól±¯ó…xÿÿÿóp±¯ó…|ÿÿÿót±¯MŒ‰½dÿÿÿóE€ÇE„    ÇEˆÿÿÿÿè¦D óà=“óEÀóYàóEÈóYà3À•dÿÿÿóEÌóYàR‰E¸‰E¼‰EÄóEĞè[0 ƒÄ‰F‰~öCtVèféÿÿƒÄ‹Îèüíÿÿƒ»Ğ   ÿt
SVè¼ãÿÿƒÄ‹Eì‹‹¸   j PjQèõú  ƒÄÇEüÿÿÿÿ‹èÓUR‰]è‰cI ‹Mô_^[d‰    ‹å]ÃÌÌÌÌÌÌÌÌU‹ì‹EV‹°p  jPèkïÿÿƒÄF8P¼  è‰²ÿÿÙF$‹Ü  Ù^ ó~†Ô  fÖ†à  fÖ†ì  ‹Ñ‰è  ‰–ô  ^]ÃÌÌÌÌU‹ìjÿhĞ_d¡    Pd‰%    ƒìSV‹Ù³`  W3ÿ‰>‰~‰~‰~‰uğƒÆF0j‰ƒÀ0¹   hÿ   P‰]ì‰N‰NÇF   ‰~‰~‰~‰~ ÇF(   ‰F$èG—r ÇF,ğ`‰}ü‹Eğ‰pÇEü   ‰»  ‰»  ‰»  ‰»  ³  ‰uğƒÆF0j‰ (  ¹   hÿ   P‰N‰NÇF   ‰~‰~‰~‰~ ÇF(   ‰F$èÍ–r ƒÄÇF,ğ`ÆEü‹Mğ‰qÆEü‰»$-  ‰»(-  ‰»,-  ÇEüÿÿÿÿ‹Mô_^‹Ã[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌU‹ìV‹ñè%áÿÿöEt	Vè)—r ƒÄ‹Æ^]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhñ_d¡    Pd‰%    ƒì8VWj3öVjhh-  èâ˜r ƒÄ‰Eğ‰Eì‰uü;Æt	‹ÈèKşÿÿ‹ğƒÏÿ‰}üóà=“‰¾Ô  ‰¾Ø  ‰¾Ü  ó~†Ô  fÖ†à  fÖ†ì  WÀ‰~‰~‰~‰~‰~‰~óE¼óEÀó~U¼‹Ç‰†è  ‹Ï‰ô  fÖ¸VÎóEÄóMÈó~UÄfÖÀVÎóEóÈVÎó°[‚óÌVÎó¬[‚óĞVÎó¨[‚óÔVÎóE¼óEÀó~U¼fÖìVÎóEÄóMÈó~UÄfÖôVÎóEÌóEĞó~UÌfÖüVÎóEÔóMØó~UÔfÖWÎóEÜóEàó~UÜfÖWÎóEäóMèó~UäfÖWÎóE¼óEÀó~U¼óEÄóMÈfÖ0WÎó~UÄóØVÎóÜVÎóàVÎóäVÎóèVÎóWÎó WÎó$WÎó(WÎó,WÎfÖ8WÎóEÌóEĞóEÔó~UÌfÖ@WÎóMØó~UÔfÖHWÎóEÜóEàó~UÜfÖPWÎóEäóMèó~UäfÖXWÎóE¼óEÀó~U¼fÖtWÎóEÄóMÈó~UÄfÖ|WÎóEÌóEĞó~UÌfÖ„WÎóEÔóMØó~UÔfÖŒWÎóEÜóEàó~UÜfÖ”WÎóEäóMèó~UäfÖœWÎóE¼óEÀó~U¼fÖ¸WÎóEÄóMÈó~UÄfÖÀWÎóEÌóEĞó~UÌfÖÈWÎóEÔóMØó~UÔfÖĞWÎóEÜóEàó~UÜfÖØWÎóEäóMèó~UäfÖàWÎóE¼óEÀó~U¼ó`WÎódWÎóhWÎólWÎópWÎó¤WÎó¨WÎó¬WÎó°WÎó´WÎóèWÎóìWÎóğWÎóôWÎóøWÎóEÄóMÈfÖüWÎó~UÄfÖXÎóEÌóEĞó~UÌfÖXÎóEÔóMØó~UÔfÖXÎóEÜóEàó~UÜóEäóMèfÖXÎó~Uäh¸VÎN8fÖ$XÎó,XÎó0XÎó4XÎó8XÎè'¬ÿÿh¸VÎ¼  è¬ÿÿWÀóà=“UàREĞóEàóEäóEĞóEÔóEØóEÀó¤[‚PMÀóEÄó Z‚Q@  óMèóEÈèø’t ‹MôÇ†\  ,  ‰¾-  ‰¾-  ‰¾-  ‰¾-  ‰¾ -  ‰¾è,  ‰¾ì,  ‰¾ğ,  ‰¾ô,  ‰¾ø,  ‰¾ü,  ‰¾ -  ‰¾-  ‰¾-  ‰¾-  ‰~4‰¾0-  _‹Æ^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌU‹ìV‹u…öt‹Îè>ÛÿÿVèH‘r ƒÄ^]ÃÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌU‹ì3Àƒ}ÿ•ÀH]ÃÌV‹ñ‹†p  PÇ¼[‚è«ÿÿÿ‹t  Qè™ ƒÄ^ÃÌÌÌÌÌÌÌÌÌÌSV‹ÙWKèCûşÿs,¿   ‹Îè4ûşÿƒÆOuó_^K\[é#ûşÿÌÌÌVWj j ‹ñ‹†`  ‹Øõ°j j Pè²¯I Ç†`  ÿÿÿÿÆğ   ¿   ‹Nj j j j Q‹Øõ°è†¯I ‹‹Øõ°j j j j Rèp¯I ÇFÿÿÿÿÇÿÿÿÿƒÆOuÀ_^ÃÌÌÌÌÌÌÌÌÌÌSV‹ÙWKèûşÿs,¿   ‹ÎèôúşÿƒÆOuó_^K\[éãúşÿÌÌÌSV‹ÙWKècûşÿs,¿   ‹ÎèTûşÿƒÆOuó_^K\[éCûşÿÌÌÌSV‹ÙWKèó9ÿÿs,¿   ‹Îèä9ÿÿƒÆOuó_^K\[éÓ9ÿÿÌÌÌSV‹ÙWKèCÿÿs,¿   ‹Îè4ÿÿƒÆOuó_^K\[é#ÿÿÌÌÌV‹ñ‹Fxj PèÒ_×ÿ‹N|Qèù_×ÿƒÄ^ÃÌÌÌÌU‹ìì€   SV‹u‹Ùƒşÿ„‘   èb×ÿƒøu~WèÇ"×ÿ‹ğ¹   }Àó¥èæ#×ÿ‹ğ‹Ej ¹   }€Pó¥èo_×ÿjÿè˜_×ÿ‹CxƒÄPjFèJ\J ƒÄPèqiÿÿ‹Kxj QèF_×ÿ‹S|Rèm_×ÿEÀPètO×ÿM€Qè+W×ÿƒÄ_^[‹å]Â Vèya×ÿƒÄ^[‹å]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌ‹AÃÌÌÌÌÌÌÌÌÌÌÌÌAÃÌÌÌÌÌÌÌÌÌÌÌÌéëi×ÿÌÌÌÌÌÌÌÌÌÌÌè‹âÿ‹Èèô@I 3Éƒø•Á‹ÁÃÌÌÌÌÌÌÌÌÌé{±âÿÌÌÌÌÌÌÌÌÌÌÌ¡Ä+Õ‹€¨	  ÃÌÌÌÌ3À‰‰A‰AÃÌÌÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EPè´Gs ƒÄ]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹E…    QèmGs ƒÄ]Â ÌÌÌÌÌÌU‹ì‹E]ÃÌÌÌÌÌÌÌÌU‹ì‹E‹‹U‰
]ÃÌU‹ì‹M‹EV+ÁW‹}Áø4…    VQWÿ|ˆ{ƒÄ>_^]ÃÌÌÌÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿh_d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿ‹†p  PÇ¼[‚èÈûÿÿ‹t  Qè,• ‹MôƒÄ^d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌS‹Ä+ÕVW¹TXÎèM÷şÿ¾lXÎ¿   I ‹Îè9÷şÿƒÆOuó¹œXÎè)÷şÿ‹‹¨	  …Ét	‹‹WÿÒë3ÀPè®Œr ƒÄ_^Çƒ¨	      [ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìV‹ñ‹†p  PÇ¼[‚èûÿÿ‹t  Qè|” ƒÄöEt	Vè]Œr ƒÄ‹Æ^]Â ÌÌÌ‹ÁÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹ES‹]VW‹ñj SN‰†d  èöşÿ~,ÇE   ¤$    j S‹ÏèöõşÿƒÇÿMuîj SN\èãõşÿWÀ‹M‹UóFóFóFÇF    _‰h  ‰–l  ^[]Â ÌU‹ìƒì0SV‹ñ‹‹PWMĞQ‹Î‰uäÿÒ‹}Ô‹]Ğ‰}Ø‰}ìè´×ÿƒøtèšSÿÿ÷ØÀƒà‰EøëÇEø*   èB×ÿ‰Eà3À‰Eü‹Mø‰MôƒÉÿ‰Mè‰Œ†€   ‰Œ†ğ   ƒø‡7  ¶g· ÿ$•èf· è×ÿ…À„  ‹óé  è ×ÿ…À„  è3×ÿƒø„ú   è%×ÿƒø„ì   è×ÿƒø„Ş   ‹óéİ   èòRÿÿ…Àu‹Eø‰Eô‹óéÇ   è\oÙÿ‹ÈèÅ&Ùÿ…À„ª  é¨   ¾    ÇEè   ‹şé›   è°Rÿÿ…À„…  ‹óé‡   è¬×ÿƒøtè¢×ÿƒøtè˜×ÿƒø…\  ÇEô   ‹óëZè×ÿƒøtèu×ÿƒøtèk×ÿƒø…/  ÇEô   ë)èT×ÿƒøtèJ×ÿƒøtè@×ÿƒø…  ÇEô    ‹óÑîÑïÇEğ    è×ÿƒøu`‹EüƒètƒèuSë	èÅ×ÿ…ÀtH‹Œ±‹‹’Ì   EğP‹Eìjjj jP‹EøSPÿÒ‹Œ±‹‹€Ì   UğR‹Uìjjj jRSjÿĞ‹Mğ‹Eôj Q‹Müjjj WVUôRPQèJDÿÿƒÄPèñàØÿ‹Uä‹MüƒÄ(‰„Š€   ƒøÿ„„   ‹Eèƒøÿt7‹Uğj Rjjj WV‹uüMèQPVèDÿÿƒÄPè«àØÿ‹UäƒÄ(‰„²ğ   ƒøÿt2‹uä‹}ì‹Eü@‰EüƒøŒ™ıÿÿ¡è„|‰EğèQÿÿ…Àt'‹    ‰Mğë?h\‚j jjè·÷r ƒÄ_^3À[‹å]Ãèæ×ÿƒøu‹Uøj j jj WSRè®ÌØÿƒÄ‰Eğèƒ×ÿ…Àt	‹†¼   ‰Eğèq×ÿ…Àt@è¨"×ÿ‹MØj j jjj Q‹ÓRMäQPj‰Eäè8CÿÿƒÄPèßßØÿƒÄ(‰†À   ƒøÿ„fÿÿÿèh"×ÿj j jjj WSUìRPj
‰EìèıBÿÿƒÄPè¤ßØÿƒÄ(‰†¨   ƒøÿ„+ÿÿÿè-×ÿƒøtè#×ÿƒøt
è×ÿƒøu6‹Mìj j jjj WSEìPQjè©BÿÿƒÄPèPßØÿƒÄ(‰†¬   ƒøÿ„×şÿÿ‹UìRhà[‚j jjèŠör ƒÄèÂ×ÿƒøtè¸×ÿƒøt‹†¨   ë‹†¬   ‹Mğ‰Nx‰F|èW×ÿ…Àt;‹Uà‹Eøj j Rjj WSMØQPj‰EØè#BÿÿƒÄPèÊŞØÿƒÄ(‰†È   ƒøÿ„Qşÿÿè×ÿ…Àt=èJ!×ÿ‹Uàj j Rjj WSMØQPj‰EØèİAÿÿƒÄPè„ŞØÿƒÄ(‰†Ì   ƒøÿ„şÿÿº   ;ÓÀ%      ‰Eìè‡$×ÿƒø|è]kÙÿ‹Èèö"Ùÿ…Àu	‹Eì ‰Mìè´×ÿö  u¸   9Eì|‰Eì‹Eìj j jjj PPUØRj hØ[‚ÇEØ    èüİØÿƒÄ(‰†`  èşjÙÿ‹Èèg"Ùÿ…À~?è~ ×ÿj j jjj ÑïWÑëSMØQPj‰EØèAÿÿƒÄPè¶İØÿƒÄ(‰†˜   ƒøÿ„=ıÿÿ_^¸   [‹å]ÃÔa· b· ğb· /b· Ûa· [b· Ça· Hb· Çb· ob· œb· ğc·   	

ÌÌÌÌÌÌÌÌÌÌÌÌU‹ì‹EÙ ÙYÙ@ÙYÙ@‹EÙY‰A]Â ÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìQWÀV‹ñW~óEüè¸¨âÿPèâ¾` ƒÄ…Àtó¸YÎóY8=“óEüj
èOÅG ƒÄ…Àt)èS©áÿƒx<uó¼YÎóXEüQó$èõ¹ãÿÙ]üƒÄóEü‹†l  Qó$WPè½ôÿWjè»ôÿƒÄ_^‹å]ÃÌÌÌÌÌÌU‹ìV‹uFPVèÿ×ÿƒÄ‹Æ^]Â ÌÌÌÌÌU‹ìV‹uFPVè×ÿƒÄ‹Æ^]Â ÌÌÌÌÌU‹ìƒìƒy ‰MøÇEü    vQSVWëëI ‹Ê‹A‹Mü‹4ˆNèİïşÿ~,»   ëI ‹ÏèÉïşÿƒÇKuóN\è»ïşÿ‹Eü‹Uø@‰Eü;Br¼_^[‹å]ÃÌÌÌÌÌU‹ìƒìƒy ‰MøÇEü    vQSVWëëI ‹Ê‹A‹Mü‹4ˆNè-.ÿÿ~,»   ëI ‹Ïè.ÿÿƒÇKuóN\è.ÿÿ‹Eü‹Uø@‰Eü;Br¼_^[‹å]ÃÌÌÌÌÌU‹ìƒìƒy ‰MøÇEü    vQSVWëëI ‹Ê‹A‹Mü‹4ˆNè=ùşÿ~,»   ëI ‹Ïè)ùşÿƒÇKuóN\èùşÿ‹Eü‹Uø@‰Eü;Br¼_^[‹å]ÃÌÌÌÌÌU‹ìƒìƒy ‰MøÇEü    vQSVWëëI ‹Ê‹A‹Mü‹<ˆOèıíşÿw,»   ëI ‹ÎèéíşÿƒÆKuóO\èÛíşÿ‹Eü‹Uø@‰Eü;Br¼_^[‹å]ÃÌÌÌÌÌVW‹ù3ö9wv)ëI ‹G‹°‹‹BÿĞ…Àt‹O‹±‹‹BÿĞF;wrÜ_^ÃÌÌÌÌÌÌÌÌÌ‹A‹ ÃÌÌÌÌÌÌÌÌÌÌ‹A‹ ÃÌÌÌÌÌÌÌÌÌÌ‹Á3É‰‰H‰HÃÌÌÌU‹ì‹Q‹ÂÑèÂ‹U;ÂBÂ‰AÀÀPèÿ;s ƒÄ]Â ÌÌÌÌÌÌÌÌÃÌÌÌÌÌÌÌÌÌÌÌÌÌÌÌV‹ñƒÊÿÇ¼[‚‰Vx‰V|†ğ   ¹   I ‰P‰ƒÀIuõ3À‰–`  ‰–d  ‰†h  ‰†l  èæêÿÿ‰†p  è ‰†t  ‹Æ^ÃÌ‹Pè˜;s YÃÌÌÌÌÌÌU‹ì‹UV‹ñ‹N;ÑvB‹ÁÑèÁ;ÂBÂ‰FÀÀWPèG;s ‹NÉÉÁùÉ‹ø‹ÉQPWÿ|ˆ{‹RèD;s ƒÄ‰>_^]Â ÌÌÌÌÌÌÌÌÌU‹ìjÿh(_d¡    Pd‰%    QV‹ñ‰uğèÿÿÿÇEü    Ç\‚ÇEüÿÿÿÿ‹Mô‹Æ^d‰    ‹å]ÃÌÌÌÌÌÌÌU‹ìjÿhH_d¡    Pd‰%    QV‹ñ‰uğÇEüÿÿÿÿ‹†p  PÇ¼[‚èˆïÿÿ‹t  Qèìˆ ƒÄöEt	VèÍ€r ƒÄ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌÌU‹ìjÿhk_d¡    Pd‰%    Q‹Á3ÉÇ 8\‚‰Eğ‰H‰H‰H‰Mü‰HÇEüÿÿÿÿ‹Môd‰    ‹å]ÃÌÌÌÌÌÌU‹ìjÿh‹_d¡    Pd‰%    Q‰MğÇ8\‚ÇEüÿÿÿÿ‹APèî9s ‹MôƒÄd‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌÌÌU‹ìVW‹}‹ñ+>‹NÁÿ9NuIQ;ÑvB‹ÁÑèÁ;ÂBÂ‰FÀÀSPèy9s ‹NÉÉÁùÉ‹Ø‹ÉQPSÿ|ˆ{‹Rèv9s ƒÄ‰[‹F‹;øs‹¹‰ÿF_^]Â ‹U‹‰ÿF_^]Â ÌÌÌÌÌÌÌU‹ìjÿh«_d¡    Pd‰%    QV‹ñ‰uğÇ8\‚ÇEüÿÿÿÿ‹FPè9s ƒÄöEt	Vè<r ƒÄ‹Mô‹Æ^d‰    ‹å]Â ÌÌÌÌÌÌU‹ìV‹ñEPNèşşÿÿƒ~uÇF@XÎ^]Â ÌÌÌÌÌÌÌÌÌÌÌÌU‹ìjÿhÜ_d¡    Pd‰%    ƒìSV‹5Ä+Õj3ÛSjjè¿€r ƒÄ‰Eğ‰Eì‰]ü;ÃtÇ 8\‚‰X‰X‰XÆEü‰Xˆ]üë3ÀÇEüÿÿÿÿjSSS¹@XÎ‰†¨	  è6òÿÿ¡Ä+Õ‹°¨	  MğQNÇEğ@XÎèHşÿÿƒ~uÇF@XÎ‹Mô^[d‰    ‹å]ÃÌÌÌÌÌÌÌÌÌÌÌU‹ì‹MI3Àƒùw(¶‰o· ÿ$o· ¸   ]Ã¸   ]Ã¸   ]Ã¸   ]Ãìn· ón· ún· o·     ÌÌÌÌÌÌÌÌÌÌÌÌU‹ìƒìf‹Ef‰MöS‹]f‰EôI3ÀV‰Uøƒùw(¶‰èo· ÿ$Øo· ¸   ë¸   ë¸   ë¸   ¯Â‹ğƒşw
‹U‹‰Eüë‹‰Mü‹‹Mh†   jREôPQè&ys ƒƒÄƒşv‹‹E‹Mh†   VRPQèys ƒÄ3^[‹å]Ã‹ÿ`o· go· no· uo·     ÌÌÌÌÌÌÌÌÌÌÌÌU‹ììP  SV°şÿÿèêrs ‹]‹Ã¯Ej j jPèÕ~r ‹M‹Ujÿjj SQ‹ğ‹ERVP‰uèè×ªıÿ¯]j3ÀMìh<\‚QfÇEì  ‰Eîf‰Eòÿ8ˆ{‹EP°şÿÿº*   Qf‰UîÇEğ   è£{s •°şÿÿƒÄDRèDts …°şÿÿjPèus ƒÄ…À„s  Wh†   jj MìQ•°şÿÿRèxs h†   jjEP°şÿÿQÇE
   èáws ·E‹Mh†   j4@j
UôR…°şÿÿ¿   P4µ   ÇEô  ‰}ø‰Müè¥ws ‹Eh†   jjMôQ•°şÿÿRÇEô ‰}ø‰Eüè|ws ƒÄPh†   ¸   j‰EØ‰Eøj"EôP°şÿÿQÇEà  ÇEä  ÇEô ‰uüè=ws h†   jVUàR…°şÿÿPè%ws h†   jj.EôƒÆ‰}ÄÇEô ‰}ø‰}üP°şÿÿQèùvs h†   j¸   j:Uô‰EĞ‰EüR…°şÿÿPÇEô ‰}øèËvs ‹EØƒÄPh†   jjFMôQ•°şÿÿRÇEô ‰}ø‰EüèŸvs h†   ƒÈÿj‰EÌ‰EüjREôP°şÿÿQÇEô ‰}øèsvs h†   jj^MôQ•°şÿÿR‰}ÔÇEô( ‰}ø‰}üèJvs h†   jjjUôR…°şÿÿP‰uÀÇEô ‰}ø‰uüè!vs ƒÄPh†   jjvEôP°şÿÿQ‰]ÈÇEô ‰}ø‰]üèõus h†   ÇEÜ    jh‚   UÜR…°şÿÿPèÒus ‹Mèh†   SVQ•°şÿÿRè»us …°şÿÿPèts ‹uèƒÄ@_j Vè xr ƒÄ^[‹å]ÃÌÌÌÌÌÌÌU‹ììH  W¸şÿÿè«os ‹}¯}3À
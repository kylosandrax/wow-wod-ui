--[[ 
  @file       ogear.lua
  @brief      warcraft addon to display gear stats

  @author     rmcinnis
  @date       september 23, 2014  (originally from oQueue, started on april 06, 2012)
  @copyright  Solid ICE Technologies
              this file may not be redistributed without expressed permission.
              no modifications are allowed even for personal use.
              if this file is posted to a web site, credit must be given to me along with a link to my web page
              no code in this file may be used in other works without expressed permission  
]]--
local addonName, OG = ... ;
OG._T = {} ; -- used for literal string conversations
local function defaultFunc(L, key)
 -- If this function was called, we have no localization for this key.
 -- We could complain loudly to allow localizers to see the error of their ways, 
 -- but, for now, just return the key as its own localization. This allows you to—avoid writing the default localization out explicitly.
 return key;
end
setmetatable(OG._T, {__index=defaultFunc}) ;
local L = OG._T ; -- for literal string translations
if (OG.table == nil) then
  OG.table = {} ;
end
local tbl = OG.table ;

-------------------------------------------------------------------------------
local OG_MAJOR                 = 0 ;
local OG_MINOR                 = 1 ;
local OG_REVISION              = 7 ;
local OG_BUILD                 = 017 ;
local OG_SPECIAL_TAG           = "" ;
local OG_VERSION               = tostring(OG_MAJOR) ..".".. tostring(OG_MINOR) ..".".. OG_REVISION ;
local OG_VER_STR               = tostring(OG_MAJOR) .. tostring(OG_MINOR) .. tostring(OG_REVISION) ;
local gem_colors ;
local __gems ;
local __info ;
local __ilink_info ;
local find_slot_id = 0 ;

local og = {} ;

function OG:mod()  return og ; end

SLASH_OGEAR1 = '/ogear' ;
SLASH_OGEAR2 = '/og' ;
SlashCmdList["OGEAR"] = function (msg, editbox)
  if (msg == nil) or (msg == "") then
    og.usage() ;
    return ;
  end
  local arg1 = msg ;
  local opts = nil ;
  if (msg ~= nil) and (msg:find(" ") ~= nil) then
    arg1 = msg:sub(1,msg:find(" ")-1) ;
    opts = msg:sub(msg:find(" ")+1,-1) ;
  end
  if (og.options[ arg1 ] ~= nil) then
    og.options[ arg1 ]( opts ) ;
  end
end

function og.hook_options()
  og.options = tbl.new() ;
  og.options[ "?"       ] = og.usage ; 
  og.options[ "hilite"  ] = og.toggle_gear_hilite ;
  og.options[ "hilight" ] = og.toggle_gear_hilite ;
  og.options[ "inspect" ] = og.toggle_auto_inspect ;
  og.options[ "off"     ] = function() og.use_ogear(0) end ;
  og.options[ "on"      ] = function() og.use_ogear(1) end ;
  
  og.options[ "slot"    ] = function(opt) find_slot_id = tonumber(opt) ; print( "watch-slot: ".. tostring(find_slot_id) ) ; end ;
  
end

function og.toggle_auto_inspect()
  if (OGEAR.ok2autoinspect == 1) then
    OGEAR.ok2autoinspect = 0 ;
    print( "oGear auto-inspect:  OFF" ) ;
  else
    OGEAR.ok2autoinspect = 1 ;
    print( "oGear auto-inspect:  ON" ) ;
  end
end

function og.toggle_gear_hilite()
  if (OGEAR.show_gearhilight == 1) then
    OGEAR.show_gearhilight = 0 ;
    print( "oGear highlight:  OFF" ) ;
  else
    OGEAR.show_gearhilight = 1 ;
    print( "oGear highlight:  ON" ) ;
  end
end

function og.use_ogear(state)
  OGEAR._paperdoll_show_ilevel = state or 1 ;
  og.toggle_show_ilevel( OGEAR._paperdoll_show_ilevel ) ;
  if (state == 1) then
    print( "oGear:  ON" ) ;
  else
    print( "oGear:  OFF" ) ;
  end
end

function og.version_banner()
  print( "oGear v".. OG_VERSION .."  build ".. OG_BUILD ) ;
end

function og.usage()
  og.version_banner() ;
  
  print( "  /og highlight    toggle gear pve/pvp highlight; blue == pve, red == pvp" ) ;
  print( "  /og inspect      toggle auto inspect on ctrl-left click" ) ;
  print( "  /og [on | off]   enable / disable oGear (same as checkbox on paperdoll)" ) ;
end

function og.init()
  og.hook_options() ;
  
  og.timer_oneshot(  2, og.post_load_hooks ) ;
  
  if (InspectFrame == nil) then
    LoadAddOn("Blizzard_InspectUI") ; -- make sure its loaded
  end
end

function og.moveto( f, x, y ) 
  if (y >= 0) then
    if (x >= 0) then 
      f:SetPoint("TOPLEFT",f:GetParent(),"TOPLEFT", x, -1 * y)
    else
      f:SetPoint("TOPRIGHT",f:GetParent(),"TOPRIGHT", x, -1 * y)
    end
  else
    if (x >= 0) then 
      f:SetPoint("BOTTOMLEFT",f:GetParent(),"BOTTOMLEFT", x, -1 * y)
    else
      f:SetPoint("BOTTOMRIGHT",f:GetParent(),"BOTTOMRIGHT", x, -1 * y)
    end
  end
end

function og.checkbox( parent, x, y, cx, cy, text_cx, text, is_checked, on_click_func )
  local button = CreateFrame("CheckButton", "OG_Check", parent, "UICheckButtonTemplate")
  button:SetWidth(cx)
  button:SetHeight(cy)
  button.string = button:CreateFontString()
  button.string:SetWidth(text_cx)
  button.string:SetJustifyH("LEFT")
  button.string:SetPoint("LEFT", 24, 1)
  button:SetFontString(button.string)
  button:SetNormalFontObject("GameFontNormal")
  button:SetHighlightFontObject("GameFontHighlight")
  button:SetDisabledFontObject("GameFontDisable")
  button:SetText(text)
  button:SetScript("OnClick", on_click_func )
  if (is_checked == 0) then
    is_checked = nil ;
  end
  button:SetChecked( is_checked ) ;
  
  local font = button:GetNormalFontObject();
  font:SetTextColor( 0.9, 0.9, 0.9, 1.0) ;
  button:SetNormalFontObject(font);
  
  og.moveto( button, x, y ) ;
  button:Show() 
  return button ;
end

function og.label( parent, x, y, cx, cy, text, justify_v, justify_h, font, strata )
  local label = parent:CreateFontString( parent:GetName() .."_OGText", strata or "ARTWORK", font or "GameFontNormalSmall")
  label:SetWidth( cx ) ;
  label:SetHeight(cy or 25) ;
  if (justify_v == "CENTER") then
    justify_v = "MIDDLE" ;
  end
  label:SetJustifyV( justify_v or "MIDDLE" )
  label:SetJustifyH( justify_h or "LEFT" )
  label:SetText( text )
  label:Show() 
  og.moveto( label, x, y ) ;
  return label ;
end

function og.init_locals()
  if (og._tok_cnt) then
    return ; -- only initialize once
  end
  tbl.init() ;
  
  gem_colors       = gem_colors      or tbl.new() ;
  __gems           = __gems          or tbl.new() ;
  __info           = __info          or tbl.new() ;
  __ilink_info     = __ilink_info    or tbl.new() ;
  og.__frame_pool  = og.__frame_pool or tbl.new() ;
  og._tok_cnt      = 0 ;
  
  og.register_events() ;
end  

function og.load_og_data()
  if (OGEAR == nil) then 
    OGEAR = tbl.new() ;
    OGEAR._paperdoll_show_ilevel = 1 ;
    OGEAR.show_gearhilight       = 1 ;
    OGEAR.ok2autoinspect         = 1 ;
  end
end

function og.on_addon_loaded( name )
  if (name == addonName) then
    og.load_og_data() ;
    og.init_locals() ;
    og.init() ;
  end
end

function og.on_event(self,event,...)
  if (og.msg_handler[event] ~= nil) then
    og._event = event ;
    og.msg_handler[event]( ... ) ;
  end  
end

function og.on_equipment_changed()
  og.paperdoll_update( PaperDollFrame, "player" ) ;
end

function og.on_inspect_ready( unit_id )
  -- update every 1/2 second for 2 seconds to insure data comes in (caching from server)
  if (og.timers["og_inspect_frame"] == nil) then
    -- first time
    og.paperdoll_update( InspectFrame, "target" ) ;
  end
  local now = GetTime() ;
  if (og._last_inspect_tm) and ((now - og._last_inspect_tm) < 0.5) then
    return ;
  end
  og._last_inspect_tm = now ;
  og.paperdoll_update( InspectFrame, "target" ) ;
  og.timer( "og_inspect_frame", 0.50, og.paperdoll_update, nil, InspectFrame, "target" ) ;
end

function og.on_player_target_change()
  if ((OGEAR.ok2autoinspect == 1) and IsControlKeyDown() and UnitIsFriend("player","target") and CanInspect("target") and not InCombatLockdown()) then
    og.paperdoll_clear( InspectFrame ) ;
    InspectUnit("target") ;
  end
end

function og.post_load_hooks()
  og.hook_paperdoll() ;
  og.hook_inspectdoll() ;
  og.hook_options_menu() ;
  
  if (EquipmentFlyout_DisplayButton) then
    og.old_flyout = EquipmentFlyout_DisplayButton ;
    EquipmentFlyout_DisplayButton = OG_EquipmentFlyout_DisplayButton ;
  end
end

function og.ScanningTooltip() 
  if (og._tooltip == nil) then
    local g = CreateFrame( "GameToolTip", "OGearScanningTooltip", nil, "GameTooltipTemplate" ) ;
    g:SetOwner( UIParent, "ANCHOR_NONE" ) ;
    og._tooltip = g ;
  end
  -- clear tooltip
  og._tooltip:ClearLines() ;
  
  return og._tooltip ;
end

local S_ITEM_LEVEL = ITEM_LEVEL:gsub( "%%d", "(%%d+)" )
local __enchantable = { [  1 ] = nil , -- head
                        [  2 ] = nil , -- neck
                        [  3 ] = true, -- shoulder
                        [ 15 ] = true, -- back
                        [  5 ] = true, -- chest
                        [  9 ] = true, -- wrist
                        [ 10 ] = true, -- hands
                        [  6 ] = nil , -- waist
                        [  7 ] = true, -- legs
                        [  8 ] = true, -- feet
                        [ 11 ] = nil , -- finger0
                        [ 12 ] = nil , -- finger1
                        [ 13 ] = nil , -- trinket0
                        [ 14 ] = nil , -- trinket1
                        [ 16 ] = true, -- main hand
                        [ 17 ] = true, -- off hand
                      } ;

local __enchantable600 = { [  1 ] = nil , -- head
                        [  2 ] = true, -- neck
                        [  3 ] = nil , -- shoulder
                        [ 15 ] = true, -- back
                        [  5 ] = nil , -- chest
                        [  9 ] = nil , -- wrist
                        [ 10 ] = nil , -- hands
                        [  6 ] = nil , -- waist
                        [  7 ] = nil , -- legs
                        [  8 ] = nil , -- feet
                        [ 11 ] = true, -- finger0
                        [ 12 ] = true, -- finger1
                        [ 13 ] = nil , -- trinket0
                        [ 14 ] = nil , -- trinket1
                        [ 16 ] = true, -- main hand
                        [ 17 ] = true, -- off hand
                      } ;

local function printable( ilink )
   return gsub(ilink, "\124", "\124\124");
end

function og.nGems_from_ilink( ilink ) 
  if (ilink == nil) then
    return 0, nil, nil, nil, nil ;
  end
  tbl.fill_match( __ilink_info, ilink, ":" ) ;
  
  local item_id      = __ilink_info[2] ;
  local enchant_id   = __ilink_info[3] or 0 ;
  local enchant_text = "" ;
  local is_pvp       = 0 ;
  if (item_id == nil) then
    return 0, nil, nil, nil, nil ;
  end
  gem_colors[1] = nil ;
  gem_colors[2] = nil ;
  gem_colors[3] = nil ;
  gem_colors[4] = nil ;
  __gems[1]     = nil ;
  __gems[2]     = nil ;
  __gems[3]     = nil ;
  __gems[4]     = nil ;
  __gems[5]     = nil ;
  
  tbl.fill( __info, GetItemInfo( item_id ) ) ;    
  
  local name   = __info[1] ;
  local iid    = __info[4] ;
  local ibare  = __info[2] ; 
  local line   = nil ;
  local ilevel = 0 ;
  if (ibare == nil) then
    return 0, nil, nil, nil, nil, nil, nil ;
  end
--  local g = scantip ;
  local g = og.ScanningTooltip() ;
  g:SetOwner( UIParent, "ANCHOR_NONE" ) ;
--  g:SetHyperlink( ibare ) ;
  g:SetHyperlink( ilink ) ; -- to get the actual ilevel info
  g:Show() ;
  local i = 0 ;
  local ngems = 0 ;
  for i=1,g:NumLines() do 
    local mytext=_G[ g:GetName() .."TextLeft"..i] ;
    if (mytext ~= nil) then
      local line = mytext:GetText() ;
      local plain = printable( line ) ;
      if (plain) then
        if plain:find( L[" Socket"] ) or plain:find( L["Prismatic Socket"] ) then
          ngems = ngems + 1 ;
          gem_colors[ngems] = line:sub( 1, line:find( L[" Socket"] ) - 1) ;
        elseif plain:find( L["Sha--Touched"] ) and (plain:find("\"".. L["Sha--Touched"] .."\"") == nil) then
          ngems = ngems + 1 ;
          gem_colors[ngems] = "sha" ;
        elseif plain:find( L["PvP Power"] ) then
          is_pvp = is_pvp + 1 ;
        end
      
        local n = tonumber( line:match(S_ITEM_LEVEL) ) ;
        if n then
          ilevel = n ;
        elseif (plain:find( L["Enchanted:"] )) then
          enchant_text = line ;
        end
      end
    end
  end
  g:Hide() ;
--  _, __gems[1] = GetItemGem( ilink or ibare, 1 ) ;
--  _, __gems[2] = GetItemGem( ilink or ibare, 2 ) ;
--  _, __gems[3] = GetItemGem( ilink or ibare, 3 ) ;
--  _, __gems[4] = GetItemGem( ilink or ibare, 4 ) ;
  local i ;
  for i=ngems,4 do
    _, __gems[i] = GetItemGem( ilink or ibare, i ) ;
    if (__gems[i]) then 
      ngems = ngems + 1 ;
    end
  end

  return ngems, __gems[1], __gems[2], __gems[3], __gems[4], 
                gem_colors[1], gem_colors[2], gem_colors[3], gem_colors[4], 
                enchant_id, enchant_text,
                ilevel, is_pvp ;
end

function og.nGems( target, slot )
  return og.nGems_from_ilink( GetInventoryItemLink( target, slot ) ) ;
end

OG.EMPTY_GEMSLOT =   "|TInterface\\TARGETINGFRAME\\UI-PhasingIcon.blp:16|t" ;
function og.gem_string( ngems, gem1, gem2, gem3 )
  local gstr = "" ;
  if (ngems >= 1) then
    if (gem1) then
      gstr = gstr .."|T".. select( 10, GetItemInfo(gem1)) ..".blp:14|t " ;
    else
      gstr = gstr .."".. OG.EMPTY_GEMSLOT ;
    end
  end   
  if (ngems >= 2) then
    if (gem2) then
      gstr = gstr .."|T".. select( 10, GetItemInfo(gem2)) ..".blp:14|t " ;
    else
      gstr = gstr .."".. OG.EMPTY_GEMSLOT ;
    end
  end   
  if (ngems >= 3) then
    if (gem3) then
      gstr = gstr .."|T".. select( 10, GetItemInfo(gem3)) ..".blp:14|t" ;
    else
      gstr = gstr .."".. OG.EMPTY_GEMSLOT ;
    end
  end   
  return gstr ;
end

function og.paperdoll_overlay( frame, is_on )
  local i, p ;
  for i,p in pairs( frame._ilevels ) do
    if (is_on == 1) then
      p:Show() ;
    else
      p:Hide() ;
    end
  end
  if (frame:GetParent() == InspectFrame) and (is_on == 0) then
    frame.avg_ilevel:Hide() ;
  elseif (frame:GetParent() == InspectFrame) and (is_on == 1) then
    frame.avg_ilevel:Show() ;
  end
  if (is_on == 1) then
    frame.paperdoll_update( frame:GetParent(), frame._target ) ;
  end
end

OG.EMPTY_GEMSLOTS = { ["Meta"]      = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Prismatic",
                      ["Prismatic"] = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Prismatic",
                      ["Red"]       = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Red",
                      ["Yellow"]    = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Yellow",
                      ["Blue"]      = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Blue",
                      ["sha"]       = "INTERFACE/ITEMSOCKETINGFRAME/UI-EMPTYSOCKET",
                      ["unk"]       = "Interface\\TARGETINGFRAME\\UI-PhasingIcon.blp",
                    } ;

function og.paperdoll_set_gem( p, n, ilink, color )
  if (n < 1) or (n > 5) then
    return ;
  end
  if (p == nil) or (p.gem == nil) or (p.gem[n] == nil) then
    return ;
  end
  p.gem[n]._ilink = ilink ;
  if (p.gem[n]._ilink == nil) then
    if (color) then
      p.gem[n].texture:SetTexture( OG.EMPTY_GEMSLOTS[ color ] ) ;
    else
      p.gem[n].texture:SetTexture( OG.EMPTY_GEMSLOTS[ "unk" ] ) ;
    end
  else
    p.gem[n].texture:SetTexture( select( 10, GetItemInfo(p.gem[n]._ilink)) ) ;
  end
  p.gem[n].texture:SetAlpha( 1.0 ) ;
  p.gem[n].texture:Show() ;
  p.gem[n]:Show() ;
end

OG.ENCHANT_SLOT  =  { [0] = "INTERFACE/COMMON/Indicator-Gray",
                      [1] = "INTERFACE/ICONS/INV_Jewelry_Talisman_08",
                    } ;

function og.paperdoll_set_enchant( p, n, e_id, enchant_text, iid, ilevel )
  e_id = tonumber(e_id or 0) or 0 ;
  -- issue: 600+ ilevel off hand... only weapon can be enchanted, not shields or caster off hands
  --
  if (ilevel < 600) and (__enchantable[ p._slot ] == nil) then
    return 0 ;
  end
  if (ilevel >= 600) and (__enchantable600[ p._slot ] == nil) then
    return 0 ;
  end
  if (ilevel >= 600) and (p._slot == 17) then
    -- only enchantable if off-hand is a weapon
    local itemType = select( 6, GetItemInfo(iid) ) ;
    if (itemType ~= "Weapon") then
      return 0 ;
    end
  end
  if (p == nil) or (p.gem == nil) or (p.gem[n] == nil) then
    return 0 ;
  end
  p.gem[n]._ilink = enchant_text or "" ;
  if (e_id == 0) then
    p.gem[n].texture:SetTexture( OG.ENCHANT_SLOT[1] ) ;
    p.gem[n].texture:SetAlpha( 0.4 ) ;
  else
    p.gem[n].texture:SetTexture( OG.ENCHANT_SLOT[1] ) ;
    p.gem[n].texture:SetAlpha( 1.0 ) ;
  end
  p.gem[n].texture:Show() ;
  p.gem[n]:Show() ;
  return 1 ;
end

local function HexToRGBPerc(hex)
   local  ahex = string.sub(hex, 1, 2) ;
   local  rhex = string.sub(hex, 3, 4) ;
   local  ghex = string.sub(hex, 5, 6) ;
   local  bhex = string.sub(hex, 7, 8) ;
   
   -- changing default blue associated with rares to something a bit lighter
   --
   if (rhex == "00") and (ghex == "70") and (bhex == "dd") then
     rhex = "2D" ;
     ghex = "95" ;
     bhex = "FF" ;
   end
   return tonumber( ahex, 16)/255, tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255 ;
end

function og.paperdoll_update( frame, target )
  if (not frame:IsVisible()) or (OGEAR._paperdoll_show_ilevel == 0) then
    return ;
  end
  local f = frame._ilevelcb ;
  local n = 0 ;
  local e = 0 ;
  local e_id = 0 ;
  local g1, g2, g3, g4 ;
  local c1, c2, c3, c4 ;
  local ilevel = 0 ;
  local sum = 0 ;
  local count = 0 ;
  local enchant_text = "" ;
  local is_pvp = 0 ;
  local i, p, s ;
  
  for i,p in pairs( f._ilevels ) do
    local ilink = GetInventoryItemLink( target, i ) ;
    local iid   = select( 2, strsplit(":", ilink or "" )) ;
    p._ilink = ilink ;
    
    n, g1, g2, g3, g4, c1, c2, c3, c4, e_id, enchant_text, ilevel, is_pvp = og.nGems( target, i ) ;
    
    if (is_pvp) and (is_pvp > 0) then
      p._pvp:SetVertexColor( 1.0,0,0 ) ; -- red
    else
      p._pvp:SetVertexColor( 0,0,1.0 ) ; -- blue
    end
    if (iid ~= nil) or ((iid == nil) and (i ~= 17)) then -- don't count the offhand if empty
      if (ilevel ~= nil) then
        sum = (sum or 0) + ilevel ;
      end
      count = count + 1 ;
    end
    if (OGEAR.show_gearhilight == 1) then
      p._pvp:Show() ;
    else
      p._pvp:Hide() ;
    end
    if (iid) and (iid ~= 0) then
      if (ilevel == nil) or (ilevel == 0) then
        ilevel = select( 4, GetItemInfo(iid)) ;
      end
      if (ilevel) then
        p.ilevel:SetText( tostring(ilevel) ) ;
        p.shadow:SetText( tostring(ilevel) ) ;
        
        local a, r, g, b = HexToRGBPerc( ilink:sub( 3, 10) ) ;
        p.ilevel:SetTextColor( r, g, b ) ;
        
        p._pvp:SetTexture( "INTERFACE\\BUTTONS\\ButtonHilight-Square" ) ;
      else
        p.ilevel:SetText("--") ;
        p.shadow:SetText("--") ;
        p.ilevel:SetTextColor( 128/255, 128/255, 128/255 ) ;
        p._pvp:SetTexture( nil ) ;
      end
    else
      p.ilevel:SetText("") ;
      p.shadow:SetText("") ;
      p._pvp:SetTexture( nil ) ;
    end
    local k ;
    for k=1,5,1 do
      if (p) and (p.gem) and (p.gem[k]) then
        p.gem[k].texture:SetTexture(nil) ;
        p.gem[k]:Hide() ;
      end
    end
    if (p.is_left and (iid)) then
      e = og.paperdoll_set_enchant( p, 1, e_id, enchant_text, iid, ilevel ) ; 
      if (n >= 1) then og.paperdoll_set_gem( p, 1 + e, g1, c1 ) ; end
      if (n >= 2) then og.paperdoll_set_gem( p, 2 + e, g2, c2 ) ; end
      if (n >= 3) then og.paperdoll_set_gem( p, 3 + e, g3, c3 ) ; end
      if (n >= 4) then og.paperdoll_set_gem( p, 4 + e, g4, c4 ) ; end
    elseif (iid) then
      e = og.paperdoll_set_enchant( p, (5-n), e_id, enchant_text, iid, ilevel ) ; 
      if (n >= 1) then og.paperdoll_set_gem( p, 1 + (5-n), g1, c1 ) ; end
      if (n >= 2) then og.paperdoll_set_gem( p, 2 + (5-n), g2, c2 ) ; end
      if (n >= 3) then og.paperdoll_set_gem( p, 3 + (5-n), g3, c3 ) ; end
      if (n >= 4) then og.paperdoll_set_gem( p, 4 + (5-n), g4, c4 ) ; end
    end
  end
  if (count > 0) and (frame == InspectFrame) then 
    f.avg_ilevel:SetText( string.format( L["avg ilevel: %d"], floor(sum / count)) ) ;
  end
end

function og.paperdoll_slot_tooltip( self, ok2show )
  local g = GameTooltip ;
  if (not ok2show) then
    g:Hide() ;
    return ;
  end
  if (self._ilink and (self._ilink ~= "")) then
    g:SetOwner( self ) ;
    if (self._ilink:find( L["Enchanted:"] )) then
      g:ClearLines() ;
      g:AddLine( L["Enchanted:"] ) ;
      local s = self._ilink:sub( strlen(L["Enchanted:"])+1, -1 ) ;
      g:AddLine( "    |cFF00E000".. tostring(s) .."|r  " ) ;
    else
      g:SetHyperlink( self._ilink ) ;
    end
    g:SetPoint( "LEFT", self, "RIGHT", 50 ) ;
    g:Show() ;
  end
end

function og.paperdoll_slot_onclick( self, button )
  if (self._ilink == nil) or (button ~= "LeftButton") or (IsShiftKeyDown() == nil) then
    return ;
  end

  -- allow for shift-click items into chat
  local chat = ChatEdit_GetActiveWindow() ;
  if ((chat ~= nil) and chat:IsVisible()) then
    -- Insert itemlink into chat
    chat:Insert(self._ilink)
    return ;
  end
  
  -- standard auction house support
  if (BrowseName and BrowseName:IsVisible()) then
    -- Insert itemlink into AH browse editbox
    local itemName = GetItemInfo(self._ilink) ;
    BrowseName:SetText( itemName ) ;
    QueryAuctionItems( itemName, nil,nil, 0, 0, 0, 0, 0, 0, 0 ) ;
    return ;
  end

  -- auctionator support
  if (Atr_Search_Box and Atr_Search_Box:IsVisible()) then
    -- Insert itemName into Auctionator search box
    local itemName = GetItemInfo(self._ilink) ;
    Atr_Search_Box:SetText( itemName ) ;
    Atr_Search_Button:Click() ;
    return ;
  end
end

function og.get_slot_id( p )
  local x = p:GetName() ;
  if (x:find("Character")) then
    x = x:sub( strlen( "Character" ) + 1, -1 ) ;
  elseif (x:find("Inspect")) then
    x = x:sub( strlen( "Inspect" ) + 1, -1 ) ;
  end
  return GetInventorySlotInfo( x ) or 0 ;
end

function og.paperdoll_slot_label( slot, is_left )
  og.ngemslots = (og.ngemslots or 0) + 1 ;
  local d = CreateFrame("FRAME", "OGearGems", slot ) ;
  if (slot) then
    d:SetFrameLevel( slot:GetFrameLevel() + 1 ) ;
  end
  d:SetBackdropColor(0.8,0.2,0.2,1.0) ;
  d:SetWidth (50) ;
  d:SetHeight(40) ;

  d.shadow = og.label ( d, 0, 0, 3*12, 25, "xxx" ) ;
  d.ilevel = og.label ( d, 0, 0, 3*12, 25, "xxx" ) ;
  d.is_left = is_left ;
  d._slot = og.get_slot_id( slot ) ;
  
  if (is_left) then
    local x  = -2 ;
    local y  = 22 ;    
    local cx = 16 ;
    
    if (slot == CharacterMainHandSlot) or (slot == InspectMainHandSlot) then 
      d:SetPoint( "BOTTOMLEFT", slot, "TOPLEFT",  0, 0 ) ;
      x = x - cx ;
    else
      d:SetPoint( "TOPLEFT", slot, "TOPRIGHT",  12, -5 ) ;
    end
    
    d.gem = tbl.new() ;
    local i ;
    for i=1,5 do
      d.gem[i] = CreateFrame("BUTTON", "OGearGemsGem", d, nil ) ;
      d.gem[i]:SetFrameLevel( d:GetFrameLevel() + 1 ) ;
      d.gem[i].texture = d:CreateTexture( nil, "OVERLAY" ) ;
      d.gem[i].texture:SetTexture( nil ) ;
      d.gem[i].texture:SetAllPoints(d.gem[i]) ;
      d.gem[i].texture:SetAlpha( 1.0 ) ;

      d.gem[i]:SetScript("OnEnter", function(self, ...) og.paperdoll_slot_tooltip( self, true ) ; end ) ;
      d.gem[i]:SetScript("OnLeave", function(self, ...) og.paperdoll_slot_tooltip( self ) ; end ) ;
      d.gem[i]:SetScript("OnClick", function(self, button, ...) og.paperdoll_slot_onclick( self, button ) ; end ) ;
      
      d.gem[i]:SetPoint ( "BOTTOMLEFT", d, "BOTTOMLEFT", x,  y ) ;
      d.gem[i]:SetWidth ( cx ) ;
      d.gem[i]:SetHeight( cx ) ;
      d.gem[i]:Show() ;
      d.gem[i]._gem  = i ;
      x = x + cx ;
    end
   
    d.shadow:SetPoint   ( "BOTTOMLEFT", d, "BOTTOMLEFT",  2, -15 ) ;
    d.shadow:SetJustifyH("LEFT") ;
    
    d.ilevel:SetPoint   ( "BOTTOMLEFT", d, "BOTTOMLEFT",  0, -12 ) ;
    d.ilevel:SetJustifyH("LEFT") ;    
  else
    local x  =  2 ;
    local y  = 22 ;    
    local cx = 16 ;
    x = -1 * 4*cx ;
    if (slot == CharacterSecondaryHandSlot) or (slot == InspectSecondaryHandSlot) then 
      d:SetPoint( "BOTTOMLEFT", slot, "TOPLEFT",  -12, 0 ) ;
      x = x + cx ;
    else
      d:SetPoint( "TOPRIGHT", slot, "TOPLEFT", -12, -5 ) ;
    end
    
    d.gem = tbl.new() ;
    local i ;
    for i=1,5 do
      d.gem[i] = CreateFrame("BUTTON", "OGearGemsGem", d, nil ) ;
      d.gem[i]:SetFrameLevel( d:GetFrameLevel() + 1 ) ;
      d.gem[i].texture = d:CreateTexture( nil, "OVERLAY" ) ;
      d.gem[i].texture:SetTexture( nil ) ;
      d.gem[i].texture:SetAllPoints(d.gem[i]) ;
      d.gem[i].texture:SetAlpha( 1.0 ) ;
      
      d.gem[i]:SetScript("OnEnter", function(self, ...) og.paperdoll_slot_tooltip( self, true ) ; end ) ;
      d.gem[i]:SetScript("OnLeave", function(self, ...) og.paperdoll_slot_tooltip( self ) ; end ) ;
      d.gem[i]:SetScript("OnClick", function(self, button, ...) og.paperdoll_slot_onclick( self, button ) ; end ) ;

      d.gem[i]:SetPoint ( "BOTTOMRIGHT", d, "BOTTOMRIGHT", x,  y ) ;
      d.gem[i]:SetWidth ( cx ) ;
      d.gem[i]:SetHeight( cx ) ;
      d.gem[i]:Show() ;
      d.gem[i]._gem  = i ;
      x = x + cx ;
    end

    d.shadow:SetPoint   ( "BOTTOMRIGHT", d, "BOTTOMRIGHT",  2, -13 ) ;
    d.shadow:SetJustifyH("RIGHT") ;
    
    d.ilevel:SetPoint   ( "BOTTOMRIGHT", d, "BOTTOMRIGHT",  0, -10 ) ;
    d.ilevel:SetJustifyH("RIGHT") ;
  end
  d.ilevel:SetTextColor( 1.0, 1.0, 1.0, 1 ) ;
  d.ilevel:Show() ;
  
  d.shadow:SetTextColor( 0, 0, 0, 1 ) ;
  d.shadow:Show() ;
  
  d._pvp = slot:CreateTexture(slot:GetName() .."OQHi","OVERLAY") ;
  d._pvp:SetPoint( "TOPLEFT"    , slot, "TOPLEFT"    , -5,  5 ) ;
  d._pvp:SetPoint( "BOTTOMRIGHT", slot, "BOTTOMRIGHT",  5, -5 ) ;
  d._pvp:SetDrawLayer("OVERLAY") ;
  d._pvp:SetAlpha( 1.0 ) ;
  d._pvp:SetBlendMode( "ADD" ) ;
  d._pvp:Show() ;
  
  return d ;
end

function og.toggle_show_ilevel( checked )
  PaperDollFrame._ilevelcb:SetChecked( (checked == 1) ) ;
  InspectFrame  ._ilevelcb:SetChecked( (checked == 1) ) ;
  
  og.paperdoll_overlay( PaperDollFrame._ilevelcb, checked ) ;
  og.paperdoll_overlay( InspectFrame._ilevelcb  , checked ) ;
end

function og.paperdoll_clear( frame )
  local i, v, j ;
  for i,v in pairs(frame._ilevelcb._ilevels) do
    v.ilevel:SetText( "" ) ;
    v.shadow:SetText( "" ) ;
    for j=1,5 do
      v.gem[j].texture:SetTexture( nil ) ;
    end
  end
end

function og.hook_options_menu()
  local f = CreateFrame( "FRAME", "OGearOptions" ) ;
  f.name = L["oGear"] ;
  
  local x, y, cx, cy, text_cx ;
  x  = 20 ;
  y  =  5 ;
  cx = 25 ;
  cy = 30 ;
  text_cx = 200 ;
  og.label( f, x, y, 200, 35, "|cffFFD100" .. L["oGear"] .." v".. OG_VERSION .."|r", "MIDDLE", "LEFT", "GameFontHighlightLarge" ) ;
  y = y + 45 ;
  
  f.cb_enable  = og.checkbox( f, x, y, cx, cy, text_cx, L["enable"], (OGEAR._paperdoll_show_ilevel == 1), function(self) end ) ;  
  y = y + cy ;
  f.cb_hilite  = og.checkbox( f, x, y, cx, cy, text_cx, L["show gear highlight"], (OGEAR.show_gearhilight == 1), function(self) end ) ;  
  y = y + cy ;
  f.cb_inspect = og.checkbox( f, x, y, cx, cy, text_cx, L["auto-inspect on ctrl-left click"], (OGEAR.ok2autoinspect == 1), function(self) end ) ;  
  y = y + cy ;
  
  f.default = function(self)
                self.cb_enable :SetChecked( true ) ;
                self.cb_hilite :SetChecked( true ) ;
                self.cb_inspect:SetChecked( true ) ;
              end
  f.okay = function(self)
             OGEAR._paperdoll_show_ilevel = self.cb_enable :GetChecked() and 1 or 0 ;
             OGEAR.show_gearhilight       = self.cb_hilite :GetChecked() and 1 or 0 ;
             OGEAR.ok2autoinspect         = self.cb_inspect:GetChecked() and 1 or 0 ;
             og.use_ogear(OGEAR._paperdoll_show_ilevel) ;
           end
  f.refresh = function(self)
                self.cb_enable :SetChecked( (OGEAR._paperdoll_show_ilevel == 1) ) ;
                self.cb_hilite :SetChecked( (OGEAR.show_gearhilight == 1) ) ;
                self.cb_inspect:SetChecked( (OGEAR.ok2autoinspect == 1) ) ;
              end
              
  InterfaceOptions_AddCategory(f) ;
end

function og.hook_paperdoll()
  if (PaperDollFrame == nil) then
    return ;
  end
  local parent = PaperDollFrame ;
  local f = og.checkbox( parent, 10, parent:GetHeight() - 8, 25, 25, 100, L["show ilevel"], OGEAR._paperdoll_show_ilevel, 
                         function(self) 
                           if (self:GetChecked()) then
                             OGEAR._paperdoll_show_ilevel = 1 ;
                           else
                             OGEAR._paperdoll_show_ilevel = 0 ;
                           end
                           og.toggle_show_ilevel( OGEAR._paperdoll_show_ilevel ) ;
                         end ) ;
  f:SetFrameLevel( parent:GetFrameLevel() + 5 ) ; -- bump up to insure it's on top of the paperdoll frame stack 
  f._ilevels = tbl.new() ;
  tbl.clear( f._ilevels ) ;
  -- left side
  f._ilevels[  1 ] = og.paperdoll_slot_label( CharacterHeadSlot         , true ) ;
  f._ilevels[  2 ] = og.paperdoll_slot_label( CharacterNeckSlot         , true ) ;
  f._ilevels[  3 ] = og.paperdoll_slot_label( CharacterShoulderSlot     , true ) ;
  f._ilevels[ 15 ] = og.paperdoll_slot_label( CharacterBackSlot         , true ) ;
  f._ilevels[  5 ] = og.paperdoll_slot_label( CharacterChestSlot        , true ) ;
  f._ilevels[  9 ] = og.paperdoll_slot_label( CharacterWristSlot        , true ) ;
  f._ilevels[ 16 ] = og.paperdoll_slot_label( CharacterMainHandSlot     , true ) ;
  -- right side
  f._ilevels[ 10 ] = og.paperdoll_slot_label( CharacterHandsSlot        , false ) ;
  f._ilevels[  6 ] = og.paperdoll_slot_label( CharacterWaistSlot        , false ) ;
  f._ilevels[  7 ] = og.paperdoll_slot_label( CharacterLegsSlot         , false ) ;
  f._ilevels[  8 ] = og.paperdoll_slot_label( CharacterFeetSlot         , false ) ;
  f._ilevels[ 11 ] = og.paperdoll_slot_label( CharacterFinger0Slot      , false ) ;
  f._ilevels[ 12 ] = og.paperdoll_slot_label( CharacterFinger1Slot      , false ) ;
  f._ilevels[ 13 ] = og.paperdoll_slot_label( CharacterTrinket0Slot     , false ) ;
  f._ilevels[ 14 ] = og.paperdoll_slot_label( CharacterTrinket1Slot     , false ) ;
  f._ilevels[ 17 ] = og.paperdoll_slot_label( CharacterSecondaryHandSlot, false ) ;
  local i, v, j ;
  for i,v in pairs(f._ilevels) do
    for j=1,5 do
      v.gem[j]._slot = i ;
    end
  end
  
  f:Show() ;
  f._old_show_func   = parent:GetScript( "OnShow" ) ;
  f._old_hide_func   = parent:GetScript( "OnHide" ) ;
  f.paperdoll_update = og.paperdoll_update ;
  f._target          = "player" ;
  
  parent._ilevelcb = f ;
  parent:SetScript( "OnShow", function(self) self._ilevelcb._old_show_func(self) ; og.paperdoll_overlay( self._ilevelcb, OGEAR._paperdoll_show_ilevel or 0 ) ; end ) ;
  parent:SetScript( "OnHide", function(self) og.paperdoll_overlay( self._ilevelcb, 0 ) ; self._ilevelcb._old_hide_func(self) ; end ) ;
end

function og.hook_inspectdoll()
  if (InspectFrame == nil) then
    return ;
  end
  local parent = InspectFrame ;
  local f = og.checkbox( parent, 10, parent:GetHeight() - 30, 25, 25, 100, L["show ilevel"], OGEAR._paperdoll_show_ilevel, 
                         function(self) 
                           if (self:GetChecked()) then
                             OGEAR._paperdoll_show_ilevel = 1 ;
                           else
                             OGEAR._paperdoll_show_ilevel = 0 ;
                           end
                           og.toggle_show_ilevel( OGEAR._paperdoll_show_ilevel ) ;
                         end ) ;
  f.avg_ilevel = og.label ( parent, parent:GetWidth() - 125, parent:GetHeight() - 30, 110, 25, string.format( L["avg ilevel: %d"], 0 ) ) ;
  f.avg_ilevel:SetJustifyH( "RIGHT" ) ;
  f._ilevels = tbl.new() ;
  tbl.clear( f._ilevels ) ;
  f:SetFrameLevel( parent:GetFrameLevel() + 10 ) ;
  -- left side
  f._ilevels[  1 ] = og.paperdoll_slot_label( InspectHeadSlot         , true ) ;
  f._ilevels[  2 ] = og.paperdoll_slot_label( InspectNeckSlot         , true ) ;
  f._ilevels[  3 ] = og.paperdoll_slot_label( InspectShoulderSlot     , true ) ;
  f._ilevels[ 15 ] = og.paperdoll_slot_label( InspectBackSlot         , true ) ;
  f._ilevels[  5 ] = og.paperdoll_slot_label( InspectChestSlot        , true ) ;
  f._ilevels[  9 ] = og.paperdoll_slot_label( InspectWristSlot        , true ) ;
  f._ilevels[ 16 ] = og.paperdoll_slot_label( InspectMainHandSlot     , true ) ;
  -- right side
  f._ilevels[ 10 ] = og.paperdoll_slot_label( InspectHandsSlot        , false ) ;
  f._ilevels[  6 ] = og.paperdoll_slot_label( InspectWaistSlot        , false ) ;
  f._ilevels[  7 ] = og.paperdoll_slot_label( InspectLegsSlot         , false ) ;
  f._ilevels[  8 ] = og.paperdoll_slot_label( InspectFeetSlot         , false ) ;
  f._ilevels[ 11 ] = og.paperdoll_slot_label( InspectFinger0Slot      , false ) ;
  f._ilevels[ 12 ] = og.paperdoll_slot_label( InspectFinger1Slot      , false ) ;
  f._ilevels[ 13 ] = og.paperdoll_slot_label( InspectTrinket0Slot     , false ) ;
  f._ilevels[ 14 ] = og.paperdoll_slot_label( InspectTrinket1Slot     , false ) ;
  f._ilevels[ 17 ] = og.paperdoll_slot_label( InspectSecondaryHandSlot, false ) ;
  local i, v, j ;
  for i,v in pairs(f._ilevels) do
    for j=1,3 do
      v.gem[j]._slot = i ;
    end
  end
  
  f:Show() ;
  f._old_show_func   = parent:GetScript( "OnShow" ) ;
  f._old_hide_func   = parent:GetScript( "OnHide" ) ;
  f.paperdoll_update = og.paperdoll_update ;
  f._target          = "target" ;

  parent._ilevelcb = f ;
  parent:SetScript( "OnShow", function(self) self._ilevelcb._old_show_func(self) ; og.paperdoll_overlay( self._ilevelcb, OGEAR._paperdoll_show_ilevel or 0 ) ; NotifyInspect( "target" ) ; end ) ;
  parent:SetScript( "OnHide", function(self) og.paperdoll_overlay( self._ilevelcb, 0 ) ; self._ilevelcb._old_hide_func(self) ; ClearInspectPlayer() ; end ) ;
end

function og.register_base_events() 
  og.msg_handler = tbl.new() ;
  og.msg_handler[ "ADDON_LOADED" ] = og.on_addon_loaded ;
  
  og.ui:RegisterEvent("ADDON_LOADED") ;
  og.ui:SetScript("OnEvent", og.on_event ) ;
end

function og.register_events() 
  og.msg_handler[ "INSPECT_READY"                 ] = og.on_inspect_ready ;
  og.msg_handler[ "PLAYER_EQUIPMENT_CHANGED"      ] = og.on_equipment_changed ;
  og.msg_handler[ "PLAYER_TARGET_CHANGED"         ] = og.on_player_target_change ;
  og.msg_handler[ "SOCKET_INFO_UPDATE"            ] = og.on_equipment_changed ;

  og.ui:RegisterEvent( "INSPECT_READY"            ) ;
  og.ui:RegisterEvent( "PLAYER_EQUIPMENT_CHANGED" ) ;
  og.ui:RegisterEvent( "PLAYER_TARGET_CHANGED"    ) ;
  og.ui:RegisterEvent( "SOCKET_INFO_UPDATE"       ) ;
end

function OG_EquipmentFlyout_DisplayButton(button, paperDollItemSlot)
  if (og.old_flyout) then
    og.old_flyout(button, paperDollItemSlot) ;
  end
  
  local location = button.location;
  if ( not location ) then
    return ;
  end
  if ( location >= EQUIPMENTFLYOUT_FIRST_SPECIAL_LOCATION ) then
    return ;
  end
  local player, bank, bags, voidStorage, slot, bag, tab, voidSlot = EquipmentManager_UnpackLocation(location);
  local ilink = nil ;
  if (bag and slot) then
    ilink = GetContainerItemLink( bag, slot ) ;
  elseif (player) then
    ilink = GetInventoryItemLink( "player", slot ) ;
  end
  
  if (ilink) then
    local n, g1, g2, g3, g4, c1, c2, c3, c4, e_id, enchant_text, ilevel, is_pvp = og.nGems_from_ilink( ilink ) ;
--local id, name, textureName, count, durability, maxDurability, invType, locked, start, duration, enable, setTooltip, gem1, gem2, gem3, quality = EquipmentManager_GetItemInfoByLocation(location);
    if (button.og_text == nil) then
      local x, y = 0, button:GetHeight() - 20 ;
      local cx = button:GetWidth() ;
      button.og_shadow = og.label( button, x+2, y+2, cx, 30, "xxx", "MIDDLE", "RIGHT", nil, "OVERLAY" ) ;
      button.og_text   = og.label( button, x  , y  , cx, 30, "xxx", "MIDDLE", "RIGHT", nil, "OVERLAY" ) ;
    end
    button.og_text  :SetText( "|cFFffffff".. tostring(ilevel) .."|r" ) ;
    button.og_shadow:SetText( "|cFF000000".. tostring(ilevel) .."|r" ) ;
  end
end

function OG_onLoad(self) 
  og.ui = self ;
  og.register_base_events() ;
end

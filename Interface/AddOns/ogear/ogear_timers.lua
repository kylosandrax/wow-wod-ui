--[[ 
  @file       ogear_timers.lua
  @brief      ogear timers

  @author     rmcinnis
  @date       september 23, 2014  (originally from oQueue, started on april 06, 2012)
  @copyright  Solid ICE Technologies
              this file may not be redistributed without expressed permission.
              if this file is posted to a web site, credit must be given to me along with a link to my web page
              no code in this file may be used in other works without expressed permission  
              
  note:       timer resolution ==0.050 seconds
]]--
local addonName, OG = ... ;
local og = OG:mod() ; -- thank goodness i stumbled across this trick
local _ ; -- throw away (was getting taint warning; what happened blizz?)
if (OG.table == nil) then
  OG.table = {} ;
end
local tbl = OG.table ;

OG.TIMER_RESOLUTION = 100/1000 ; -- 2 times per second

--------------------------------------------------------------------------
-- timer functions
--------------------------------------------------------------------------
function og.create_timer()
  if (og.timers == nil) then
    og.next_timer_cycle = 0 ;
    og.timer_slice      = OG.TIMER_RESOLUTION ; -- no more than 10 cycles per second; helps throttle for high framerate machines
    og.timers = tbl.new() ;
    og.ui_timer = CreateFrame( "Frame", "OGearTimerFrame" ) ;
    og.ui_timer._thread   = coroutine.create( og.timer_coroutine_func ) ;
    og.ui_timer._counter  = 0 ;
    og.ui_timer._ticker   = 0 ;
    og.ui_timer._restarts = 0 ;
    og.ui_timer._throttle = 0.5 ;
    og.ui_timer:SetScript( "OnUpdate", og.timer_coroutine ) ;
    og.ui_timer:SetScript( "OnHide", function(self) print( "timer-hidden" ) ; self:Show() ; end ) ;
    og.ui_timer:SetSize( 2, 2 ) ;
    og.ui_timer:Show() ;
  end
end

function og.stop_timer()
  og.ui_timer._done = true ;
end

function og.is_timer(id)
  return ((og.timers ~= nil) and (og.timers[id] ~= nil)) ;
end

function og.timer( id, dt_, func_, repeater, arg1_, arg2_, arg3_, arg4_, arg5_, arg6_, arg7_ )
  if (og.timers == nil) then
    og.create_timer() ;
  end
  
  if (func_ == nil) then
    og.timers[ id ] = tbl.delete( og.timers[ id ] ) ;
  else
    if (og.timers[ id ] == nil) then
      og.timers[ id ] = tbl.new() ;
    end
    og.timers[ id ].dt       = dt_ ;
    og.timers[ id ].tm       = GetTime() + dt_ ;
    og.timers[ id ].one_shot = (not repeater) ;
    og.timers[ id ].func     = func_ ;
    og.timers[ id ].arg1     = arg1_ ;
    og.timers[ id ].arg2     = arg2_ ;
    og.timers[ id ].arg3     = arg3_ ;
    og.timers[ id ].arg4     = arg4_ ;
    og.timers[ id ].arg5     = arg5_ ;
    og.timers[ id ].arg6     = arg6_ ;
    og.timers[ id ].arg7     = arg7_ ;
  end
end

function og.timer_coroutine( t, elapsed )
  t._counter = t._counter + elapsed ;
  if (t._counter >= t._throttle) then
    t._counter = t._counter - t._throttle ;
    if (coroutine.status(t._thread) == "dead") then
      -- thread died (how??)... restart
      t._restarts = t._restarts + 1 ;
      t._thread = coroutine.create( og.timer_coroutine_func ) ;
    elseif (coroutine.status(t._thread) == "suspended") then
      coroutine.resume(t._thread) ;
    end
  end
end

function og.timer_coroutine_func()
  while (og.ui_timer._done == nil) do
    og.timer_trigger( GetTime() ) ;
    og.ui_timer._ticker = og.ui_timer._ticker + 1 ;
    coroutine.yield() ;
  end
end

function og.timer_clear()
  tbl.clear( og.timers, true ) ;
end

function og.timer_dump( opt ) 
  local arg = nil ;
  if (opt) and (opt:find(' ')) then
    arg = strlower(opt:sub(opt:find(' ')+1, -1)) ;
  end

  print( "--[ timers ]------" ) ;
  local now = GetTime() ;
  local i,v ;
  for i,v in pairs( og.timers ) do
    if (arg) then
      if (v.one_shot) then
        print( "  ".. string.format( "%6.3f", v.dt ) .."  ".. tostring(i) .."   one_shot" ) ;
      else
        print( "  ".. string.format( "%6.3f", v.dt ) .."  ".. tostring(i) ) ;
      end
    else
      if (v.one_shot) then
        print( "  ".. og.render_tm( v.tm - now, true ) .."  ".. tostring(i) .."   one_shot" ) ;
      else
        print( "  ".. og.render_tm( v.tm - now, true ) .."  ".. tostring(i) ) ;
      end
    end
  end  
  print( "--" ) ;
end

og.one_shot = 0 ;
function og.timer_oneshot( dt_, func_, arg1_, arg2_, arg3_, arg4_, arg5_, arg6_, arg7_ )
  og.one_shot = og.one_shot + 1 ;
  og.timer( "one_shot.".. og.one_shot, dt_, func_, nil, arg1_, arg2_, arg3_, arg4_, arg5_, arg6_, arg7_ ) ;  
end

-- resets timer to now + dt
function og.timer_reset( id, dt )
  if (og.timers[ id ] ~= nil) then
    local now = GetTime() ;
    if (dt == nil) then
      dt = og.timers[ id ].dt ;
    end
    og.timers[ id ].tm = now + dt ;
  end
end

function og.timer_trigger( now )
  if (now < og.next_timer_cycle) then
    return ;
  end
  local i, v ;
  for i,v in pairs( og.timers ) do
    if (v.tm) and (v.tm < now) then
      local arg1 = v.arg1 ;
      if (arg1 == nil) or (arg1 == "#now") then
        arg1 = now ;
      end
      local retOK, rc = 0, 0 ;
      og._timer_id = i ;
      retOK, rc = pcall( v.func, arg1, v.arg2, v.arg3, v.arg4, v.arg5, v.arg6, v.arg7 ) ;
      if (retOK == true) then 
        if (rc ~= nil) or (v == nil) or (v.one_shot) or (v.dt == nil) or (v.dt == 0) then
          og.timers[i] = tbl.delete( og.timers[i] ) ;
        else
          v.error_cnt = nil ;
          v.tm = now + v.dt ;
        end
      else
        v.error_cnt = (v.error_cnt or 0) + 1 ;
        if ((v.error_cnt % 5) == 0) then
          print( OG.LILREDX_ICON .."  OG: error calling '".. tostring(i) .."'  error: ".. tostring(rc) ) ;
          print( OG.LILREDX_ICON .."  OG: removing timer" ) ;
          og.timers[i] = tbl.delete( og.timers[i] ) ;
        end
      end
      if ((GetTime() - now) > 0.25) then
        return ;
      end
    end
  end
  
  og.next_timer_cycle = GetTime() + og.timer_slice ;
end

function og.timer_trip( id )
  if (og.timers[ id ] ~= nil) then
    og.timers[ id ].tm = 0 ;
  end
end


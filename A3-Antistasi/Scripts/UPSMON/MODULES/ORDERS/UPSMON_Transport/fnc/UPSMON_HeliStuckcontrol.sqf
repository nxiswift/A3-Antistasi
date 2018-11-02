private["_heli","_landing","_stuckcontrol","_dir1","_targetPos","_lastpos"];				
	_heli = _this select 0;
	
	_landing = false;
	_stuckcontrol = false;
	_targetPos=[0,0,0];
	_dir1 = 0;
	
	sleep 0.05;	
	if ( !alive _heli  || !canmove _heli ) exitwith{};
	
	//Checks stuckcontrol not active
	_stuckcontrol = _heli getVariable "UPSMON_stuckcontrol";
	if (isnil ("_stuckcontrol")) then {_stuckcontrol=false};	
	if (_stuckcontrol) exitwith {};
	
	_heli setVariable ["UPSMON_stuckcontrol", true, false];													
	//if (KRON_UPS_Debug>0 ) then {player globalchat format["%1 stuck control begins",typeof _heli];};
	
	//Stuck loop control
	while {(alive _heli) && (count crew _heli) > 0 } do {	
		sleep 5;		
		if ((abs(velocity _heli select 0)) <= 5 && (abs(velocity _heli select 1)) <= 5 && (abs(velocity _heli select 2)) <= 5 && ((position _heli) select 2) >= 30) then {
		
			_landing = _heli getVariable "UPSMON_landing";	
			if (isnil ("_landing")) then {_landing=false;};
			
			if (!_landing) then {		
				//moving hely for avoiding stuck
				[_heli,800] spawn UPSMON_domove;					
				if (UPSMON_Debug>0 ) then {player GLOBALCHAT format["%1 stucked at %2m height, moving",typeof _heli,(position _heli) select 2];};
				sleep 25;			
			};			
		};
	};	
	//if (UPSMON_Debug>0 ) then {player globalchat format["%1 exits from stuck control",typeof _heli];};
	_heli setVariable ["UPSMON_stuckcontrol", false, false];
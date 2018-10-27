// by [STELS]Zealot

if (isdedicated) exitwith {};
waitUntil {(!isNull (findDisplay 46) || !(alive player))}; // Wait for init
(findDisplay 46) displayAddEventHandler ["MouseZChanged", ' if ( (alive player) && (alive vehicle player) && (player != vehicle player) )then { [] call zlt_showvehiclecrew };'];
zlt_showvehiclecrewopentime = 0;

zlt_closevehiclecrew = {
	sleep 3;
	if (diag_ticktime > (zlt_showvehiclecrewopentime + 2)) then {
		hintsilent "";
	};
};

zlt_showvehiclecrew = {
	_txt="";
	_veh = vehicle player;
	if ((alive player) && (alive _veh) && (player!=_veh)) then
	{
		_crew=crew _veh;
		{
			if (!isNull _x) then
			{
				_color = "#EEEEEE";
				_pic = "getincargo_ca.paa";
				switch true do {
					case (_x == commander _veh)  :{_pic = "getincommander_ca.paa";};
					case (_x == driver _veh) : {_pic = "getindriver_ca.paa";};
					case (_x == gunner _veh) : {_pic = "getingunner_ca.paa";};
				};
	
				_txt=_txt+format ["<t size='0.75'><img image='\A3\ui_f\data\igui\cfg\actions\%1'></t> <t size='1' shadow='true' color='%2'>%3</t><br/>",_pic, _color, name _x];
			};
		}forEach _crew;
		
		hintsilent composetext [parsetext _txt];
		zlt_showvehiclecrewopentime = diag_ticktime;
		[] spawn zlt_closevehiclecrew;
	};
};

// Перетаскивание статического оружия от [STELS]Zealot
// Исп.: [] execvm "zlt_staticwpn.sqf";
#define STR_DRAG_STATIC "Перетащить"
#define STR_RELEASE_STATIC "Бросить %1"

#define SCRIPT_VERSION "1F"

#define STR_HELP "Перетаскивание статического оружия (Автор: Zealot) <br/> Cкрипт позволяет перетаскивать тяжелое оружие: Титаны на треногах, Пулеметы, Минометы через соотв. пункты меню.<br/> Версия: "+SCRIPT_VERSION
#define STR_SCRIPTS_NAME "Скрипты"
#define STR_SCRIPT_NAME "Перетаскивание тяж. оружия"


if (isDedicated) exitWith {};
waitUntil {player == player};

player createDiarySubject [STR_SCRIPTS_NAME,STR_SCRIPTS_NAME];
player createDiaryRecord [STR_SCRIPTS_NAME,[STR_SCRIPT_NAME, STR_HELP]];

zlt_drag = false;

// deprecated
zlt_fnc_drag_cond = {
	_wpn = cursorTarget;
	if (isnil "_wpn" or {not (_wpn isKindOf "StaticWeapon")} or {_wpn distance player > 3} or {_wpn getVariable ["zlt_drag", false]} or {count crew _wpn != 0}) exitWith {false;};
//not isNull cursorTarget and {cursorTarget isKindOf "StaticWeapon"} and {cursorTarget distance player < 3} and {not (cursorTarget getVariable ["zlt_drag", false])} and {count crew cursorTarget == 0}
	not zlt_drag;
};


zlt_fnc_drag = {
	_wpn = cursorTarget;
	if (isnil "_wpn") exitWith {};
	player playMove "acinpknlmstpsraswrfldnon";
	_wpn attachto [player,[0,1,1.5]];
	zlt_drag = true;
	_wpn setVariable ["zlt_drag", true, true];
	[ [ [_wpn,true], {(_this select 0) lock (_this select 1);} ],"bis_fnc_spawn",_wpn] call bis_fnc_mp;
	sleep 0.1;
	_reltxt = format [STR_RELEASE_STATIC, getText (configFile >> "CfgVehicles" >> typeof _wpn >> "Displayname")];
	_rel = player addaction [("<t color=""#00FF00"">") + _reltxt + "</t>",{zlt_drag = false},[],15,true,true,"","true"];
	waitUntil {not alive player or ((animationstate player == "acinpknlmstpsraswrfldnon") or (animationstate player == "acinpknlmwlksraswrfldb"))};
	while {count crew _wpn == 0 and zlt_drag and vehicle player == player and alive player and ((animationstate player == "acinpknlmstpsraswrfldnon") or (animationstate player == "acinpknlmwlksraswrfldb"))} do {
		sleep 0.16;
	};
	player playMoveNow "AmovPknlMstpSrasWrflDnon";
	player removeAction _rel;
	zlt_drag = false;	
	_wpn setVariable ["zlt_drag", false, true];
	[ [ [_wpn,false], {(_this select 0) lock (_this select 1);} ],"bis_fnc_spawn",_wpn] call bis_fnc_mp;
	if not (isNull _wpn) then {
		detach _wpn;
		_wpn setposatl (player modelToWorld [0,1,0]);
	};

};


player addAction["<t color='#ff0000'>"+STR_DRAG_STATIC+"</t>", zlt_fnc_drag, [], -1, false, true, '','not isNull cursorTarget and {cursorTarget isKindOf "StaticWeapon"} and {cursorTarget distance player < 3} and {not (cursorTarget getVariable ["zlt_drag", false])} and {count crew cursorTarget == 0};'];

player addEventHandler ["Respawn", {
	player addAction["<t color='#ff0000'>"+STR_DRAG_STATIC+"</t>", zlt_fnc_drag, [], -1, false, true, '','not isNull cursorTarget and {cursorTarget isKindOf "StaticWeapon"} and {cursorTarget distance player < 3} and {not (cursorTarget getVariable ["zlt_drag", false])} and {count crew cursorTarget == 0};'];
}];
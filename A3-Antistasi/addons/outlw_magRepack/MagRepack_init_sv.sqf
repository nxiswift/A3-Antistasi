﻿outlw_MR_bulletTime = 0.8; // Seconds per individual bullet.
outlw_MR_beltTime = 4; // Seconds per belt magazine.

////////////////////////////////////////////////////////////////////////////////////////////////////

if (isClass(configFile >> "CfgPatches" >> "outlw_magRepack")) exitWith {};

disableSerialization;

outlw_MR_version = "4.0";
outlw_MR_date = "5 янв 2017";

outlw_MR_defaultKeybinding = [false, true, false, 19];

outlw_MR_canCreateDialog = true;
outlw_MR_keybindingMenuActive = false;
outlw_MR_debugMode = profileNamespace getVariable ["outlw_MR_debugMode_profile", false];
outlw_MR_doHideFull = profileNamespace getVariable ["outlw_MR_doHideFull_profile", false];
outlw_MR_keyList = profileNamespace getVariable ["outlw_MR_keyList_profile", outlw_MR_defaultKeybinding];

if (typeName(outlw_MR_keyList select 0) != "BOOL") then
{
	profileNamespace setVariable ["outlw_MR_keyList_profile", outlw_MR_defaultKeybinding];
	outlw_MR_keyList =+ outlw_MR_defaultKeybinding;
};

outlw_MR_shift = outlw_MR_keyList select 0;
outlw_MR_ctrl = outlw_MR_keyList select 1;
outlw_MR_alt = outlw_MR_keyList select 2;
outlw_MR_keybinding = outlw_MR_keyList select 3;

[] execVM "addons\outlw_magRepack\Scripts\MagRepack_Main.sqf";
[] execVM "addons\outlw_magRepack\Scripts\MagRepack_Keybindings.sqf";
[] execVM "addons\outlw_magRepack\Scripts\MagRepack_Misc.sqf";

waitUntil {!(isNil "outlw_MR_getIDCs")};

outlw_MR_listIDCs = [(missionConfigFile >> "MR_Dialog" >> "Controls")] call outlw_MR_getIDCs;

waitUntil {!(isNull (findDisplay 46))};

(findDisplay 46) displayAddEventHandler ["KeyDown", "_this call outlw_MR_keyDown;"];

systemChat "Перепаковка магазинов ВКЛЮЧЕНА!";
systemChat ("Комбинация клавиш: " + (call outlw_MR_keyListToString));









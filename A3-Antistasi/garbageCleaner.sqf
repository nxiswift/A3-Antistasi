private ["_toDelete"];

[petros,"hint","Deleting Garbage. Please wait"] remoteExec ["A3A_fnc_commsMP"];

{deleteVehicle _x} forEach allDead;
{deleteVehicle _x} forEach (allMissionObjects "WeaponHolder");
{deleteVehicle _x} forEach (allMissionObjects "WeaponHolderSimulated");

[petros,"hint","Garbage deleted"] remoteExec ["A3A_fnc_commsMP"];
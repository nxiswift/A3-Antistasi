private ["_units"];

if (player != leader player) exitWith {hint "You must be leader of your group to enable Auto Heal"; autoHeal = false};

_units = units player;

if ({alive _x} count _units == {isPlayer _x} count _units) exitWith {hint "Auto Heal requires at least one AI soldier in your group"; autoHeal = false};

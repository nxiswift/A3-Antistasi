if (!isDedicated) then
{
	[0.15, 0.1, 2,0, 1, 3, 7, 5, 20] execVM "addons\damagesystem\shake.sqf";
	// [0.4, 0, 5, 0.3, 1, 2, 1, 3, 1, 2] execVM "addons\damagesystem\blurred.sqf"; //потеря резкости
	 // [0.4, 0.5, 1, 0.3, 1, 1.5, 0.3, 1, 0.5, 2] execVM "addons\damagesystem\illusions.sqf"; //раздвоение
	[0.7, 0.25, 0.15, 0.05, 1, 3, 1, 3, 0.5, 1.5] execVM "addons\damagesystem\neardeath.sqf"; //cерость на экране
	[0.8, 1, 1, 3, 6] execVM "addons\damagesystem\blackout.sqf";
};
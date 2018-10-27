_dmg = _this select 0;
_effectLengthMin = _this select 1;
_effectLengthMax = _this select 2;
_noEffectLengthMin = _this select 3;
_noEffectLengthMax = _this select 4;

while {true} do
{
	if (damage player >= _dmg) then
	{
		_effect = ((damage player-_dmg)/(1-_dmg));
		_sleep = _effect*random(_effectLengthMax-_effectLengthMin) + _effectLengthMin;
		titleText ["", "BLACK OUT", 1];
		_mV = musicVolume;
		_sV = soundVolume;
		_rV = radioVolume;
		1 fadeSound 0;
		1 fadeRadio 0;
		1 fadeMusic 0;
		

		sleep _sleep;
		
		titleText ["", "BLACK IN"];
		1 fadeSound _rV;
		1 fadeRadio _sV;
		1 fadeMusic _mV;
		titleText ["", "BLACK IN", 1];
		_sleep = random(_noEffectLengthMax-_noEffectLengthMin) + _noEffectLengthMin;
		sleep _sleep;
	}
	else
	{
		sleep 0.5;
	};
};


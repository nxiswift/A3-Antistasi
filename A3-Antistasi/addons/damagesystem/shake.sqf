_dmg = _this select 0;
_effectMin = _this select 1;
_effectMax = _this select 2;
_effectRnd = _this select 3;
_effectLengthMin = _this select 4;
_effectLengthMax = _this select 5;
_noEffectLengthMin = _this select 6;
_noEffectLengthMax = _this select 7;

while {true} do
{
	if (damage player >= _dmg) then
	{
		enableCamShake true;
		
		_rnd = random(_effectRnd);
		_effect = ((damage player-_dmg)/(1-_dmg))*(_effectMax)+_rnd;
		_sleep = random(_effectLengthMax-_effectLengthMin) + _effectLengthMin;
		addCamShake [_effect, _sleep, 10];
		sleep _sleep;
		
		_rnd = random(_effectRnd);
		_effect = _effectMin*_effect+_rnd;
		addCamShake [_effect, _sleep, 10];
		_sleep = random(_noEffectLengthMax-_noEffectLengthMin) + _noEffectLengthMin;
		sleep _sleep;
	}
	else
	{
		sleep 0.5;
	};
};
_dmg = _this select 0;
_effectMin = _this select 1;
_effectMax = _this select 2;
_effectRnd = _this select 3;
_adjMin = _this select 4;
_adjMax = _this select 5;
_effectLengthMin = _this select 6;
_effectLengthMax = _this select 7;
_noEffectLengthMin = _this select 8;
_noEffectLengthMax = _this select 9;

_neardeath = ppEffectCreate ["FilmGrain", 2000];

while {true} do
{
	if (damage player >= _dmg) then
	{
		_neardeath ppEffectEnable true;
		
		_rnd = random(_effectRnd);
		_effect = ((damage player-_dmg)/(1-_dmg))*(_effectMax)+_rnd;
		_neardeath ppEffectAdjust[_effect,0.1,1,1,1,false];
		_sleep = random(_adjMax-_adjMin) + _adjMin;
		_neardeath ppEffectCommit _sleep;
		sleep _sleep;
		
		_sleep = random(_effectLengthMax-_effectLengthMin) + _effectLengthMin;
		sleep _sleep;
		
		_rnd = random(_effectRnd);
		_effect = _effectMin*_effect+_rnd;
		_neardeath ppEffectAdjust[_effect,0.1,1,1,1,false];
		_sleep = random(_adjMax-_adjMin) + _adjMin;
		_neardeath ppEffectCommit _sleep;
		sleep _sleep;
		
		_sleep = random(_noEffectLengthMax-_noEffectLengthMin) + _noEffectLengthMin;
		sleep _sleep;
	}
	else
	{
		_neardeath ppEffectAdjust[0,0.1,1,1,1,false];
		_neardeath ppEffectCommit 1;
		sleep 0.5;
		_neardeath ppEffectEnable false;
	};
};
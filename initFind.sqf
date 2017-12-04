
	[] spawn {
		while { true } do {
		    _enemySides = [side player] call BIS_fnc_enemySides;
			_enemies = allUnits select {side _x in _enemySides AND getposasl _x distance getposasl player <= 1500};
			_airObjects = allMissionObjects "Air";
			_enemyAir = _airObjects select {side _x in _enemySides AND getposasl _x distance getposasl player <= 1500};
		    {
			_reldir = player getRelDir _x;
            _dist = player distance _x;
			systemChat format["Enemy Air Target at range: %1 Relative Direction: %2", _dist, _reldir ];
			
			player reveal [_x,4];
			_allInfo = player targetKnowledge _x;
		    } forEach _enemyAir; 
			private _numOfUnits = count allunits;
			systemChat format["unit count is %1", _numOfUnits];
			sleep 10;
		};
	};

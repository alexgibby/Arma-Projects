
// Player client code block
if (hasInterface) then {
	systemChat "Hello World from client";
	
	[] spawn {
		while { true } do {
		    _enemySides = [side player] call BIS_fnc_enemySides; //Determine enemy side
			_enemies = allUnits select {side _x in _enemySides AND getposasl _x distance getposasl player <= 1500}; // Determine any enemy in area
			_airObjects = allMissionObjects "Air"; //Returns Air array
			_enemyAir = _airObjects select {side _x in _enemySides AND getposasl _x distance getposasl player <= 1500}; // Determine any enemy air in area
		    {
			_reldir = player getRelDir _x;
            _dist = player distance _x;
			systemChat format["Enemy Air Target at range: %1 Relative Direction: %2", _dist, _reldir ]; //debug relay
			player reveal [_x,4];
			_allInfo = player targetKnowledge _x; // Array of Information on Air Threat
			_knowVal = player knowsAbout _x;
			  if (_knowVal>2) then{
			    _arrow = "Sign_Arrow_Large_Blue_F" createVehicle position player; //Demo Purposes
			    _arrow attachTo [_x, [0, 5, 0] ];
			  };	
		    }forEach _enemyAir; 
			sleep 5; //Update every 5 secs
		};
	};
};

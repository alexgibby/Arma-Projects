		   // turret removeMagazinesTurret["magazine_Missile_rim162_x8",[0]];
		   //SIMULATE A RADRAR 360 DEGREE AZIMUTH AND -5 - 90 DEGREE PICTURE
			_enemySides = [side player] call BIS_fnc_enemySides;
			Radar disableAI "ALL";
			_allObjectsSphere = Radar nearEntities 2000; //2KM range pick up
			RadarRotationAngle =0;
			_halfRecWidth = 1000;
			_halfRecHeight = 1000;
			_total = (_halfRecHeight * _halfRecHeight)+(_halfRecWidth * _halfRecWidth);
			_pythag = sqrt(_total);
			_subtract = getDir Radar;		
			areaObjects=[];
			while {RadarRotationAngle < 360} do{
			_origin = Radar getRelPos [_pythag, (RadarRotationAngle - _subtract)];
			ScanArea =[_origin, 1000, 1000, RadarRotationAngle +45 , true,-1];	
			{
					_position = getPosASL _x;
					_Inside = _position inArea ScanArea; //check if object is in scan area
					if (!(_Inside)) then{
					}
					else{ //if it is in check if already in the array
					//now check to see if object is on the Z axis scale of the radar (90degrees to -5degrees relative to it)
					//First check to see if object has a Z value less than the Radar. If it does then perform the next check to see whether its within the relative 5 degree angle
					//_ZPointRadar = ((getPosASL Radar) select 2);
					//_ZPointObject = _position select 2;
					
					//if (_ZPointRadar>_ZPointObject) then{
					//_Opposite = (_ZPointRadar - _ZPointObject);
					//_Adjacent = (Radar distance _x);
					//_Angle = atan2(_Opposite/_Adjacent);
					//systemChat format ["Angle %1", _Angle];
					//};
					_obs = lineIntersectsWith[eyePos Radar, aimPos _x, _x];
					_intersects = count _obs;
					// systemChat format["Can see %1 objects intersecting: %2", _x, _intersects];	
					 if (_intersects<1) then{
					 areaObjects pushBackUnique _x;
					 };
					};
			}forEach _allObjectsSphere;
			sleep 0.01;
			RadarRotationAngle = RadarRotationAngle +5;
			};
			
			_enemies = allUnits select {side _x in _enemySides AND getposasl _x distance getposasl player <= 5000};
			_airObjects = allMissionObjects "Air";
			enemyAir = areaObjects select {side _x in _enemySides AND getposasl _x distance getposasl player <= 5000};
				{
				  _reldir = player getRelDir _x;
				  _dist = player distance _x;
					//systemChat format["Enemy Air Target at range: %1 Relative Direction: %2", _dist, _reldir ];
				   player reveal [_x,4];
				  _allInfo = player targetKnowledge _x;
				  _knowVal = player knowsAbout _x;
				  _objects = lineIntersectsWith [eyePos player, aimPos _x];
				  _intersectObj = count _objects;
				  if (_knowVal >2 ) then
				  {
						   if (_intersectObj == 1 ) then
								   {
								  //  systemChat format["System knows and intersects: %1", _x];
									_arrow = "Sign_Arrow_Large_Blue_F" createVehicle position player;
									_arrow setPos (_x modelToWorld [0,5,0]);
								   }
						  else
								  {
								  //  systemChat format["System knows about: %1", _x];
								   _arrow = "Sign_Arrow_Large_F" createVehicle position player;
									_arrow  setPos (_x modelToWorld [0,5,0]);
								  };
				  };			  
				}forEach enemyAir; 

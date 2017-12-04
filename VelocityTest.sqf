_v = "C_Offroad_01_F" createVehicle position player;
_v setpos [(getpos _v) select 0, (getpos _v) select 1, 100] ;
_v setvelocity [100 * (sin (getdir _v)), 100 * (cos (getdir _v)), 0]; 

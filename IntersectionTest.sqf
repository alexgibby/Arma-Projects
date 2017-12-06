 _objects = lineIntersectsWith [eyePos player, aimPos truck] ;
 {
 systemChat format["Object: %1", _x]
 }forEach _objects;
 //IntersectTest Returns array of all objects in the path/blocking the missile


//Move
if(isServer){
	x += spd*dir;
	if(obj_objective.personFits(id)){
		dir = -1;
	}
}
///Enums and Arrays for Traits
#macro traitCount 4
#macro leftBound 468
#macro rightBound (room_width - leftBound)
enum Traits{
	head,
	clothes,
	color,
	accessory
}
enum Head{
	baldMan,
	hairMan,
	blondeWoman,
	brunetteWoman,
	devil,
	angel
}
headSprites = [spr_head_0, spr_head_1, spr_head_2, spr_head_3, spr_head_4, spr_head_5];
enum Clothes{
	suit,
	dress,
	tshirt
}
clothesSprites = [spr_suit, spr_dress, spr_tshirt];
enum Colors{
	black,
	white,
	red,
	green,
	blue,
	purple,
	orange
}
colors = [c_black, c_white, c_red, c_green, c_blue, c_purple, c_orange];
enum Accessory{
	purse,
	briefcase,
	wings,
	pitchfork
}
accessorySprites = [spr_purse, spr_briefcase, spr_wings, spr_pitchfork];
accessoryOnTop = [true, true, false, true];

//Set traits
if(isServer){
	objective = noone;
	with(obj_controller){
		if(nextObjectiveToSpawn < objectiveCount && objectiveSpawns[nextObjectiveToSpawn] == peopleCount){
			//It's an objective
			other.objective = objectives[nextObjectiveToSpawn];
			nextObjectiveToSpawn++;
		}
	}
	if(objective == noone){
		var bad = true;
		while(bad){
			traits = [irandom_range(0, 5), irandom_range(0, 2), irandom_range(0, 6), irandom_range(0, 3)];
			bad = false;
			for(var i = 0; i < obj_controller.objectiveCount; i++){
				if(instance_exists(obj_controller.objectives[i]) && obj_controller.objectives[i].personFits(id)){
					bad = true;
					break;
				}
			}
		}
	}else{
		for(var i = 0; i < traitCount; i++){
			if(objective.enabledTraits[i]){
				traits[i] = objective.objectiveTraits[i];
			}else{
				switch(i){
				case(Traits.head): traits[i] = irandom_range(0, 5); break;
				case(Traits.clothes): traits[i] = irandom_range(0, 2); break;
				case(Traits.color): traits[i] = irandom_range(0, 6); break;
				case(Traits.accessory): traits[i] = irandom_range(0, 3); break;
				}
			}
		}
	}
}

//Networking
host = hostSide.server;
network = -1;
network = new Network(id, [oP.x,oP.y,oP.xscale,oP.yscale,oP.index],host); 
network.sendData = function(){
	if isHost(host) sendPacket([netData.objData,network.token,oP.traits,traits[0],traits[1],traits[2],traits[3]]);
}
network.sendData();

//Variables
enum level {
	Heaven,
	Hell,
	Purgatory
}
clicked=false;
if(isServer){
	flr = y;
	spd = obj_controller.flrSpds[flr];
	dir = obj_controller.flrDirs[flr];
	x = dir == 1 ? leftBound : rightBound;
	y = obj_controller.flrYs[flr];
}

checkShadow();
draw = function(_x,_y){
	if(!accessoryOnTop[traits[Traits.accessory]]){
		draw_sprite_ext(accessorySprites[traits[Traits.accessory]], 0, x+_x, y+_y,image_xscale,image_yscale,image_angle,c_white, image_alpha);
	}
	draw_sprite_ext(clothesSprites[traits[Traits.clothes]], 0, x+_x, y+_y, image_xscale, image_yscale, image_angle, colors[traits[Traits.color]], image_alpha);
	draw_sprite_ext(headSprites[traits[Traits.head]], 0, x+_x, y+_y,image_xscale,image_yscale,image_angle,c_white, image_alpha);
	if(accessoryOnTop[traits[Traits.accessory]]){
		draw_sprite_ext(accessorySprites[traits[Traits.accessory]], 0, x+_x, y+_y,image_xscale,image_yscale,image_angle,c_white, image_alpha);
	}
}
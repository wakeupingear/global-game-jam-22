///Enums and Arrays for Traits
#macro traitCount 6
#macro leftBound -30
#macro rightBound (room_width - leftBound)
enum Traits{
	head,
	clothes,
	color,
	thermals,
	xray,
	soul
}
enum Head{
	baldMan,
	greyWoman,
	gingerWoman,
	laurelWoman,
	flowerMan,
	devilMan,
	devilWoman,
	hatMan,
	angelMan,
	angelWoman
}
headSprites = [spr_head1, spr_head2, spr_head3, spr_head4, spr_head5, spr_head6, spr_head7, spr_head8, spr_head9, spr_head10];
enum Clothes{
	suit,
	dress,
	tshirt
}
clothesSprites = [  [spr_suit_black,spr_suit_white,spr_suit_red,spr_suit_green,spr_suit_blue,spr_suit_purple,spr_suit_orange],
					[spr_dress_black,spr_dress_white,spr_dress_red,spr_dress_green,spr_dress_blue,spr_dress_purple,spr_dress_orange],
					[spr_tshirt_black,spr_tshirt_white,spr_tshirt_red,spr_tshirt_green,spr_tshirt_blue,spr_tshirt_purple,spr_tshirt_orange]]
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

enum thermals {
	hot,
	medium,
	cold
}
thermalColors=[
	[color_get_red(c_red)/255,color_get_green(c_red)/255,color_get_blue(c_red)/255],
	[color_get_red(c_orange)/255,color_get_green(c_orange)/255,color_get_blue(c_orange)/255],
	[color_get_red(c_green)/255,color_get_green(c_green)/255,color_get_blue(c_green)/255],
];

enum Xray{
	none,
	gun,
	phone,
	belt,
	teeth
}
xRaySprites = [spr_xray_none, spr_xray_gun, spr_xray_phone, spr_xray_belt, spr_xray_teeth];

enum Soul{
	good,
	neutral,
	evil
}

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
			traits = [irandom_range(0, 9), irandom_range(0, 2), irandom_range(0, 6),
				irandom(array_length(thermalColors)-1), //window mode 1
				irandom_range(0, 4), //window 2
				0 //window 3
			];
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
				default: traits[i]=0; break;
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
	if isHost(host) sendPacket([netData.objData,network.token,oP.traits,traits[0],traits[1],traits[2],traits[3],traits[4],traits[5]]);
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

if(isServer){
	sprite_index = clothesSprites[traits[Traits.clothes]][traits[Traits.color]];
	image_xscale = dir;
}

createShadow(0.4);
yStartOffset=irandom(100);
draw = function(_x,_y){
	if !isServer {
		if obj_controller.windowMode==windowModes.thermal shader_set_uniform_f(shader_get_uniform(shd_solidPerson,"u_color"),
			thermalColors[traits[Traits.thermals]][0],thermalColors[traits[Traits.thermals]][1],thermalColors[traits[Traits.thermals]][2]);
		else if obj_controller.windowMode==windowModes.xRay shader_set_uniform_f(shader_get_uniform(shd_solidPerson,"u_color"),0,0,0);
		else if obj_controller.windowMode==windowModes.soul shader_set_uniform_f(shader_get_uniform(shd_solidPerson,"u_color"),1,1,1);
	}
	draw_sprite_ext(clothesSprites[traits[Traits.clothes]][traits[Traits.color]], image_index, x+_x, y+_y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
	draw_sprite_ext(headSprites[traits[Traits.head]], 0, x+_x, y+_y,image_xscale,image_yscale,image_angle,c_white, image_alpha);
	if(!isServer && obj_controller.windowMode == windowModes.xRay){
		shader_set_uniform_f(shader_get_uniform(shd_solidPerson,"u_color"),1,1,1);
		draw_sprite_ext(xRaySprites[traits[Traits.xray]], image_index, x+_x, y+_y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
	}
}
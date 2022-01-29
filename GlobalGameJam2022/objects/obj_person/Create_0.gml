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

//Networking
host = hostSide.server;
network = -1;
network = new Network(id, [oP.x,oP.y,oP.xscale,oP.yscale,oP.index],host);

//Variables
if(isServer){
	flr = y;
	spd = obj_controller.flrSpds[flr];
	dir = obj_controller.flrDirs[flr];
	x = dir == 1 ? leftBound : rightBound;
	y = obj_controller.flrYs[flr];
}


//Randomly pick traits
traits = [irandom_range(0, 5), irandom_range(0, 2), irandom_range(0, 6), irandom_range(0, 3)];





///Create
///Arrays for Traits
headSprites = [spr_head_0, spr_head_1, spr_head_2, spr_head_3, spr_head_4, spr_head_5];
clothesSprites = [spr_suit, spr_dress, spr_tshirt];
colors = [c_black, c_white, c_red, c_green, c_blue, c_purple, c_orange];
accessorySprites = [spr_purse, spr_briefcase, spr_wings, spr_pitchfork];
accessoryOnTop = [true, true, false, true];

//Properties of the objective
enabledTraits = array_create(traitCount, false);
objectiveTraits = array_create(traitCount, 0);

//Things for drawing
drawnTraitHeights = array_create(traitCount, 32);
drawnTraitHeights[Traits.head] = 64;

moveProg=0;
textProg=0;
y+=300;

personFits=function(p){
	for(var i = 0; i < traitCount; i++){
		if(enabledTraits[i]){
			if(objectiveTraits[i] != p.traits[i]){
				return false;
			}
		}
	}
	return true;
}

createShadow(0.4,20,8);
active=true;
//Called when it is successfully completed
success=function(){
	active=false;
}

//Called when it is failed
failure=function(){
	active=false;
}

//Sets this objective's traits according to the array
//The array should be made of pairs of Traits and the goal for that trait
//e.g. setTraits([Traits.accessory, Accessory.briefcase, Traits.color, Colors.black])
//matches people with a briefcase wearing black
setTraits=function(traitArr){
	for(var i = 0; i < array_length(traitArr); i+=2){
		enabledTraits[traitArr[i]] = true;
		objectiveTraits[traitArr[i]] = traitArr[i+1];
	}
}

draw=function(_x,_y){
	draw_sprite_ext(sprite_index,image_index,x+_x,y+_y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}
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

//For testing: set up a objective that wants red people w/ briefcases
enabledTraits[Traits.color] = true;
objectiveTraits[Traits.color] = irandom_range(0, 6);
/*enabledTraits[Traits.clothes] = true;
objectiveTraits[Traits.clothes] = irandom_range(0, 2);
enabledTraits[Traits.head] = true;
objectiveTraits[Traits.head] = irandom_range(0, 5);*/


function personFits(p){
	for(var i = 0; i < traitCount; i++){
		if(enabledTraits[i]){
			if(objectiveTraits[i] != p.traits[i]){
				return false;
			}
		}
	}
	return true;
}

//Called when it is successfully completed
function success(){
	instance_destroy();
}

//Called when it is failed
function failure(){
	instance_destroy();
}

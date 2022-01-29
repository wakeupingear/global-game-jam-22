///Create
///Arrays for Traits
headSprites = [spr_head_0, spr_head_1, spr_head_2, spr_head_3, spr_head_4, spr_head_5];
clothesSprites = [spr_suit, spr_dress, spr_tshirt];
colors = [c_black, c_white, c_red, c_green, c_blue, c_purple, c_orange];
accessorySprites = [spr_purse, spr_briefcase, spr_wings, spr_pitchfork];
accessoryOnTop = [true, true, false, true];

//Properties of the objective
complete = false;
enabledTraits = array_create(traitCount, false);
objectiveTraits = array_create(traitCount, 0);

//For testing: set up a objective that wants red people w/ briefcases
enabledTraits[Traits.accessory] = true;
objectiveTraits[Traits.accessory] = Accessory.briefcase;
enabledTraits[Traits.color] = true;
objectiveTraits[Traits.color] = Colors.red;
enabledTraits[Traits.head] = true;
objectiveTraits[Traits.head] = Head.brunetteWoman;


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
///Draw

var drawX = x;
for(var i = 0; i < traitCount; i++){
	if(enabledTraits[i]){
		switch(i){
		case(Traits.head): draw_sprite(headSprites[objectiveTraits[i]], 0, drawX, y); break;
		case(Traits.clothes): draw_sprite(clothesSprites[objectiveTraits[i]], 0, drawX, y); break;
		case(Traits.color): draw_sprite_ext(spr_colorSample, 0, drawX, y,1,1,0,colors[objectiveTraits[i]],1); break;
		case(Traits.accessory): draw_sprite(accessorySprites[objectiveTraits[i]], 0, drawX, y); break;
		}
		drawX += 64;
	}
}
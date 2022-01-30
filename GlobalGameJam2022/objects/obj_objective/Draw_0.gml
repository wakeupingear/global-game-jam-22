///Draw

draw_self();
var height = 0;
for(var i = 0; i < traitCount; i++){
	if(enabledTraits[i]){
		height+=drawnTraitHeights[i];
	}
}
var drawX = x;
var drawY = y-height/2;
for(var i = 0; i < traitCount; i++){
	if(enabledTraits[i]){
		//draw the trait
		draw_set_halign(fa_center);
		draw_set_valign(fa_center);
		draw_set_font(fn_wantedPoster);
		drawY += drawnTraitHeights[i]/2;
		
		switch(i){
		case(Traits.head):
			draw_sprite(headSprites[objectiveTraits[i]], 0, drawX, drawY);
			break;
		case(Traits.clothes):
			draw_set_color(c_black);
			var cString = "";
			switch(objectiveTraits[i]){
			case(Clothes.suit): cString = "suit"; break;
			case(Clothes.dress): cString = "dress"; break;
			case(Clothes.tshirt): cString = "T-shirt"; break;
			}
			draw_text(drawX, drawY, "wearing a " + cString);
			break;
		case(Traits.color):
			var cString = "";
			switch(objectiveTraits[i]){
			case(Colors.black): draw_set_color(c_black); cString = "black"; break;
			case(Colors.white): draw_set_color(c_white); cString = "white"; break;
			case(Colors.red): draw_set_color(c_red); cString = "red"; break;
			case(Colors.green): draw_set_color(c_green); cString = "green"; break;
			case(Colors.blue): draw_set_color(c_blue); cString = "blue"; break;
			case(Colors.purple): draw_set_color(c_purple); cString = "purple"; break;
			case(Colors.orange): draw_set_color(c_orange); cString = "orange"; break;
			}
			draw_text(drawX, drawY, cString+ " clothing");
			break;
		case(Traits.accessory):
			var cString = "";
			draw_set_color(c_black);
			switch(objectiveTraits[i]){
			case(Accessory.purse): cString = "a purse"; break;
			case(Accessory.briefcase): cString = "a briefcase"; break;
			case(Accessory.wings): cString = "wings"; break;
			case(Accessory.pitchfork): cString = "a pitchfork"; break;
			}
			draw_text(drawX, drawY, "with " + cString);
			break;
		}
		
		//Reset draw stuff
		draw_set_color(c_white);
		
		//Move where we draw next
		drawY += drawnTraitHeights[i]/2;
	}
}
///Draw
var drawX = x;
var drawY = y;

draw(0,0);
var height = 0;
for(var i = 0; i < traitCount; i++){
	if(enabledTraits[i]){
		height+=drawnTraitHeights[i];
	}
}

if textProg==0 exit;
drawY -= height/3;
drawY += 130;
draw_set_halign(fa_center);
draw_set_valign(fa_center);
draw_set_font(fn_wantedPoster);
draw_set_color(c_black);
draw_text(x,y-20,"Wanted");
draw_set_font(fn_2);
draw_set_alpha(textProg);
var _sX=2;
var _sY=1;
for(var i = 0; i < traitCount; i++){
	if(enabledTraits[i]){
		//draw the trait
		drawY += drawnTraitHeights[i]/2;
		
		switch(i){
		case(Traits.head):
			draw_sprite_ext(headSprites[objectiveTraits[i]], 0, drawX, drawY,2,2,0,c_white,textProg);
			break;
		case(Traits.clothes):
			draw_set_color(c_black);
			var cString = "";
			switch(objectiveTraits[i]){
			case(Clothes.suit): cString = "Suit"; break;
			case(Clothes.dress): cString = "Dress"; break;
			case(Clothes.tshirt): cString = "T-Shirt"; break;
			}
			draw_text(drawX, drawY, "Wearing a " + cString);
			break;
		case(Traits.color):
			var cString = "";
			switch(objectiveTraits[i]){
			case(Colors.black): draw_set_color(c_black); cString = "Black"; break;
			case(Colors.white): draw_set_color(c_white); cString = "White"; break;
			case(Colors.red): draw_set_color(c_red); cString = "Red"; break;
			case(Colors.green): draw_set_color(c_green); cString = "Green"; break;
			case(Colors.blue): draw_set_color(c_blue); cString = "Blue"; break;
			case(Colors.purple): draw_set_color(c_purple); cString = "Purple"; break;
			case(Colors.orange): draw_set_color(c_orange); cString = "Orange"; break;
			}
			if draw_get_color()!=c_black draw_text_color(drawX+_sX, drawY+_sY, cString+ " clothing",c_black,c_black,c_black,c_black,1);
			draw_text(drawX, drawY, cString+ " clothing");
			break;
		case(Traits.thermals):
			var tString = "";
			switch(objectiveTraits[i]){
			case(thermals.hot): draw_set_color(c_red); tString = "Burning Hot"; break;
			case(thermals.medium): draw_set_color(c_orange); tString = "Normal Temp"; break;
			case(thermals.cold): draw_set_color(c_green); tString = "Icy Cold"; break;
			}
			draw_text_color(drawX+_sX, drawY+_sY, tString,c_black,c_black,c_black,c_black,1);
			draw_text(drawX, drawY, tString);
			break;
		}
		
		//Move where we draw next
		drawY += drawnTraitHeights[i]/2;
	}
}
draw_set_alpha(1);
draw_set_color(c_white);
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getObjectiveTraits(stage){
	var t = array_create(1);
	switch(stage){
	case(0):
		t[0] = [Traits.clothes, Clothes.tshirt, Traits.head, Head.flowerMan, Traits.thermals, thermals.hot, Traits.color, Colors.red];
		t[1] = [Traits.head, Head.devilMan];
		break;
	case(1):
		t[0] = [Traits.clothes, Clothes.dress, Traits.head, Head.angelMan];
		t[1] = [Traits.color, Colors.blue];
		t[2] = [Traits.color, Colors.orange, Traits.clothes, Clothes.suit];
		break;
	case(2):
		t[0] = [Traits.thermals, thermals.hot];
		t[1] = [Traits.thermals, thermals.cold];
		break;
	case(3):
		t[0] = [Traits.thermals, thermals.hot, Traits.color, Colors.black];
		t[1] = [Traits.thermals, thermals.hot];
		break;
	default:
		switch(irandom_range(0, 1)){
		case(0):
			t[0] = [Traits.clothes, Clothes.suit];
			t[1] = [Traits.color, Colors.red];
			break;
		case(1):
			t[0] = [Traits.clothes, Clothes.suit];
			t[1] = [Traits.color, Colors.red];
			break;
		}
	}
	return t;
}
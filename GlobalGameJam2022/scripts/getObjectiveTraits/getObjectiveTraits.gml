// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getObjectiveTraits(stage){
	var t = array_create(1);
	switch(stage){
	case(0):
		t[0] = [Traits.head, Head.devilMan];
		t[1] = [Traits.color, Colors.red];
		break;
	case(1):
		t[0] = [Traits.clothes, Clothes.dress, Traits.head, Head.angelMan];
		t[1] = [Traits.color, Colors.white, Traits.clothes, Clothes.suit];
		break;
	case(2):
		t[0] = [Traits.thermals, thermals.hot];
		t[1] = [Traits.thermals, thermals.cold];
		break;
	case(3):
		t[0] = [Traits.thermals, thermals.hot, Traits.head, Head.devilWoman];
		t[1] = [Traits.thermals, thermals.cold, Traits.head, Head.hatMan];
		break;
	case(4):
		t[0] = [Traits.xray, Xray.belt];
		t[1] = [Traits.head, Head.angelWoman, Traits.xray, Xray.gun];
		t[2] = [Traits.xray, Xray.teeth];
		break;
	case(5):
		t[0] = [Traits.color, Colors.purple, Traits.thermals, thermals.cold];
		t[1] = [Traits.clothes, Clothes.suit, Traits.xray, Xray.gun];
		t[2] = [Traits.xray, Xray.gun, Traits.thermals, thermals.hot];
		break;
	case(6):
		t[0] = [Traits.soul, Soul.evil];
		t[1] = [Traits.color, Colors.blue, Traits.soul, Soul.good];
		t[2] = [Traits.xray, Xray.gun, Traits.soul, Soul.neutral];
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
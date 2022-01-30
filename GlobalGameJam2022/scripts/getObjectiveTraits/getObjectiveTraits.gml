// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getObjectiveTraits(stage){
	var t = array_create(1);
	switch(stage){
	case(0):
		t[0] = [Traits.head, Head.angelMan];
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
		t[1] = [Traits.thermals, thermals.cold, Traits.color, Colors.green];
		break;
	case(4):
		t[0] = [Traits.xray, Xray.teeth];
		t[1] = [Traits.head, Head.angelWoman, Traits.xray, Xray.gun];
		break;
	case(5):
		t[0] = [Traits.thermals, thermals.hot, Traits.xray, Xray.gun];
		break;
	case(6):
		t[0] = [Traits.soul, Soul.evil];
		t[1] = [Traits.color, Colors.blue, Traits.soul, Soul.good];
		t[2] = [Traits.xray, Xray.gun, Traits.soul, Soul.neutral];
		break;
	default:
		switch(stage%10){
		case(0):
			t[0] = [Traits.xray, Xray.teeth, Traits.thermals, thermals.cold, Traits.soul, Soul.good];
			break;
		case(1):
			t[0] = [Traits.clothes, Clothes.suit];
			t[1] = [Traits.color, Colors.red];
			t[2] = [Traits.thermals, thermals.hot];
			t[3] = [Traits.soul, Soul.evil];
			break;
		case(2):
			t[0] = [Traits.clothes, Clothes.suit, Traits.xray, Xray.belt];
			t[1] = [Traits.color, Colors.purple, Traits.xray, Xray.teeth];
			t[2] = [Traits.head, Head.laurelWoman, Traits.soul, Soul.neutral];
			break;
		case(3):
			t[0] = [Traits.xray, Xray.phone, Traits.thermals, thermals.hot];
			t[1] = [Traits.color, Colors.orange, Traits.thermals, thermals.hot];
			t[2] = [Traits.xray, Xray.belt, Traits.thermals, thermals.hot];
			break;
		case(4):
			t[0] = [Traits.head, Head.baldMan, Traits.soul, Soul.neutral];
			t[1] = [Traits.head, Head.angelWoman, Traits.soul, Soul.evil];
			t[2] = [Traits.head, Head.devilMan, Traits.soul, Soul.good];
			break;
		case(5):
			t[0] = [Traits.color, Colors.blue, Traits.soul, Soul.good];
			t[1] = [Traits.color, Colors.green, Traits.thermals, thermals.cold];
			t[2] = [Traits.color, Colors.red, Traits.xray, Xray.teeth];
			break;
		case(6):
			t[0] = [Traits.color, Colors.blue];
			t[1] = [Traits.color, Colors.green];
			t[2] = [Traits.color, Colors.red];
			t[3] = [Traits.color, Colors.white];
			break;
		case(7):
			t[0] = [Traits.color, Colors.blue, Traits.clothes, Clothes.dress, Traits.soul, Soul.good];
			t[1] = [Traits.color, Colors.black, Traits.head, Head.hatMan, Traits.xray, Xray.phone];
			break;
		case(8):
			t[0] = [Traits.head, Head.devilMan, Traits.thermals, thermals.medium];
			t[1] = [Traits.head, Head.devilWoman, Traits.xray, Xray.gun];
			t[2] = [Traits.head, Head.flowerMan, Traits.xray, Xray.teeth];
			break;
		case(9):
			t[0] = [Traits.xray, Xray.belt, Traits.clothes, Clothes.suit, Traits.color, Colors.blue];
			t[1] = [Traits.xray, Xray.belt, Traits.clothes, Clothes.suit, Traits.color, Colors.black];
			t[2] = [Traits.xray, Xray.belt, Traits.clothes, Clothes.suit, Traits.color, Colors.white];
			break;
		}
	}
	return t;
}

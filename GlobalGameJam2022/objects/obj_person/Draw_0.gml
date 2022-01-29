/// @description Insert description here
// You can write your code in this editor

if(!accessoryOnTop[Traits.accessory]){
	draw_sprite(accessorySprites[traits[Traits.accessory]], 0, x, y);
}
draw_sprite_ext(clothesSprites[traits[Traits.clothes]], 0, x, y, image_xscale, image_yscale, image_angle, colors[traits[Traits.color]], image_alpha);
draw_sprite(headSprites[traits[Traits.head]], 0, x, y);
if(accessoryOnTop[traits[Traits.accessory]]){
	draw_sprite(accessorySprites[traits[Traits.accessory]], 0, x, y);
}
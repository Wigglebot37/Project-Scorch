if(burning) {
	var scale=sqrt(3)/4+0.12;
	
	//Flame
	part_type_life(global.ptFlame2,lerp(0,25,scale),lerp(0,30,scale));
	part_type_size(global.ptFlame2,1,1.2,lerp(0,0.01,scale),0);
	part_type_speed(global.ptFlame2,lerp(0,3,scale),lerp(0,3,scale),-lerp(0,0.05,scale),0);
	part_type_sprite(global.ptFlame2,sp_flamewood,true,true,false);
	part_type_direction(global.ptFlame2,90,90,0,10);
		
	//Smoke
	part_type_life(global.ptSmoke,lerp(0,30,scale),lerp(0,40,scale));
	part_type_size(global.ptSmoke,0.4,0.4,lerp(0,0.05,scale),0);
	part_type_speed(global.ptSmoke,lerp(0,3,scale),lerp(0,3,scale),-lerp(0,0.06,scale),0);
	part_type_direction(global.ptSmoke,90,90,0,10);
		
	var xran=random_range(-3,3),yran=random_range(-13,13);
	part_particles_create(partSys,x+xran,y+yran,global.ptSmoke,1);
	part_particles_create(partSys2,x+xran,y+yran,global.ptFlame2,1);
	
	xran=random_range(-3,3);
	yran=random_range(-13,13);
	
	part_particles_create(partSys,x+xran,y+yran,global.ptSmoke,1);
	part_particles_create(partSys2,x+xran,y+yran,global.ptFlame2,1);
}
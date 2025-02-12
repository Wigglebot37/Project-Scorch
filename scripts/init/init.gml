/*var _p=part_type_create();

part_type_life(_p,20,40);
part_type_sprite(_p,sp_shuriken,true,true,true);
part_type_speed(_p,2,4,0,0);
part_type_direction(_p,0,360,0,0);
part_type_orientation(_p,0,0,0,0,true);
part_type_gravity(_p,0.3,270);

global.ptBasic=_p;

var _p2=part_type_create();
part_type_shape(_p2,pt_shape_circle);
part_type_life(_p2,40,50);
part_type_size(_p2,0.4,0.4,-0.02,0);

global.ptTrail=_p2;

part_type_step(_p,1,_p2);

var _p3=part_type_create();
part_type_shape(_p3,pt_shape_flare);
part_type_life(_p3,30,40);
part_type_size(_p3,0.3,0.4,0.08,0);
part_type_alpha3(_p3,0.8,1,0);
part_type_color3(_p3,c_yellow,c_red,c_white);
part_type_blend(_p3,true);

global.ptDeath=_p3;

part_type_death(_p,1,_p3);*/

/*var _pa=part_type_create(); // Original Flame

part_type_sprite(_pa,sp_flame,true,true,false);
part_type_life(_pa,40,50);
part_type_size(_pa,0.7,0.9,0.02,0);
part_type_speed(_pa,2,2,-0.03,0);
part_type_direction(_pa,0,0,0,15);
part_type_orientation(_pa,0,0,0,0,true);

global.ptFlame=_pa;*/

var _pa=part_type_create();

part_type_sprite(_pa,sp_flame,true,true,false);
part_type_life(_pa,25,30);
part_type_size(_pa,1,1.2,0.01,0);
part_type_speed(_pa,3,3,-0.05,0);
part_type_direction(_pa,0,0,0,15);
part_type_orientation(_pa,0,0,0,0,true);

global.ptFlame=_pa;

_pa=part_type_create();

part_type_sprite(_pa,sp_flame,true,true,false);
part_type_life(_pa,25,30);
part_type_size(_pa,1,1.2,0.01,0);
part_type_speed(_pa,3,3,-0.05,0);
part_type_sprite(_pa,sp_flamewood,true,true,false);
part_type_direction(_pa,90,90,0,10);
part_type_orientation(_pa,0,0,0,0,true);

global.ptFlame2=_pa;

var _pr=part_type_create();

part_type_sprite(_pr,sp_blacksmoke,true,true,false);
part_type_life(_pr,30,40);
part_type_size(_pr,0.4,0.4,0.05,0);
part_type_speed(_pr,3,3,-0.06,0);
part_type_direction(_pr,-10,10,0,25);
part_type_orientation(_pr,0,0,0,0,true);

global.ptSmoke=_pr;

/*var _pr=part_type_create(); // Original Smoke

part_type_sprite(_pr,sp_blacksmoke,true,true,false);
part_type_life(_pr,50,60);
part_type_size(_pr,0.2,0.2,0.03,0);
part_type_speed(_pr,2,2,-0.03,0);
part_type_direction(_pr,-10,10,0,25);
part_type_orientation(_pr,0,0,0,0,true);

global.ptSmoke=_pr;*/

/*var _pa2=part_type_create();

part_type_sprite(_pa2,sp_smoke,true,true,false);
part_type_life(_pa2,20,30);
part_type_size(_pa2,0.5,0.5,0.01,0);
part_type_speed(_pa2,1,1,-0.01,0);
part_type_direction(_pa2,0,360,0,5);
part_type_orientation(_pa2,0,0,0,0,true);
part_type_alpha3(_pa2,0,0.2,0.1);

global.ptSmoke2=_pa2;

part_type_death(_pa,10,_pa2);*/
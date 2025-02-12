/// @desc Initializes variables
hsp=0;
vsp=0;
hspWalk=1;
vspJump=5;
canJump=0;
image_speed=0;
dir=0;
flamedir=0;
subleg=0;
legsp=sp_guylegsrt;
anim=false;
hsign=0;
hspWalkMax=1;

// Flamethrower collision rect variables
a=0;
b=0;
c=0;
d=0;

fall=true;

lightobj=instance_create_depth(20,20,o_setup.depth,o_light);
lightobj.color=c_aqua;
lightobj.size=-10;
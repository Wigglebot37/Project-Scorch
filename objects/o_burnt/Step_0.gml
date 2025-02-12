if(place_meeting(x,y-1,o_player)) {
	start=true;
} else start=false;

if(start) countdown--;
if(image_index==0 && countdown<15) image_index=1;
if(countdown<=0) {
	topID.burntID=noone;
	instance_destroy(myID);
}
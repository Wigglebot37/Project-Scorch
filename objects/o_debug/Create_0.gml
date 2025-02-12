/// @desc Initializes variables
term_str="";
output="";
globalvar input_arr,output_arr;
input_arr=array_create(0);
output_arr=array_create(0);
load_term(true);
cursor_w=0;
cursor_h=0;
typesub=0;
typesubcount=0;
cooldown=3;
check=vk_nokey;

keylock=true;
held=false;

infohud=false;
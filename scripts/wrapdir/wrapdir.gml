/// @function		wrapdir(val);
/// @param val		Degree value
/// @description	Wraps a direction back to 0-360
function wrapdir(val) {
	if(val>=360) return (val-360);
	else if(val<0) return (val+360);
	return val;
}
/// @function		approach360(start,target,step);
/// @param			start
/// @param			target
/// @param			step
/// @description	Start value approaches target value by step amount.

function approach360(start,target,step) {
	if(start>360) start=start-360;
	else if(start<0) start=360+start;
	var flip=180;
	if(target<180) {
		flip=360+target;
	} else if(target>180) {
		flip=-(360-target);
	}
	if(abs(target-start) < abs(flip-start)) {
		flip=target;
	}
	
	if(start<flip) {
		start+=step;
		if(start>flip) {
			if(flip>360) flip=flip-360;
			else if(flip<0) flip=360+flip;
			return flip;
		}
	} else {
		start-=step;
		if(start<flip) {
			if(flip>360) flip=flip-360;
			else if(flip<0) flip=360+flip;
			return flip;
		}
	}
	return start;
}
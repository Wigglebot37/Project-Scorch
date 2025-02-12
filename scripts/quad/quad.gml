/// @function		quad(vb,x1,y1,x2,y2);
/// @param			Vertex Buffer
/// @param			x1
/// @param			y1
/// @param			x2
/// @param			y2
/// @description	For creating a quad

function quad(_vb,_x1,_y1,_x2,_y2) {
	// Upper Triangle
	vertex_position_3d(_vb,_x1,_y1,0);
	vertex_position_3d(_vb,_x1,_y1,2);
	vertex_position_3d(_vb,_x2,_y2,1);
	
	// Lower Triangle
	vertex_position_3d(_vb,_x1,_y1,2);
	vertex_position_3d(_vb,_x2,_y2,1);
	vertex_position_3d(_vb,_x2,_y2,3);
}
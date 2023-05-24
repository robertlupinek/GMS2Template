/// @description bouncing text step
// 

//Check if outside view 0 boundaries left, NOT top, right, bottom 
if ( checkOutsideView(x,y,x,y,0,true,false,true,true) ){
	instance_destroy();
}
/*
Module AntiSupport, Fred Schade 21.08.218
-----------------------------------------------
->usefull to avoid Supportmaterial in specified holes for Slic3r
->insert the AntiSupport at the end of your script
-----------------------------------------------
Variables:
------------
Cube: vector with size of the hole
Position: vector with Coordinates of the hole
nozzle: size of the printed layer
hor: boolean Variable for orientation of the supported material (true= horizontal, false=vertical in OpenScad).
      ! must be vertical to the print direction, otherwise it doesn't work!
center: boolean variable like center in cube,cylinder etc. 
--------------------------------------------------
example:
----------
//hole
translate(P) cube(C,center=false)
// AntiSupport
AntiSupport(Cube=C,Position=P,hor=false, center= false);
---------------------------------------------------------
*/

module AntiSupport(Cube=[30,30,30], Position=[0,0,0], nozzle=0.35, hor=false, center=true)
{
    x=Cube[0];
    y=Cube[1];
    z=Cube[2];
    if (!center){
         translate(Position + [x/2,y/2,z/2]) bar();
    }
    else{
        translate(Position) bar();
    }
    
    module bar(){
    if (hor)
        {
            for (i=[-x/2:2*nozzle:x/2]){ translate([i,0,0])cube([nozzle,y,z],true);}
        }
     else 
        {
            for (i=[-z/2:2*nozzle:z/2]){ translate([0,0,i])cube([x,y,nozzle],true);}
        }
     }
}


AntiSupport(center=true);

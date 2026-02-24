
portWidth = 36; // mm could be 35 mm
portHeight = 11; // mm could be 10 mm
deviderHorPlacement = 16;
portDepth = 9; // mm should be fine...

holdingDepth = 30; // nice!
holdingPadding = 5; // nice!
grove = 1;
$fn = 300;



//[[- constructs

/**
 * create a square/reqtangle but the negative x side is rounded.
 */
module signForm(x,y,z) { 
    cylinderRadius = y/2;

    cube([x-cylinderRadius, z, y]);
    rotate([90,90,0]) 
    translate([-y/2,0,-z])
    cylinder(h=cylinderRadius, r=cylinderRadius,z);
}
// -]]


module connectivity() {
    // outer ring
    difference()
    {
        signForm(
            portWidth,
            portHeight,
            portDepth

        );
    
        translate([0, -.001, grove])
            signForm(
                portWidth-grove*2,
                portHeight-grove*2,
                portDepth+.002

            );
    
    }
    //*///
    
    // devider

     //  
    color("#ff0000")
    translate([deviderHorPlacement,0,grove])
    cube([grove, portDepth, portHeight-grove*2+.1]);
}
//[[- composistion

 color("#c3c3cf")
connectivity();


// handle and logistics room
color("#3f3f3f")
translate([0,portDepth,(portHeight-holdingPadding)/-2])
    signForm(
        portWidth+holdingPadding,
        portHeight+holdingPadding,
        holdingDepth
    );

//*/// end handle

//-]]
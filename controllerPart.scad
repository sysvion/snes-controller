
portWidth = 36; // mm could be 35 mm
portHeight = 11; // mm could be 10 mm
deviderHorPlacement = portWidth-16;
portDepth = 9; // mm should be fine...
conectorRadius = 3/2;

holdingDepth = 30; // nice!
holdingPadding = 5; // nice!
grove = 1;

cabblePadding = 4;



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

// module cableHole(width) {}

module alighnmentGroves() {
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
    color("#ff0000")
    translate([deviderHorPlacement-portHeight ,0,grove])
    cube([grove, portDepth, portHeight-grove*2+.1]);
}
//[[- composistion

color("#c3c3cf")
alighnmentGroves();


// handle and logistics room
color("#3f3f3f")
translate([0,portDepth,(portHeight-holdingPadding)/-2])
    difference() 
    {

        signForm(
            portWidth+holdingPadding,
            portHeight+holdingPadding,
            holdingDepth
        );
        translate([0,1,grove])
        signForm(
            portWidth+holdingPadding-grove*2,
            portHeight+holdingPadding-grove*2,
            holdingDepth+0.2
        );
    }
//*/// handle

// cable alignment circles
translate([
    1,
    portDepth+2, // two to make it go through
    portHeight/2
    ])
rotate([90,90,0]) 
    for (offset = [0:cabblePadding:cabblePadding*2]) {
        translate([0,offset - portHeight/2,0])
        cylinder(
            h=portDepth+grove,
            r=conectorRadius
        );
    }

translate([
    portWidth - conectorRadius*2 - grove,
    portDepth+2, // two to make it go through,
    portHeight/2
])
rotate([90,90,0]) 
    for (offset = [0:cabblePadding:cabblePadding*3]) {
        translate([0,-offset-portHeight/2,0])
        cylinder(
            h=portDepth+grove,
            r=conectorRadius
        );
    }

//*/// cable alignment circles
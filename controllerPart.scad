
portWidth = 36; // mm could be 35 mm
portHeight = 11; // mm could be 10 mm
deviderHorPlacement = portWidth-16;
portDepth = 9; // mm should be fine...
conectorRadius = 3/2;

holdingDepth = 30; // nice!
holdingPadding = 5; // nice!
grove = 1;

cabblePadding = 4;

furthestSmallHole = 14 - conectorRadius*2;
furthestLargeHole = 32.8 -  conectorRadius*2;

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
    
        translate([0, -1, grove])
            signForm(
                portWidth-grove*2,
                portHeight-grove*2,
                portDepth+2

            );
    
    }
    //*///
    
    
    
    // devider
    color("#ff0000")
    translate([deviderHorPlacement-portHeight ,0,grove])
    cube([grove, portDepth, portHeight-grove*1]);
}

module handleroom() {
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
            holdingDepth+ .001
        );
    }
}

// cable alignment circles
cablesStartX = 
    - conectorRadius*2 
    - grove/2  // radius 
   ;    
cableStartY = portDepth+grove+.01; // grove to make it go through 
cablesStartZ = portHeight/2 - grove/2;

// conectorRadius*2+grove/2
module CableCluster(radius, lenght, spacingBetween, cableCount, furthest) {
    translate([
    cablesStartX,
    cableStartY,
    cablesStartZ
    ])
rotate([90,90,0]) 
    for (offset = [
        0:
        radius*2+spacingBetween:
        (radius*2+spacingBetween)*cableCount
    ]) {
        translate([0,
       furthest - offset,
        0])
        cylinder(
            h=lenght,
            r=radius
        );
    }
    
}

//[[- composistion
difference() 
{
    union() {
        color("#c3c3cf")
        translate([grove/2,0,-grove/2])
        alighnmentGroves();


        color("#3f3f3f")
        handleroom();

        CableCluster(
            conectorRadius,
            portDepth+grove-.001,
            grove/2,
            2,
            furthestSmallHole
        );
        CableCluster(
            conectorRadius,
            portDepth+grove-.001,
            grove/2,
            3,
            furthestLargeHole
        );
    };
    union() {
        CableCluster(
            conectorRadius/2,
            portDepth+grove+200, // yes 
            conectorRadius+grove/2,
            2,
            furthestSmallHole
        );
         CableCluster(
            conectorRadius/2,
            portDepth+grove+200, // yes 
            conectorRadius+grove/2,
            3,
            furthestLargeHole
        );
    }
}
//*/// cable alignment circles
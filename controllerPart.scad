grove = 1.25;

portWidth = 34.6; // mm could be 35 mm
portHeight = 8.9; // mm could be 10 mm
deviderHorPlacement = 16.7 - grove*2;
portDepth = 9; // mm should be fine...
conectorRadius = 1.7;

holdingDepth = 30; // nice!
holdingPadding = 5; // nice!

cabblePadding = 4;
furthestSmallHole = 13 - conectorRadius*2;
furthestLargeHole = 31.3 -  conectorRadius*2;

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
    
    
    
    
}

module handleroom() {
    translate([0,portDepth,(portHeight-holdingPadding+grove)/-2])
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
            holdingDepth+.001
        );
    }
}

// cable alignment circles
cableStartY = portDepth+grove+.01; // grove to make it go through 
cablesStartZ = portHeight/2 - grove/2;

// conectorRadius*2+grove/2
module CableCluster(radius, lenght, spacingBetween, cableCount, furthest) {
    
    cablesStartX = 0
        + radius
        - (portHeight-grove*2)/2
        + grove/2
    ;
    
    translate([
    cablesStartX,
    cableStartY+lenght*0.0001,
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
            radius=conectorRadius,
            lenght=portDepth+grove-.001,
            spacingBetween=grove/2,
            cableCount=2,
            furthest=furthestSmallHole
        );
        CableCluster(
            radius=conectorRadius,
            lenght=portDepth+grove-.001,
            spacingBetween=grove/2,
            cableCount=3,
            furthest=furthestLargeHole
        );
    };
    union() {
        
        CableCluster(
            conectorRadius/2,
            portDepth+grove+200, // yes 
            conectorRadius+grove/2,
            2,
            furthestSmallHole+conectorRadius/2
        );
         CableCluster(
            conectorRadius/2,
            portDepth+grove+200, // yes 
            conectorRadius+grove/2,
            3,
            furthestLargeHole+conectorRadius/2
        );
    }
}
//*/// cable alignment circles
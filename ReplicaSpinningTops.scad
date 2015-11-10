// 2015-11-09 Todd Coffey
// Designed from scratch in OpenSCAD using the following for inspiration:
// 
// Super Ball spinning TOP:  http://www.thingiverse.com/thing:602448
// Coin Top:  http://www.thingiverse.com/thing:317809
//

// for 1mm nozzle and 0.5mm layers (0.3 first) adjust to make holes a bit bigger:
adjust = 0.5;

penny_diameter = 19.03;
penny_thickness = 1.35+adjust;

nickel_diameter = 21.21;
nickel_thickness = 1.90+adjust;

dime_diameter = 17.88;
dime_thickness = 1.31+adjust;

quarter_diameter = 24.05;
quarter_thickness = 1.69+adjust;

coin_exposure = 8.4;

top_diameter = 60; // 46.76
top_height = 40; // 45.80
handle_diameter = 6.5; // 5.75
top_thickness = 5; //4.3

bearing_diameter = 9.5+adjust;
bearing_exposure = 4.6; // 3.5

masterFN = 100;

x0 = handle_diameter/2; 
y0 = top_height;  
x1 = top_diameter/2;  
y1 = top_thickness; 

N = masterFN;

function xCoord(i) = x0+i*(x1-x0)/N;
function f(x,a,b) = a*exp(1/x)+b;
a = (y1-y0)/(exp(1/x1)-exp(1/x0));
b = y0-a*exp(1/x0);

module basic_top()
{
    points = [ for (i = [0 : N]) [ xCoord(i), f(xCoord(i),a,b) ] ];
    axes_points = [[x1,0],[0,0],[0,y0]];
    rotate_extrude(,$fn=masterFN)
    {
        polygon(concat(axes_points,points));
        translate([0,y0])
        {
            difference() 
            {
                circle(r=x0,$fn=masterFN);
                translate([-x0,-x0])
                square([x0,2*x0]);
            }
        }
        translate([x1,y1/2])
        circle(d=y1,$fn=masterFN);
    }
}
//basic_top();

module full_top()
{
    difference()
    {
        basic_top();
        bearing();
        penny();
        nickel();
        dime();
        quarter();
    }
}
full_top();

module bearing()
{
    translate([0,0,bearing_diameter/2-bearing_exposure])
    {
        sphere(d=bearing_diameter,$fn=masterFN);
    }
}
module penny()
{
    //translate([0,0,penny_diameter/2-coin_exposure])
    rotate([90,0,0])
    translate([0,0,-penny_thickness/2])
    cylinder(d=penny_diameter,h=penny_thickness,$fn=masterFN);
}
module nickel()
{
    //translate([0,0,nickel_diameter/2-coin_exposure])
    rotate([90,0,45])
    translate([0,0,-nickel_thickness/2])
    cylinder(d=nickel_diameter,h=nickel_thickness,$fn=masterFN);
}
module dime()
{
    //translate([0,0,dime_diameter/2-coin_exposure])
    rotate([90,0,90])
    translate([0,0,-dime_thickness/2])
    cylinder(d=dime_diameter,h=dime_thickness,$fn=masterFN);
}
module quarter()
{
    //translate([0,0,quarter_diameter/2-coin_exposure])
    rotate([90,0,135])
    translate([0,0,-quarter_thickness/2])
    cylinder(d=quarter_diameter,h=quarter_thickness,$fn=masterFN);
}


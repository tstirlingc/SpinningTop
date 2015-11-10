// Two Top designs learned from:
// Super Ball spinning TOP:  http://www.thingiverse.com/thing:602448
// Coin Top:  http://www.thingiverse.com/thing:317809

// Coin Top:
penny_diameter = 19.03;
penny_thickness = 1.35;

nickel_diameter = 21.21;
nickel_thickness = 1.90;

dime_diameter = 17.88;
dime_thickness = 1.31;

quarter_diameter = 24.05;
quarter_thickness = 1.69;

coin_exposure = 8.4;

top_diameter = 50; //46.76
top_height = 50; // 45.80
handle_diameter = 5; // 5.75
top_thickness = 4; //4.3

bearing_diameter = 9.5;
bearing_exposure = 3.5;

masterFN = 100;

//module basic_top() 
//{
//    handle();
//    difference()
//    {
//        sphere(d=top_diameter,$fn=masterFN);
//        translate([0,0,-top_diameter/2]) 
//        {
//            cube([2*top_diameter,2*top_diameter,top_diameter],center=true);
//        }
//    }
//}
//module handle()
//{
//    cylinder(d=handle_diameter,h=top_height,$fn=masterFN);
//}

module full_top()
{
    difference()
    {
        basic_top2();
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
    translate([0,0,penny_diameter/2-coin_exposure])
    rotate([90,0,0])
    translate([0,0,-penny_thickness/2])
    cylinder(d=penny_diameter,h=penny_thickness,$fn=masterFN);
}
module nickel()
{
    translate([0,0,nickel_diameter/2-coin_exposure])
    rotate([90,0,45])
    translate([0,0,-nickel_thickness/2])
    cylinder(d=nickel_diameter,h=nickel_thickness,$fn=masterFN);
}
module dime()
{
    translate([0,0,dime_diameter/2-coin_exposure])
    rotate([90,0,90])
    translate([0,0,-dime_thickness/2])
    cylinder(d=dime_diameter,h=dime_thickness,$fn=masterFN);
}
module quarter()
{
    translate([0,0,quarter_diameter/2-coin_exposure])
    rotate([90,0,135])
    translate([0,0,-quarter_thickness/2])
    cylinder(d=quarter_diameter,h=quarter_thickness,$fn=masterFN);
}
x0 = handle_diameter/2; 
y0 = top_height;  
x1 = top_diameter/2;  
y1 = top_thickness; 
echo(x0=x0,y0=y0);
echo(x1=x1,y1=y1);

N = masterFN;
function xCoord(i) = x0+i*(x1-x0)/N;

function f(x,a,b) = a*exp(1/x)+b;
a = (y1-y0)/(exp(1/x1)-exp(1/x0));
b = y0-a*exp(1/x0);

module basic_top2()
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
//basic_top2();
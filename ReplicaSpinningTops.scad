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

coin_exposure = 8.4;

top_diameter = 46.76;
top_height = 45.80;
handle_diameter = 5.75;
top_thickness = 4.3;

bearing_diameter = 9.5;
bearing_exposure = 3.5;

masterFN = 100;

module basic_top() 
{
    difference()
    {
        sphere(d=top_diameter,$fn=masterFN);
        translate([0,0,-top_diameter/2]) 
        {
            cube([2*top_diameter,2*top_diameter,top_diameter],center=true);
        }
    }
    cylinder(d=handle_diameter,h=top_height,$fn=masterFN);
}

difference()
{
    basic_top();
    translate([0,0,bearing_diameter/2-bearing_exposure])
    {
        sphere(d=bearing_diameter,$fn=masterFN);
    }
    penny();
    nickel();
    dime();
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
    rotate([90,0,60])
    translate([0,0,-nickel_thickness/2])
    cylinder(d=nickel_diameter,h=nickel_thickness,$fn=masterFN);
}
module dime()
{
    translate([0,0,dime_diameter/2-coin_exposure])
    rotate([90,0,120])
    translate([0,0,-dime_thickness/2])
    cylinder(d=dime_diameter,h=dime_thickness,$fn=masterFN);
}

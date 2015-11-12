// 2015-11-09 Todd Coffey
// Designed from scratch in OpenSCAD using the following for inspiration:
// 
// Super Ball spinning TOP:  http://www.thingiverse.com/thing:602448
// Coin Top:  http://www.thingiverse.com/thing:317809
//
difference()
{
    full_top();
    coin_text();
    logo();
}

// for 1mm nozzle and 0.5mm layers (0.3 first) adjust to make holes a bit bigger:
adjust = 0.6;

// Add text to bottom of top with "P", "N", "D", "Q" for coin slots
// Add text to bottom of top for attribution:  "Coffey"
penny_diameter = 19.03+adjust;
penny_thickness = 1.35+adjust;

nickel_diameter = 21.21+adjust;
nickel_thickness = 1.90+adjust;

dime_diameter = 17.88+adjust;
dime_thickness = 1.31+adjust;

quarter_diameter = 24.05+adjust;
quarter_thickness = 1.69+adjust;

coin_depth_percentage = 10/100;

top_diameter = 40; // 46.76
top_height = 40; // 45.80
handle_diameter = 6; // 5.75
top_thickness = 6; //4.3

bearing_diameter = 9.5+adjust;
bearing_exposure = 3.5; // 3.5

coin_text_offset_from_slot = 0.5;

masterFN = 100;

x0 = handle_diameter/2; 
y0 = top_height;  
x1 = top_diameter/2;  
y1 = top_thickness; 

N = masterFN;

function xCoord(i) = x0+i*(x1-x0)/N;
function g(x) = exp(1/pow(x,1));
function f(x,a,b) = a*g(x)+b;
a = (y1-y0)/(g(x1)-g(x0));
b = y0-a*g(x0);

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

module bearing()
{
    translate([0,0,bearing_diameter/2-bearing_exposure])
        sphere(d=bearing_diameter,$fn=masterFN);
}
module penny()
{
    translate([0,0,coin_depth_percentage*penny_diameter])
        rotate([90,0,0])
            cylinder(d=penny_diameter,h=penny_thickness,center=true,$fn=masterFN);
}
module nickel()
{
    translate([0,0,coin_depth_percentage*nickel_diameter])
        rotate([90,0,45]) 
            cylinder(d=nickel_diameter,h=nickel_thickness,center=true,$fn=masterFN);
}
module dime()
{
    translate([0,0,coin_depth_percentage*dime_diameter])
        rotate([90,0,90])
            cylinder(d=dime_diameter,h=dime_thickness,center=true,$fn=masterFN);
}   
module quarter()
{
    translate([0,0,coin_depth_percentage*quarter_diameter])
        rotate([90,0,135])
            cylinder(d=quarter_diameter,h=quarter_thickness,center=true,$fn=masterFN);
}

module coin_text()
{
    rotate([0,180,-90+0])
        translate([0,penny_diameter/2+coin_text_offset_from_slot,0]) 
            text("P",size=6,halign="center",valign="bottom");
    rotate([0,180,-90+45])
        translate([0,nickel_diameter/2+coin_text_offset_from_slot,0]) 
            text("N",size=6,halign="center",valign="bottom");
    rotate([0,180,-90+90])
        translate([0,dime_diameter/2+coin_text_offset_from_slot,0]) 
            text("D",size=6,halign="center",valign="bottom");
    rotate([0,180,-90+135])
        translate([0,quarter_diameter/2+coin_text_offset_from_slot,0]) 
            text("Q",size=6,halign="center",valign="bottom");
}
module rotated_translated_character(char,radius,angle)
{
    rotate([0,180,angle]) translate([0,radius,0]) text(char,size=6,halign="center");

}
module logo()
{
    radius=12;
    start_angle = 120;
    offsets = [0,20,35,45,60,77];
    rotated_translated_character("C",radius,start_angle+offsets[0]);
    rotated_translated_character("o",radius,start_angle+offsets[1]);
    rotated_translated_character("f",radius,start_angle+offsets[2]);
    rotated_translated_character("f",radius,start_angle+offsets[3]);
    rotated_translated_character("e",radius,start_angle+offsets[4]);
    rotated_translated_character("y",radius,start_angle+offsets[5]);
    //rotate([0,180,offset]) translate([0,radius,0]) text("C",size=6,halign="center");
//    rotate([0,180,offset]) translate([0,radius,0]) text("o",size=6,halign="center");
//    rotate([0,180,offset]) translate([0,radius,0]) text("f",size=6,halign="center");
//    rotate([0,180,offset]) translate([0,radius,0]) text("f",size=6,halign="center");
//    rotate([0,180,offset]) translate([0,radius,0]) text("e",size=6,halign="center");
//    rotate([0,180,offset]) translate([0,radius,0]) text("y",size=6,halign="center");
}
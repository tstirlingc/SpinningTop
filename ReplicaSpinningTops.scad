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
top_height = 40; // 45.80
handle_diameter = 5; // 5.75
top_thickness = 4; //4.3

bearing_diameter = 9.5;
bearing_exposure = 3.5;

masterFN = 100;

module basic_top() 
{
    handle();
    difference()
    {
        sphere(d=top_diameter,$fn=masterFN);
        translate([0,0,-top_diameter/2]) 
        {
            cube([2*top_diameter,2*top_diameter,top_diameter],center=true);
        }
    }
}
module handle()
{
    cylinder(d=handle_diameter,h=top_height,$fn=masterFN);
}

module full_top()
{
    difference()
    {
        basic_top2();
        bearing();
        penny();
        nickel();
        dime();
    }
}
//full_top();

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

//function g(c,x0,y0,x1,y1) = pow(x1-c,-2)-pow(x0-c,-2)+y0-y1;
//function gprime(c,x0,y0,x1,y1) = 2*pow(x1-c,-3)-2*pow(x0-c,-3);

//function computeC(c0,x0,y0,x1,y1) = c0-g(c0,x0,y0,x1,y1)/gprime(c0,x0,y0,x1,y1);

//function computeA(c,x0,y0) = y0-pow(x0-c,-2);

//function f(x,a,c) = pow(x-c,-2)+b;


x0 = handle_diameter/2; 
y0 = top_height;  
x1 = top_diameter/2;  
y1 = top_thickness; 
echo(x0=x0,y0=y0);
echo(x1=x1,y1=y1);
//c0 = -1; echo("c0 = ",c0);
//c1 = computeC(c0,x0,y0,x1,y1); echo("c1 = ",c1);
//c2 = computeC(c1,x0,y0,x1,y1); echo("c2 = ",c2);
//c3 = computeC(c2,x0,y0,x1,y1); echo("c3 = ",c3);
//c = computeC(c3,x0,y0,x1,y1); echo("c = ",c);
//a = computeA(c,x0,y0); echo("a = ",a);

//function f(x,b,c) = pow(x,2)+b*x+c;
//b = (pow(x0,2)-pow(x1,2)+y1-y0)/(x1-x0); echo("b = ",b);
//c = y0-pow(x0,2)-b*x0; echo("c = ",c);

//function f(x,a3,a2,a1,a0) = a3*pow(x,3)+a2*pow(x,2)+a1*x+a0;
//b = 10;
//s = 1;
//alpha = 2*x0+(pow(x0,2)-pow(x1,2))/(x1-x0);
//m = (y1-y0)/(x1-x0);
//beta = (pow(x0,3)-pow(x1,3))/(x1-x0);
//num = (-s+(2*b+2*m)*x1/alpha-(y1-y0)+(b*(pow(x0,2)-pow(x1,2))+m)/alpha);
//den = 3*pow(x1,2)-6*pow(x0,2)*x1/alpha-2*beta*x1/alpha+(pow(x0,3)-pow(x1,3))-3*pow(x0,2)*(pow(x0,2)-pow(x1,2))/alpha-(pow(x0,2)-pow(x1,2))*beta/alpha;
//a3 = num/den;
//a2 = (-b-3*a3*pow(x0,2)-(y1-y0+a3*(pow(x0,3)-pow(x1,3)))/(x1-x0))/(2*x0+(pow(x0,2)-pow(x1,2))/(x1-x0));
//a1 = (y1-a3*pow(x1,3)-a2*pow(x1,2)-y0+a3*pow(x0,3)+a2*pow(x0,2))/(x1-x0);
//a0 = y0-a3*pow(x0,3)-a2*pow(x0,2)-a1*x0;
//echo(a0=a0, a1=a1, a2=a2, a3=a3);

//function f(x,a,b,omega) = a*cos(omega*x)+b;
//pi = 4*atan(1);
//omega = pi/x1;
//a = (y1-y0)/(cos(omega*x1)-1);
//b = y0-a;
//
N = 10;
function xCoord(i) = x0+i*(x1-x0)/N;

//function f(x,a,b) = b-ln(x-a);
//function g(a) = ln(x0-a)-ln(x1-a)+y0-y1;
//function gp(a) = 1/(x1-a)-1/(x0-a);
//a0 = 2;
//a1 = a0-g(a0)/gp(a0); echo(a1=a1);
//a2 = a1-g(a1)/gp(a1); echo(a2=a2);
//a = a2-g(a2)/gp(a2); 
//b = y0+ln(x0-a);
//echo(a=a,b=b);

//function y1(x,a,b) = ln(x-a)+b;
//function y2(x,c,d) = c*exp(-x+d);
//x2 = (x0+x1)/2; echo(x2=x2);
//a = 1+x2; echo(a=a);
//b = y0-ln(x0-a); echo(b=b);
//c = y1/exp(-x1+d); echo(c=c);
//d = x2+ln(1/c); echo(d=d);

function f(x,a,b) = a*exp(1/x)+b;
a = (y1-y0)/(exp(1/x1)-exp(1/x0));
b = y0-a*exp(1/x0);

module basic_top2()
{
    points = [ for (i = [0 : N]) [ xCoord(i), f(xCoord(i),a,b) ] ];
    axes_points = [[x1,0],[0,0],[0,y0]];
    rotate_extrude()
    polygon(concat(axes_points,points));
}
basic_top2();
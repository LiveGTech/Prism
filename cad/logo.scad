include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

$fn = 50;

isL = true;

sep = 1e-3;
sep2 = sep * 2;

diameter = 39;
lip = 3;
height = 3;

module circle() {
    cyl(h = height, d1 = diameter + lip, d2 = diameter, align = V_TOP);
}

module square(cut = false) {
    translate([0, 0, cut ? -sep : 0]) {
        cube([diameter, diameter, cut ? height + sep2 : height]);
    }
}

module l() {
    intersection() {
        circle();
        square();
    }
}

module g() {
    difference() {
        circle();
        square(true);
    }
}

if (isL) {
    translate([0, 0, sep]) color("#ffff00") l();
} else {
    translate([-sep, -sep, 0]) color("#00b0f0") g();
}
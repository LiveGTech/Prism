/*
    Prism

    Copyright (C) LiveG. All Rights Reserved.

    https://liveg.tech
    Licensed by the LiveG Open-Source Licence, which can be found at LICENCE.md.
*/

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

$fn = $preview ? 20 : 50;

isL = false;

sep = 1e-3;
sep2 = sep * 2;

diameter = 40.5;
height = 1.2;
lipHeight = 0.2;
lipDiameter = 44;

module circle() {
    cyl(h = height, d = diameter, align = V_TOP);
    cyl(h = lipHeight, d = lipDiameter, align = V_TOP);
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
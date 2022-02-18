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

sep = 1e-3;
sep2 = sep * 2;

height = 1;
diameter = 5;
holeDiameter = 1;
capDiameter = 4;

batteryClipWidth = 10;
batteryClipHeight = 9;
batteryClipOffset = 3;

for (i = [0 : 3]) {
    translate([i * 10, 0, 0]) {
        difference() {
            cyl(h = height, d = diameter, align = V_TOP);
            down(sep) cyl(h = height + sep2, d1 = holeDiameter, d2 = capDiameter, align = V_TOP);
        }
    }
}

translate([-10, 5, 0]) {
    difference() {
        cuboid([batteryClipWidth, batteryClipHeight, 1], align = V_TOP + V_LEFT + V_FRONT);        
        down(sep) translate([-batteryClipOffset, (-capDiameter / 2), 0]) cyl(h = height + sep2, d1 = holeDiameter, d2 = capDiameter, align = V_TOP + V_LEFT + V_FRONT);
    }
}
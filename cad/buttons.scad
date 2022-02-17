/*
    Prism

    Copyright (C) LiveG. All Rights Reserved.

    https://liveg.tech
    Licensed by the LiveG Open-Source Licence, which can be found at LICENCE.md.
*/

include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

$fn = 50;

isVolume = true;

volumeWidth = 18;
powerWidth = 8;
height = 1.5;

innerDepth = 0.5;
thickness = 1;
outerDepth = 2;
overhang = 2;
push = 0;

if (isVolume) {
    cuboid([volumeWidth + (overhang * 2), height, innerDepth], align = V_TOP, fillet = height / 2, edges = EDGES_Z_ALL);
    translate([0, 0, innerDepth]) cuboid([volumeWidth, height, outerDepth + innerDepth], align = V_TOP, fillet = height / 2, edges = EDGES_Z_ALL);
    translate([-(volumeWidth / 3), 0, 0]) cyl(l = push, d = height, align = V_BOTTOM);
    translate([volumeWidth / 3, 0, 0]) cyl(l = push, d = height, align = V_BOTTOM);
} else {
    cuboid([powerWidth + (overhang * 2), height, innerDepth], align = V_TOP, fillet = height / 2, edges = EDGES_Z_ALL);
    translate([0, 0, innerDepth]) cuboid([powerWidth, height, outerDepth + innerDepth], align = V_TOP, fillet = height / 2, edges = EDGES_Z_ALL);
    cyl(l = push, d = height, align = V_BOTTOM);
}
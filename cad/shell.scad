include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

$fn = 20;
sep = 1e-3;
sep2 = sep * 2;

prototypeMode = true;

thickness = 1;
innerRadius = 10;

innerWidth = 75;
innerHeight = 160;
innerDepth = 6.5;

outerWidth = innerWidth + (2 * thickness);
outerHeight = innerHeight + (2 * thickness);
outerDepth = innerDepth + thickness;

cutoutWidth = 21;
cutoutHeight = 8;
cutoutRadius = cutoutHeight / 2;
rightEdgeToLeftCutout = 35;
frontEdgeToFrontCutout = 2;

jackDiameter = 5;
leftEdgeToJack = 23;
topToJack = 1 + (jackDiameter / 2);

volumeButtonsHeight = 20;
powerButtonHeight = 10;
buttonsDepth = 2;
buttonsRadius = buttonsDepth / 2;
buttonsPush = 3;
topEdgeToTopButtons = 1;
frontEdgeToFrontVolumeButtons = 26;
frontEdgeToFrontPowerButton = frontEdgeToFrontVolumeButtons + volumeButtonsHeight + 7;

difference() {
    zscale(outerDepth / (innerRadius * 2)) cuboid([outerWidth, outerHeight, innerRadius * 2], align = V_BOTTOM, fillet = innerRadius, edges = EDGES_Z_ALL + EDGES_BOTTOM);
    up(sep) zscale(innerDepth / (innerRadius * 2)) cuboid([innerWidth, innerHeight, innerRadius * 2], align = V_BOTTOM, fillet = innerRadius, edges = EDGES_Z_ALL + EDGES_BOTTOM);
    translate([(innerWidth / 2) - rightEdgeToLeftCutout, (innerHeight / 2) - frontEdgeToFrontCutout, -innerDepth - thickness]) cuboid([cutoutWidth, cutoutHeight, innerDepth], align = V_FRONT + V_RIGHT, fillet = cutoutRadius, edges = EDGES_Z_ALL);
    translate([-(innerWidth / 2) + 23, (innerHeight / 2), -topToJack]) rotate([90, 0, 0]) cyl(l = 10, r = jackDiameter / 2);
    if (prototypeMode) {
        cuboid([innerWidth * 0.8, innerHeight * 0.8, outerHeight], align = V_BOTTOM, fillet = 4, edges = EDGES_Z_ALL);
    }
}

translate([(innerWidth / 2) + (thickness / 2), (innerHeight / 2) - frontEdgeToFrontVolumeButtons, -topEdgeToTopButtons]) cuboid([buttonsPush, volumeButtonsHeight, buttonsDepth], align = V_FRONT + V_BOTTOM, fillet = buttonsRadius, edges = EDGES_X_ALL);

translate([(innerWidth / 2) + (thickness / 2), (innerHeight / 2) - frontEdgeToFrontPowerButton, -topEdgeToTopButtons]) cuboid([buttonsPush, powerButtonHeight, buttonsDepth], align = V_FRONT + V_BOTTOM, fillet = buttonsRadius, edges = EDGES_X_ALL);
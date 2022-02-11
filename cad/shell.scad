include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>

$fn = 50;
sep = 1e-3;
sep2 = sep * 2;

prototypeMode = true;

thickness = 1;
innerRadius = 10;

innerWidth = 74.5;
innerHeight = 158;
innerDepth = 8.5;

outerWidth = innerWidth + (2 * thickness);
outerHeight = innerHeight + (2 * thickness);
outerDepth = innerDepth + thickness;

cutoutWidth = 8;
cutoutHeight = 8;
cutoutRadius = cutoutHeight / 2;
leftEdgeToLeftCutout = 14;
frontEdgeToFrontCutout = 2;

jackDiameter = 5;
leftEdgeToJack = 23;
topToJack = 1 + (jackDiameter / 2);

usbWidth = 10;
usbHeight = 4;
usbRadius = usbHeight / 2;
topToUsb = 2;

volumeButtonsHeight = 20;
powerButtonHeight = 10;
buttonsDepth = 2;
buttonsRadius = buttonsDepth / 2;
topEdgeToTopButtons = 1;
frontEdgeToFrontVolumeButtons = 26;
frontEdgeToFrontPowerButton = frontEdgeToFrontVolumeButtons + volumeButtonsHeight + 7;

difference() {
    // Main shell
    zscale(outerDepth / (innerRadius * 2)) cuboid([outerWidth, outerHeight, innerRadius * 2], align = V_BOTTOM, fillet = innerRadius, edges = EDGES_Z_ALL + EDGES_BOTTOM);
    up(sep) zscale(innerDepth / (innerRadius * 2)) cuboid([innerWidth, innerHeight, innerRadius * 2], align = V_BOTTOM, fillet = innerRadius, edges = EDGES_Z_ALL + EDGES_BOTTOM);

    // Camera cutout
    translate([(innerWidth / 2) - leftEdgeToLeftCutout, (innerHeight / 2) - frontEdgeToFrontCutout, -innerDepth - thickness]) cuboid([cutoutWidth, cutoutHeight, innerDepth], align = V_FRONT + V_LEFT, fillet = cutoutRadius, edges = EDGES_Z_ALL);
    
    // Audio jack cutout
    translate([-(innerWidth / 2) + 23, (innerHeight / 2), -topToJack]) rotate([90, 0, 0]) cyl(l = 10, r = jackDiameter / 2);

    // Prototype window
    if (prototypeMode) {
        cuboid([innerWidth * 0.8, innerHeight * 0.8, outerHeight], align = V_BOTTOM, fillet = 4, edges = EDGES_Z_ALL);
    }

    // Buttons
    translate([(innerWidth / 2) - sep, (innerHeight / 2) - frontEdgeToFrontVolumeButtons, -topEdgeToTopButtons]) cuboid([thickness + sep2, volumeButtonsHeight, buttonsDepth], align = V_FRONT + V_BOTTOM + V_RIGHT, fillet = buttonsRadius, edges = EDGES_X_ALL);
    translate([(innerWidth / 2) - sep, (innerHeight / 2) - frontEdgeToFrontPowerButton, -topEdgeToTopButtons]) cuboid([thickness + sep2, powerButtonHeight, buttonsDepth], align = V_FRONT + V_BOTTOM + V_RIGHT, fillet = buttonsRadius, edges = EDGES_X_ALL);

    // USB cutout
    translate([0, -(innerHeight / 2), -topToUsb]) cuboid([usbWidth, 10, usbHeight], align = V_BOTTOM, fillet = usbRadius, edges = EDGES_Y_ALL);
}
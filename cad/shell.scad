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

prototypeMode = false;

thickness = 1;
innerRadius = 10;

innerWidth = 74;
innerHeight = 157.5;
innerDepth = 8.5;

outerWidth = innerWidth + (2 * thickness);
outerHeight = innerHeight + (2 * thickness);
outerDepth = innerDepth + thickness;

cutoutWidth = 8;
cutoutHeight = 8;
cutoutRadius = cutoutHeight / 2;
leftEdgeToLeftCutout = 13.5;
frontEdgeToFrontCutout = 2.5;

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

logoDiameter = 41.5;

speakerPushWidth = 15;
speakerPushHeight = 10;
speakerPushDepth = 1;
speakerPushRadius = 2;
backEdgeToBackSpeakerPush = 6;
centreEdgeToRightSpeakerPush = 10;

batteryPushWidth = 5;
batteryPushHeight = 30;
batteryPushDepth = 0;
batteryPushRadius = 2;
backEdgeToBatteryPush = 25;
centreEdgeToBatteryPushSides = 20;

difference() {
    // Main shell
    zscale(outerDepth / (innerRadius * 2)) cuboid([outerWidth, outerHeight, innerRadius * 2], align = V_BOTTOM, fillet = innerRadius, edges = EDGES_Z_ALL + EDGES_BOTTOM);
    up(sep) zscale(innerDepth / (innerRadius * 2)) cuboid([innerWidth, innerHeight, innerRadius * 2], align = V_BOTTOM, fillet = innerRadius, edges = EDGES_Z_ALL + EDGES_BOTTOM);

    // Camera cutout
    translate([(innerWidth / 2) - leftEdgeToLeftCutout, (innerHeight / 2) - frontEdgeToFrontCutout, -innerDepth - thickness]) cuboid([cutoutWidth, cutoutHeight, innerDepth], align = V_FRONT + V_LEFT, fillet = cutoutRadius, edges = EDGES_Z_ALL);
    
    // Audio jack cutout
    translate([-(innerWidth / 2) + 23, (innerHeight / 2), -topToJack]) rotate([90, 0, 0]) cyl(l = 10, r = jackDiameter / 2);

    if (prototypeMode) {
        // Prototype window
        cuboid([innerWidth * 0.8, innerHeight * 0.8, outerHeight], align = V_BOTTOM, fillet = 4, edges = EDGES_Z_ALL);
    } else {
        // Logo cutout
        translate([0, 0, -innerDepth + sep2]) cyl(l = thickness + (3 * sep), d = logoDiameter, align = V_BOTTOM);
    }

    // Buttons
    translate([(innerWidth / 2) - sep, (innerHeight / 2) - frontEdgeToFrontVolumeButtons, -topEdgeToTopButtons]) cuboid([thickness + sep2, volumeButtonsHeight, buttonsDepth], align = V_FRONT + V_BOTTOM + V_RIGHT, fillet = buttonsRadius, edges = EDGES_X_ALL);
    translate([(innerWidth / 2) - sep, (innerHeight / 2) - frontEdgeToFrontPowerButton, -topEdgeToTopButtons]) cuboid([thickness + sep2, powerButtonHeight, buttonsDepth], align = V_FRONT + V_BOTTOM + V_RIGHT, fillet = buttonsRadius, edges = EDGES_X_ALL);

    // USB cutout
    translate([0, -(innerHeight / 2), -topToUsb]) cuboid([usbWidth, 10, usbHeight], align = V_BOTTOM, fillet = usbRadius, edges = EDGES_Y_ALL);
}

// Speaker push surface (to hold speaker in place)
translate([-centreEdgeToRightSpeakerPush, -(innerHeight / 2) + backEdgeToBackSpeakerPush, -innerDepth]) cuboid([speakerPushWidth, speakerPushHeight, speakerPushDepth], align = V_BACK + V_LEFT + V_TOP, fillet = speakerPushRadius, edges = EDGES_Z_ALL);

// Left battery push surface (to hold battery in place)
translate([-centreEdgeToBatteryPushSides, -(innerHeight / 2) + backEdgeToBatteryPush, -innerDepth]) cuboid([batteryPushWidth, batteryPushHeight, batteryPushDepth], align = V_BACK + V_LEFT + V_TOP, fillet = batteryPushRadius, edges = EDGES_Z_ALL);

// Right battery push surface (to hold battery in place)
translate([centreEdgeToBatteryPushSides, -(innerHeight / 2) + backEdgeToBatteryPush, -innerDepth]) cuboid([batteryPushWidth, batteryPushHeight, batteryPushDepth], align = V_BACK + V_RIGHT + V_TOP, fillet = batteryPushRadius, edges = EDGES_Z_ALL);
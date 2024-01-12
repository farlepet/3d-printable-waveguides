/*******************************
 * Waveguide section generator *
 *******************************/

/********************
 * Variables/Inputs *
 ********************/

/* Waveguide selection */
wrcode = 12;

/* Waveguide wall thickness */
wall = 2;

/* Flange thickness */
flanged = 3;

/* Length of waveguide section, including flanges */
length = 50;

/* Rotation angle */
rotation = 45;

/* Amount to trim back internal and mating surfaces, for the purpose of accounting for metallic tape or coating. */
trim = 0.05;

/* Set to 1 to split waveguide along short side of section. This can make coating inside of waveguide much easier. */
split_part = 0;



/******************************************************************************/

/* Import waveguide components */
include <common.scad>

difference() {
    union() {
        flange();
        translate([0, 0, (length - flanged) - (2 * trim)]) {
            rotate([0, 0, -rotation]) {
                flange();
            }
        }

        translate([0, 0, flanged*.5]) {
            waveguide_twist((length - flanged*2), rotation, $fn=4800);
        }

    }

    if(split_part) {
        translate([0, 0, flanged*0.499]) {
            linear_extrude(height=(length - flanged*1.99), twist=rotation, $fn=4800) {
                square([trim * 2, wgsize_a*4], center = true);
            }
        }

        translate([0, 0, 0]) {
            cube([trim * 2, wgsize_a*4, flanged*1.001], center=true);
        }
        translate([0, 0, (length - flanged) - (2 * trim)]) {
            rotate([0, 0, -rotation]) {
                cube([trim * 2, wgsize_a*4, flanged], center=true);
            }
        }
    }
}


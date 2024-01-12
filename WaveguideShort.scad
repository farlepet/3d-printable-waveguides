/*****************************
 * Waveguide short generator *
 *****************************/

/********************
 * Variables/Inputs *
 ********************/

/* Waveguide selection */
wrcode = 7;

/* Waveguide wall thickness */
wall = 2;

/* Flange thickness */
flanged = 3;

/* Length of waveguide short, including flange, not including thickness of shorting wall.
 * Use 0 for a shorting plate. */
length = 20;

/* Amount to trim back internal and mating surfaces, for the purpose of accounting for metallic tape or coating. */
trim = 0.05;

/* Set to 1 to split waveguide along short side of section. This can make coating inside of waveguide much easier. */
split_part = 1;



/******************************************************************************/

/* Import waveguide components */
include <common.scad>

difference() {
    union() {
        if(length == 0) {
            /* No waveguide section needed */
            flange(hole = false);
        } else {
            flange();
            translate([0, 0, length - ((flanged - trim) / 2) + (wall / 2)]) {
                cube([wgbtab[wrcode] + (wall / 2), wgatab[wrcode] + (wall / 2), wall], center=true);
            }

            waveguide(length - ((flanged - trim) / 2) + wall);
        }
    }

    if(split_part) {
        translate([-trim, -wgsize_a*2, -flanged])
            cube([trim * 2, wgsize_a*4, length*1.5]);
    }
}


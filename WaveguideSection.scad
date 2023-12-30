/*******************************
 * Waveguide section generator *
 *******************************/

/********************
 * Variables/Inputs *
 ********************/

/* Waveguide selection */
wrcode = 4;

/* Waveguide wall thickness */
wall = 2;

/* Flange thickness */
flanged = 3;

/* Length of waveguide section, including flanges */
length = 66.66;

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
        translate([0, 0, (length - flanged) - (2 * trim)]) flange();

        waveguide((length - flanged));

    }

    if(split_part) {
        translate([-trim, -50, -flanged])
            cube([trim * 2, 100, length*1.5]);
    }
}


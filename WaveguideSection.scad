/*******************************
 * Waveguide section generator *
 *******************************/

/********************
 * Variables/Inputs *
 ********************/

/* 0: N/A
 * 1: WR 112  7.05-10.00 GHz
 * 2: WR 90   8.20-12.40 GHz
 * 3: WR 75  10.00-15.00 GHz
 * 4: WR 62  12.49-18.00 GHz
 * 5: WR 51  15.00-22.00 GHz
 * 6: WR 42  18.00-26.50 GHz
 * 7: WR 34  22.00-33.00 GHz
 * 8: WR 28  26.50-40.00 GHz */

/* Waveguide selection */
wrcode = 6;

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


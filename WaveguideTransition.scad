/***********************************************
 * Waveguide-to-waveguide transition generator *
 ***********************************************/

/********************
 * Variables/Inputs *
 ********************/

/* Waveguide start and stop selection */
wrid_1 = 6;
wrid_2 = 13;

/* Length of straight waveguide between flanges and transition */
straight_1 = 10;
straight_2 = 20;

/* Waveguide wall thickness */
wall = 2;

/* Flange thickness */
flanged = 3;

/* Length of waveguide section, including flanges ans straights */
length = 75;

/* Amount to trim back internal and mating surfaces, for the purpose of accounting for metallic tape or coating. */
trim = 0.05;

/* Set to 1 to split waveguide along short side of section. This can make coating inside of waveguide much easier. */
split_part = 1;



/******************************************************************************/

/* Import waveguide components */
include <common.scad>

difference() {
    union() {
        flange(wrid=wrid_1);
        translate([0, 0, (length - flanged) - (2 * trim)]) flange(wrid=wrid_2);

        waveguide(straight_1 - flanged, wrid=wrid_1);
        translate([0, 0, (straight_1 - flanged)]) waveguide_transition((length - straight_1 - straight_2), wrid_1, wrid_2);
        translate([0, 0, (length - straight_2 - flanged)]) waveguide(straight_2, wrid=wrid_2);
    }

    if(split_part) {
        wgsize_a = max(wgatab[wrid_1], wgatab[wrid_2]);

        translate([-trim, -wgsize_a*2, -flanged])
            cube([trim * 2, wgsize_a*4, length*1.5]);
    }
}


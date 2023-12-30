/************************************
 * Waveguide horn antenna generator *
 ************************************/


/* Waveguide selection */
wrcode = 6;

/* Waveguide wall thickness */
wall = 2;

/* Flange thickness */
flanged = 3;

/* Length of waveguide section, including flanges */
length = 20;

/* Amount to trim back internal and mating surfaces, for the purpose of accounting for metallic tape or coating. */
trim = 0.05;

/* Length of horn, in wavelengths */
horn_len = 2;

/* Design frequency, in GHz */
design_freq = 6;

function ghz_to_mm(freq) = (299.792458 / freq);

design_wavelen = ghz_to_mm(design_freq);

/* Length of waveguide, including flange, feeding horn */
feed_len = 1 * design_wavelen;

/* Set to 1 to split horn along short side of section. This can make coating inside of waveguide much easier. */
split_part = 1;



/******************************************************************************/

/* Import waveguide components */
include <common.scad>

difference() {
    union() {
        translate([0, 0, (flanged / 2) + trim])
            flange();

        translate([0, 0, flanged - 0.0001])
            waveguide((feed_len - flanged) + 0.0002);

        translate([0, 0, feed_len])
            //horn(30, 30, 30);
            ideal_horn(120, 120, design_wavelen);
    }

    if(split_part) {
        /* This may beed to be modified for large horns - no visibility into actual length, especially for ideal horns */
        translate([-trim, -wgsize_a*4, -flanged])
            cube([trim * 2, wgsize_a*8, (feed_len+length)*3]);
    }
}


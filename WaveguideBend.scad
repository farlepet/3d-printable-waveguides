/****************************
 * Waveguide bend generator *
 ****************************/

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

/* Amount to trim back internal and mating surfaces, for the purpose of accounting for metallic tape or coating. */
trim = 0.05;

/* Angle of waveguide bend */
section_angle = 90;

/* Radius of the bend, taken at the center of the waveguide */
section_radius = 20;

/* Length of straight waveguide on either side of the curve, including flanges.
 * NOTE: This may not currently be accurate on the far side of the curve, the
 * flange thickness may not be appropriately accounted for. */
straight_length = 20;

/* Set to 1 to split waveguide along short side of section. This can make coating inside of waveguide much easier. */
split_part = 1;


/* TODO: Support H-bends */


/******************************************************************************/

/* Import waveguide components */
include <common.scad>

difference() {
    union() {
        flange();
        waveguide(straight_length - (flanged/2));

        translate([0, 0, straight_length - flanged]) {
            translate([-section_radius*(1-cos(section_angle)), 0,
                        section_radius*sin(section_angle)]) {
                rotate([0, -section_angle, 0]) {
                    waveguide(straight_length - (flanged/2));
                    translate([0, 0, straight_length - (flanged/2)]) {
                        flange();
                    }
                }
            }

            waveguide_bend(section_radius, section_angle);
        }
    }

    if(split_part) {
        translate([flange_size/1.9, 0, -flanged]) {
            rotate([0, 0, 180]) {
                cube([(section_radius + straight_length)*1.5,
                      trim*2,
                      (section_radius + straight_length)*1.5]);
            }
        }
    }
}


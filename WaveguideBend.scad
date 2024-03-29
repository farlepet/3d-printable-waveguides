/****************************
 * Waveguide bend generator *
 ****************************/

/********************
 * Variables/Inputs *
 ********************/

/* Waveguide selection */
wrcode = 6;

/* Waveguide wall thickness */
wall = 2;

/* Flange thickness */
flanged = 3;

/* Amount to trim back internal and mating surfaces, for the purpose of accounting for metallic tape or coating. */
trim = 0.05;

/* Wavegiode rotation
 *   0: E-bend
 *  90: H-bend */
rotation = 0;

/* Angle of waveguide bend */
section_angle = 90;

/* Radius of the bend, taken at the center of the waveguide */
section_radius = 40;

/* Length of straight waveguide on either side of the curve, including flanges.
 * NOTE: This may not currently be accurate on the far side of the curve, the
 * flange thickness may not be appropriately accounted for. */
straight_length = 80;

/* Set to 1 to split waveguide along short side of section. This can make coating inside of waveguide much easier. */
split_part = 1;


/* TODO: Support H-bends */


/******************************************************************************/

/* Import waveguide components */
include <common.scad>

difference() {
    union() {
        rotate([0, 0, -rotation]) {
            flange();
            waveguide(straight_length - (flanged/2));
        }

        translate([0, 0, straight_length - flanged]) {
            translate([-section_radius*(1-cos(section_angle))*.999, 0,
                        section_radius*sin(section_angle)]) {
                rotate([0, -section_angle, 0]) {
                    rotate([0, 0, -rotation]) {
                        waveguide(straight_length - (flanged/2));
                        translate([0, 0, straight_length - (flanged/2)]) {
                            flange();
                        }
                    }
                }
            }

            waveguide_bend(section_radius, section_angle, dir=rotation);
        }
    }

    if(split_part) {
        translate([wgsize_a*1.5, 0, -flanged]) {
            rotate([0, 0, 180]) {
                cube([(section_radius + straight_length)*2,
                      trim*2,
                      (section_radius + straight_length)*2]);
            }
        }
    }
}


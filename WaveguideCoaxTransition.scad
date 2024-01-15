/*************************************************
 * Waveguide-to-coax transition generator        *
 *  Only E-field transitions currently supported *
 *************************************************/

/********************
 * Variables/Inputs *
 ********************/

/* Waveguide selection */
wrcode = 6;

/* Waveguide wall thickness */
wall = 2;

/* Flange thickness */
flanged = 3;

/* Length of transition, including flange, not including thickness of shorting wall. */
length = 50;

/* Radius of hole for probe into waveguide, including dilectric */
probe_hole_r = 1;
/* Distance of probe hole from back wall */
probe_dist   = 12.5;
/* Offset of probe hole from center */
probe_offset = 0;

/* Distance of mounting holes from center of probe hole */
coax_mount_dist  = 4;
/* Radius of coax connector mounting holes */
coax_mount_r     = 1;
/* Number of coax connector mounting holes - holes are assumed to be equal angles from eachother */
coax_mount_n     = 0;
/* Start angle for first mount point */
coax_mount_angle = 45;



/* Amount to trim back internal and mating surfaces, for the purpose of accounting for metallic tape or coating. */
trim = 0.05;

/* Set to 1 to split waveguide along short side of section. This can make coating inside of waveguide much easier. */
split_part = 1;



/******************************************************************************/

/* Import waveguide components */
include <common.scad>

difference() {
    union() {
        flange();
        translate([0, 0, length - ((flanged - trim) / 2) + (wall / 2)]) {
            cube([wgbtab[wrcode] + (wall / 2), wgatab[wrcode] + (wall / 2), wall], center=true);
        }

        waveguide(length - ((flanged - trim) / 2) + wall);
    }

    translate ([(wgbtab[wrcode] + wall)/2, probe_offset, length - probe_dist - ((flanged - trim) / 2)]) {
        rotate([0, 90, 0]) {
            cylinder(h = wall*1.1, r=probe_hole_r, center=true);

            if(coax_mount_n) {
                for(i = [0:coax_mount_n]) {
                    rotate([0, 0, coax_mount_angle + i * (360 / coax_mount_n)]) {
                        translate([coax_mount_dist, 0, 0]) {
                            cylinder(h=wall*10, r=coax_mount_r, center=true);
                        }
                    }
                }
            }
        }
    }

    if(split_part) {
        translate([-trim, -wgsize_a*2, -flanged])
            cube([trim * 2, wgsize_a*4, length*1.5]);
    }
}


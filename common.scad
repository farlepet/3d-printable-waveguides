/**********************************************************************
 * Common waveguide code                                              *
 * NOTE: Must be included AFTER setting waveguide parameters          *
 * Perhaps in the future it could be useful to allow passing in these *
 * parameters to the modules themselves, removing this requirement.   *
 **********************************************************************/

/* wrcode: Waveguide size selection
 *  0: N/A
 *  1: WR-430  1.72- 2.60 GHz
 *  2: WR-340  2.20- 3.30 GHz
 *  3: WR-284  2.60- 3.95 GHz
 *  4: WR-229  3.30- 4.90 GHz
 *  5: WR-187  3.95- 5.85 GHz
 *  6: WR-159  4.90- 7.05 GHz
 *  7: WR-137  5.85- 8.20 GHz
 *  8: WR-112  7.05-10.00 GHz
 *  9: WR-90   8.20-12.40 GHz
 * 10: WR-75  10.00-15.00 GHz
 * 11: WR-62  12.49-18.00 GHz
 * 12: WR-51  15.00-22.00 GHz
 * 13: WR-42  18.00-26.50 GHz
 * 14: WR-34  22.00-33.00 GHz
 * 15: WR-28  26.50-40.00 GHz */

/*                     WR430   WR340  WR284   WR229  WR187  WR159  WR137  WR112   WR90   WR75   WR62   WR51   WR42   WR34  WR28 */
wrtab            = [0, 430,    340,   284,    229,   187,   159,   137,   112,    90,    75,    62,    51,    42,    34,   28   ]; /* Waveguide type */
/* Flange type:
 *  0: N/A
 *  1: Square flange
 *  2: Rectangular flange
 *  3: Circular flange
 * Note: For WR137 and larger, flange type and sizes are based off of default options from ATM Microwave
 * TODO: Allow selecting flange type manually */
fttab            = [0,   2,      2,     3,      2,     3,     2,     2,     1,     1,     1,     1,     1,     1,     1,    1   ];     /* Flange type */
/* Square flange */
fstab            = [0,   0,      0,     0,      0,     0,     0,     0,    47.9,  41.4,  38.3,  33.3,  31.0,  22.41, 22.1, 19.05]*1.0; /* Flange size */
fhstab           = [0,   0,      0,     0,      0,     0,     0,     0,    18.72, 16.26, 14.25, 12.14, 11.25,  8.51,  7.9,  6.73]*1.0; /* Hole spacing short side */
fhltab           = [0,   0,      0,     0,      0,     0,     0,     0,    17.17, 15.49, 13.21, 12.63, 10.29,  8.13,  7.5,  6.34]*1.0; /* Hole spacing long side */
/* Rectangular flange */
rflange_a_sz     = [0, 161.04, 138.18,  0,     98.30,  0,    81.03, 68.33,  0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* Flange size in A direction */
rflange_b_sz     = [0, 106.43,  95.25,  0,     69.85,  0,    61.98, 49.28,  0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* Flange size in B direction */
rflange_a_a_off  = [0,  45.36,  34.14,  0,     27.18,  0,    12.70, 11.13,  0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* A side screw offset from center in A direction */
rflange_a_b_off  = [0,  43.69,  38.10,  0,     26.67,  0,    22.23, 18.26,  0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* A side screw offset from center in B direction */
rflange_b_a_off  = [0,  71.00,  59.54,  0,     41.15,  0,    32.33, 27.79,  0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* B side screw offset from center in A direction */
rflange_b_b_off  = [0,  23.83,  17.04,  0,     12.70,  0,    10.10,  7.95,  0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* B side screw offset from center in B direction */
rflange_hole_cnt = [0,  10,     10,     0,     10,     0,     6,     6,     0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* Number of holes in flange */
/* Circular flange */
cflange_r        = [0,   0,      0,    67.44,   0,    45.97,  0,     0,     0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* Circular flange radius */
cflange_hole_r   = [0,   0,      0,    60.33,   0,    41.28,  0,     0,     0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* Circular flange screw placement radius */
cflange_hole_off = [0,   0,      0,    22.5,    0,     0,     0,     0,     0,     0,     0,     0,     0,     0,     0,    0   ]*1.0; /* Circular flange screw placement angle offset */


drilltab         = [0,   6.76,   6.76,  6.53,   6.50,  5.1,   6.5,   5.0,   4.3,   4.3,   4.1,   4.1,   4.1,   3.1,   3.1,  3.0 ]*1.0; /* Hole size */
/* Not all waveguide opening sizes correspong 100% to the waveguide number */
wgatab           = [0, 109.22,  86.36, 72.136, 58.17, 47.55, 40.39, 34.85, 28.50, 22.86, 19.05, 15.80, 12.95, 10.67,  8.64, 7.11]*1.0; /* Waveguide opening size A */
wgbtab           = [0,  54.61,  43.18, 34.036, 29.08, 22.15, 20.19, 15.80, 12.62, 10.16,  9.53,  7.90,  6.48,  4.32,  4.32, 3.56]*1.0; /* Waveguide opening size B */


flange_size   = fstab[wrcode];        /* Square size of flange */
flange_hole_s = fhstab[wrcode];       /* Hole spacing on short B side */
flange_hole_l = fhltab[wrcode];       /* Hole spacing on long A side */
flange_drill  = drilltab[wrcode]/2.0; /* Flange mounting hole size */

wgsize_a = wgatab[wrcode] + (trim * 2);
wgsize_b = wgbtab[wrcode] + (trim * 2);

/* Faces for precision */
$fn=36;

/* Create a waveguide flange
 *   Heavily based on code from Rolf-Dieter Klein (www.rdklein.de)
 *   https://www.thingiverse.com/thing:161428
 */
module flange() {
    thickness = flanged - trim;

    flange_type = fttab[wrcode];

    if(flange_type == 1) {
        /* Square flange */

        difference() {
            difference() {
                intersection() {
                    cube([flange_size, flange_size, thickness], center=true);
                    rotate([0,0,45])
                        cube([flange_size*1.4142*0.9,flange_size*1.4142*0.9,thickness],center=true);
                }
                cube([wgsize_b,wgsize_a,flanged*2],center=true);
            }
            /* Holes */
            translate([-flange_hole_s,  flange_hole_l, 0]) cylinder(h=thickness*1.1, r=flange_drill, center=true);
            translate([ flange_hole_s,  flange_hole_l, 0]) cylinder(h=thickness*1.1, r=flange_drill, center=true);
            translate([-flange_hole_s, -flange_hole_l, 0]) cylinder(h=thickness*1.1, r=flange_drill, center=true);
            translate([ flange_hole_s, -flange_hole_l, 0]) cylinder(h=thickness*1.1, r=flange_drill, center=true);
        }
    } else if(flange_type == 2) {
        /* Rectangular flange */

        flange_radius = 6.35;

        difference() {
            difference() {
                translate([0, 0, -(thickness/2)]) {
                    linear_extrude(height = thickness) {
                        offset(r = flange_radius, $fn=60) {
                            square([rflange_b_sz[wrcode] - (flange_radius * 2), rflange_a_sz[wrcode] - (flange_radius * 2)], center=true);
                        }
                    }
                }
                cube([wgsize_b,wgsize_a,flanged*2],center=true);
            }

            for(m = [0:1]) {
                mirror([m,0,0]) {
                    for(n = [0:1]) {
                        mirror([0,n,0]) {
                            /* B side */
                            translate([rflange_b_b_off[wrcode], rflange_b_a_off[wrcode], 0]) {
                                cylinder(h=flanged*1.1, r=flange_drill, center=true);
                            }
                            /* A side */
                            translate([rflange_a_b_off[wrcode], rflange_a_a_off[wrcode], 0]) {
                                cylinder(h=flanged*1.1, r=flange_drill, center=true);
                            }
                            if(rflange_hole_cnt[wrcode] >= 10) {
                                translate([rflange_a_b_off[wrcode], 0, 0]) {
                                    cylinder(h=flanged*1.1, r=flange_drill, center=true);
                                }
                            }
                        }
                    }
                }
            }
        }
    } else if(flange_type == 3) {
        /* Circular flange */

        difference() {
            cylinder(h=thickness, r=cflange_r[wrcode], center=true, $fn=120);
            cube([wgsize_b,wgsize_a,flanged*2],center=true);

            for(i = [0:7]) {
                rotate(cflange_hole_off[wrcode] + i * 45, [0, 0, 1]) {
                    translate([cflange_hole_r[wrcode], 0, 0]) {
                        cylinder(h=flanged*1.1, r=flange_drill, center=true);
                    }
                }
            }
        }
    }
}

/* Create a flangeless section of waveguide
 *   wg_len: Length of section, in mm
 */
module waveguide(wg_len) {
    translate([0,0,wg_len/2]) {
        difference() {
            cube([wgsize_b+wall*2, wgsize_a+wall*2, wg_len],          center=true);
            cube([wgsize_b,        wgsize_a,        wg_len + wall*.1],center=true);
        }
    }
}

module _curve(x_sz, y_sz, _rad, _angle, _rot=0) {
    translate([-_rad, , 0]) {
        rotate([90, _rot, 0]) {
            rotate_extrude(angle = _angle) {
                translate([_rad, 0, 0]) {
                    square([x_sz, y_sz], center = true);
                }
            }
        }
    }

}

/* Create a waveguide bend
 *   rg_rad: Radius of bend, at center of the waveguide cross-section
 *   wg_angle: Angle of bend
 */
module waveguide_bend(wg_rad, wg_angle) {
    difference() {
        _curve(wgsize_b+wall*2, wgsize_a+wall*2, wg_rad, wg_angle, $fn=300);
        _curve(wgsize_b,        wgsize_a,        wg_rad, wg_angle+0.02, 0.01, $fn=300);
    }
}

/* Generate horn antenna
 *   length:  Length of horn
 *   theta_h: Angle of horn in magnetic field
 *   theta_e: Angle of horn in electric field
 *
 * Polyhedron code loosely based off of code from Rolf-Dieter Klein (www.rdklein.de)
 *   https://www.thingiverse.com/thing:161428
 */
module horn(length, theta_h, theta_e) {
    /* Depth of horn that ends up inside waveguide */
    d_a = wgsize_a / (2 * tan(theta_h));
    d_b = wgsize_b / (2 * tan(theta_e));

    /* Size of horn opening */
    sz_a = wgsize_a + (2 * length * tan(theta_h));
    sz_b = wgsize_b + (2 * length * tan(theta_e));

    difference() {
        polyhedron(
            points = [
                /* Wide end */
                [ sz_b/2 + wall,  sz_a/2 + wall, length],
                [ sz_b/2 + wall, -sz_a/2 - wall, length],
                [-sz_b/2 - wall, -sz_a/2 - wall, length],
                [-sz_b/2 - wall,  sz_a/2 + wall, length],
                /* Small end */
                [ wgsize_b/2 + wall,  wgsize_a/2 + wall, 0],
                [ wgsize_b/2 + wall, -wgsize_a/2 - wall, 0],
                [-wgsize_b/2 - wall, -wgsize_a/2 - wall, 0],
                [-wgsize_b/2 - wall,  wgsize_a/2 + wall, 0]
            ],
            faces = [
                [0,1,4],[1,2,5],[2,3,6],[3,0,7],
                [1,5,4],[2,6,5],[3,7,6],[0,4,7],
                [1,0,3],[2,1,3],[4,5,7],[5,6,7]
            ]
        );
        polyhedron(
            points = [
                /* Wide end */
                [ sz_b/2,  sz_a/2, length],
                [ sz_b/2, -sz_a/2, length],
                [-sz_b/2, -sz_a/2, length],
                [-sz_b/2,  sz_a/2, length],
                /* Small end */
                [ wgsize_b/2,  wgsize_a/2, 0],
                [ wgsize_b/2, -wgsize_a/2, 0],
                [-wgsize_b/2, -wgsize_a/2, 0],
                [-wgsize_b/2,  wgsize_a/2, 0]
            ],
            faces = [
                [0,1,4],[1,2,5],[2,3,6],[3,0,7],
                [1,5,4],[2,6,5],[3,7,6],[0,4,7],
                [1,0,3],[2,1,3],[4,5,7],[5,6,7]
            ]
        );
    }
}

/* Generate an ideal horn antenna for a given wavelength
 *   l_h: Length of horn in magnetic field direction
 *   l_e: Length of horn in electric field direction
 *   wavelength: Design wavelength
 *
 * Both l_h and l_e include the portion of the antenna that would end up inside
 * the waveguide if both sides of the horn were extended until they meet.
 */
module ideal_horn(l_h, l_e, wavelength) {
    theta_e = asin(sqrt(2 * wavelength * l_e) / (2 * l_e));
    theta_h = asin(sqrt(3 * wavelength * l_h) / (2 * l_h));

    /* Not sure if min is good, but whatever. Maybe I should rewrite this to just produce the horn directly */
    length_e = (l_e * cos(theta_e)) - (wgsize_b / (2 * tan(theta_e)));
    length_h = (l_h * cos(theta_h)) - (wgsize_a / (2 * tan(theta_h)));
    echo("Len_E: ", length_e, "Len_H", length_h);
    length = min(length_e, length_h);

    horn(length, theta_h, theta_e);
}


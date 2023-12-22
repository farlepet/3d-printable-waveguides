/**********************************************************************
 * Common waveguide code                                              *
 * NOTE: Must be included AFTER setting waveguide parameters          *
 * Perhaps in the future it could be useful to allow passing in these *
 * parameters to the modules themselves, removing this requirement.   *
 **********************************************************************/


/*             WR112   WR90   WR75   WR62   WR51   WR42   WR34  WR28 */
wrtab    = [0, 112,    90,    75,    62,    51,    42,    34,   28   ]*1.0; /* Waveguide type */
fstab    = [0,  47.9,  41.4,  38.3,  33.3,  31.0,  22.41, 22.1, 19.05]*1.0; /* Flange size */
fhstab   = [0,  18.72, 16.26, 14.25, 12.14, 11.25,  8.51,  7.9,  6.73]*1.0; /* Hole spacing short side */
fhltab   = [0,  17.17, 15.49, 13.21, 12.63, 10.29,  8.13,  7.5,  6.34]*1.0; /* Hole spacing long side */
drilltab = [0,   4.3,   4.3,   4.1,   4.1,   4.1,   3.1,   3.1,  3.0 ]*1.0; /* Hole size */
/* Not all waveguide opening sizes correspong 100% to the waveguide number */
wgatab   = [0,  28.50, 22.86, 19.05, 15.80, 12.95, 10.67,  8.64, 7.11]*1.0; /* Waveguide opening size A */
wgbtab   = [0,  12.62, 10.16,  9.53,  7.90,  6.48,  4.32,  4.32, 3.56]*1.0; /* Waveguide opening size B */


flange_size   = fstab[wrcode];        /* Square size of flange */
flange_hole_s = fhstab[wrcode];       /* Hole spacing on short side */
flange_hole_l = fhltab[wrcode];       /* Hole spacing on long side */
flange_drill  = drilltab[wrcode]/2.0; /* Flange mounting hole size */

wgsize_a = wgatab[wrcode] + (trim * 2);
wgsize_b = wgbtab[wrcode] + (trim * 2);

// faces for precision
$fn=36; // faces for precision

/* Create a waveguide flange
 *   Heavily based on code from Rolf-Dieter Klein (www.rdklein.de)
 *   https://www.thingiverse.com/thing:161428
 */
module flange() {
    thickness = flanged - trim;

    difference() {
        difference() {
            intersection() {
                cube([flange_size, flange_size, thickness], center=true);
                rotate([0,0,45])
                    cube([flange_size*1.4142*0.9,flange_size*1.4142*0.9,thickness],center=true);
            }
            cube([wgsize_b,wgsize_a,wall*2],center=true);
        }
        /* Holes */
        translate([-flange_hole_s,  flange_hole_l, 0]) cylinder(h=thickness*1.1, r=flange_drill, center=true);
        translate([ flange_hole_s,  flange_hole_l, 0]) cylinder(h=thickness*1.1, r=flange_drill, center=true);
        translate([-flange_hole_s, -flange_hole_l, 0]) cylinder(h=thickness*1.1, r=flange_drill, center=true);
        translate([ flange_hole_s, -flange_hole_l, 0]) cylinder(h=thickness*1.1, r=flange_drill, center=true);
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


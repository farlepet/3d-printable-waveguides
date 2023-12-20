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
length = 20;

/* Amount to trim back internal and mating surfaces, for the purpose of accounting for metallic tape or coating. */
trim = 0.05;



/****************************
 * Constants & Calculations *
 ****************************/

/*           WR112   WR90   WR75   WR62   WR51   WR42   WR34  WR28 */
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

flange();
translate([0, 0, (length - flanged) - (2 * trim)]) flange();

waveguide((length - flanged));
 

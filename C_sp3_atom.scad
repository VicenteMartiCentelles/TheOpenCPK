module pin(
pin_d = 5,
pin_h = 6,
pin_int_l = 5,
pin_int_d = 2,
extraL = 1,
object = 0,
pin_res = 20,
expand = 0,
rotate = 0
){
pin_d = pin_d + expand;
rotate([0,rotate,0])
difference(){
    union(){
    //cylinder
    cylinder( h = pin_h-1, d = pin_d, $fn=pin_res);
    //top
    translate([0,0,pin_h-1]) cylinder( h = 1+expand, d1 = pin_d*1.1, d2 = pin_d*0.70, $fn=pin_res);
    translate([0,0,pin_h-1.5]) cylinder( h = 0.5, d1 = pin_d*1.1, d2 = pin_d*1.1, $fn=pin_res);
    translate([0,0,pin_h-1.75-expand]) cylinder( h = 0.25+expand, d1 = pin_d, d2 = pin_d*1.1, $fn=pin_res);

    if(object == 0){
    translate([0,0,-0.05]) cylinder( h = 1.55, d1 = pin_d*1.2, d2 = pin_d, $fn=pin_res);
    translate([0,0,-1.55]) cylinder( h = 1.55, d1 = pin_d*1.2, d2 = pin_d*1.2, $fn=pin_res);
    if(extraL == 1){
    translate([0,0,pin_h]) cylinder( h = 4.5, d1 = pin_d*0.7, d2 = pin_d*0.7, $fn=pin_res);
    }
    }
    if(object == 1){
    translate([0,0,0]) cylinder( h = 1.5, d1 = pin_d*1.2, d2 = pin_d, $fn=pin_res);
    }
    }
if(object == 1 || object == 2){
//outside cut
translate([-pin_d, pin_d*0.4, -1]) cube([pin_d*2,pin_d,pin_h*1.2], $fn=pin_res);
translate([-pin_d, -pin_d*0.4-pin_d, -1]) cube([pin_d*2,pin_d,pin_h*1.2], $fn=pin_res);
}
if(object == 1){
//inside cut
//cylinder
translate([0, 0, pin_h/2 + (pin_h - pin_int_l)]) cylinder( d1 = pin_int_d*1.5, d2 = pin_int_d*1.8, h =pin_h, center = true, $fn=pin_res); 
//sphere
translate([0, 0, pin_int_d*1.5/2+0.6]) sphere (d =pin_int_d*1.55, $fn=pin_res);  
//cube
translate([0, 0, pin_h/2 + (pin_h - pin_int_l)]) cube([pin_int_d,pin_d,pin_h], center = true, $fn=pin_res);
//cylinder bottom
translate([0, 0, (pin_h - pin_int_l)])rotate([90,0,0])cylinder ( h = pin_d, d =pin_int_d,center = true, $fn=pin_res);  

//cube 2
rotate([0,0,90]) translate([0, 0, pin_h*0.9]) cube([pin_int_d*0.2,pin_d*1.5,pin_h], center = true, $fn=pin_res);

}
}
}



/*
Scale 0.5*12.5 mm/Å
van der Waals radii (J.Phys.Chem. 1964, 68, 441-451)
H 1.20 Å
covalent radii (Dalton Trans. 2008, 2832–2838)
H 0.31 Å
*/

pin_d = 9.5;
pin_h = 5.5;
expand = 0.6;

/*
atomName = "H";
vdW_R = 1.20*12.5;
cov_R = 0.31*12.5;
geometry = 1; //s:1, sp3:2
*/

atomName = "C";
vdW_R = 1.70*12.5;
cov_R = 0.76*12.5;
geometry = 2; //s:1, sp3:2

/*
atomName = "O";
vdW_R = 1.52*12.5;
cov_R = 0.66*12.5;
geometry = 2; //s:1, sp3:2
*/

function normalize (v) = v / norm(v);
scale(v = [0.5,0.5,0.5])
//{

difference(){
sphere(r = vdW_R, $fn=100);
  
translate(normalize([1,1,1])*cov_R) 
rotate([-54.7356103,0,-45]) {
  translate([0,0,0]) cylinder(h = vdW_R, r = vdW_R, $fn=50, center = false);
}

if (geometry == 2){

translate(normalize([-1,-1,1])*cov_R) 
rotate([54.7356103,0,-45]) {
  translate([0,0,0]) cylinder(h = vdW_R, r = vdW_R, $fn=50, center = false);
}

translate(normalize([-1,1,-1])*(cov_R+vdW_R)) 
rotate([54.7356103,0,45]) {
  translate([0,0,0]) cylinder(h = vdW_R, r = vdW_R, $fn=50, center = false);
}

translate(normalize([1,-1,-1])*(cov_R+vdW_R)) 
rotate([-54.7356103,0,45]) {
  translate([0,0,0]) cylinder(h = vdW_R, r = vdW_R, $fn=50, center = false);
}

}


translate(normalize([1,1,1])*cov_R) 
rotate([-54.7356103,0,-45]) {
  translate([0,0,0]) pin(pin_d = pin_d, pin_h = pin_h, expand = expand, rotate = 180, object = 0);
}

if (geometry == 2){
translate(normalize([-1,-1,1])*cov_R) 
rotate([54.7356103,0,-45]) {
  translate([0,0,0]) pin(pin_d = pin_d, pin_h = pin_h, expand = expand, rotate = 180, object = 0);
}

translate(normalize([-1,1,-1])*cov_R) 
rotate([54.7356103,0,45]) {
  translate([0,0,0]) pin(pin_d = pin_d, pin_h = pin_h, expand = expand, rotate = 0, object = 0);
}

translate(normalize([1,-1,-1])*cov_R) 
rotate([-54.7356103,0,45]) {
  translate([0,0,0]) pin(pin_d = pin_d, pin_h = pin_h, expand = expand, rotate = 0, object = 0);
}
}


translate(normalize([1,1,1])*(cov_R-2))
rotate([-54.7356103,0,-45]) {
  translate([0,12,0]) linear_extrude(4) text( atomName, size= 5, halign = "center", valign = "center", font="arial");
}



}



/*
translate(normalize([1,1,1])*6)
color([0, 0, 1])
sphere(d = 1.0, $fn=50);

translate(normalize([1,1,1])*10)
color([1, 0, 0])
sphere(d = 1.0, $fn=50);


translate(normalize([-1,-1,1])*10)
color([1, 0, 0])
sphere(d = 1.0, $fn=50);

translate(normalize([-1,1,-1])*10)
color([1, 0, 0])
sphere(d = 1.0, $fn=50);

translate(normalize([1,-1,-1])*10)
color([1, 0, 0])
sphere(d = 1.0, $fn=50);
*/

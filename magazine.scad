
module oldstl () 
{
  // rotate ([90,0,0]) import("files/SMD_Magazine_v1_-_15-1.5.stl", convexity=7);
  
  translate ([1,-65/2,0]) import("files/Compliant_SMD_Magazine_15_1.5.stl", convexity=7);
}

$fn = 50;

bt = 2;
size = 65;
wt=2;
tt=1.5;

module rc (x,y,z,rr)
{
  xx = x/2-rr;
  yy = y/2-rr;
  hull () {
    translate ([-xx,-yy,0]) cylinder (r=rr,h=z);
    translate ([ xx,-yy,0]) cylinder (r=rr,h=z);
    translate ([-xx, yy,0]) cylinder (r=rr,h=z);
    translate ([ xx, yy,0]) cylinder (r=rr,h=z);
  }
}

module rt (x1, x2, y, z, rr)
{
  xx1 = x1/2-rr;
  xx2 = x2/2-rr;
  yy = y/2-rr;
  hull () {
    translate ([-xx1,-yy,0]) cylinder (r=rr,h=z);
    translate ([ xx1,-yy,0]) cylinder (r=rr,h=z);
    translate ([-xx2, yy,0]) cylinder (r=rr,h=z);
    translate ([ xx2, yy,0]) cylinder (r=rr,h=z);
  }
}


module rt2 (x1, x2, y, z, rr)
{
  xx1 = x1/2-rr;
  xx2 = x2/2-rr;
  yy = y/2-rr;
  hull () {
    translate ([-xx1,-yy,0]) cylinder (r=rr,h=z);
    translate ([ xx1,-yy,0]) cylinder (r=rr,h=z);
    translate ([-xx1, yy,0]) cylinder (r=rr,h=z);
    translate ([ xx2, yy,0]) cylinder (r=rr,h=z);
  }
}



module magazine (h=15)
{
  // rr=5;
  difference () {
    union () {
      // translate ([0,0,h/2-bt/2])       cube ([size, size, h],center=true);
      translate ([0,0,-bt/2]) rc (size, size, h, 5);
      translate ([size/2-3-1,size/2-4+1,-bt/2]) rotate (-23) translate ([-8+2,0,0])  rc (16, 6,h, 3);
    }
    translate ([1,0,0])cylinder (d=size-2*wt-1, h=h);
    translate ([size/2-15,size/2+3/2,-bt/2-.1])  translate ([-10+2,0,0])  rc (20, 3,h+1, 1.5);
    translate ([size/2-13.5,size/2+1.5, bt/2]) rotate (40) translate ([-3.5,0,0])  rc (7, 2,h+1, 1);
    translate ([.1,size/2-wt-tt,0])  cube ([size/2,tt,h]);
    
    translate ([size/2-1,-size/2+7.5,-bt]) rotate (90) rt (8,5.5,8,h+2,.2);
    translate ([-size/2,-size/2,h/2-.6]) cube ([14,22, h+1],center=true);
    translate ([-size/2,-size/2,h/2-.7]) rotate (30) cube ([19,14, h+1],center=true);

    translate ([-size/2-2,0,h/2-bt+.1]) rotate (4.5) cube ([8,size,h+2],center=true);

    translate ([-size/2-2,0,h/2-bt+.1]) rotate (-4.5) cube ([3,size+4,h+2],center=true);

    translate ([-size/2-10+4,17.5,-bt]) cylinder (r=12,h=h+2);

  }
  translate ([-size/2-.5,1.3,h/2-bt/2]) rotate (4.) 
  union () {
    cube ([4,size-2,h],center=true);
    translate ([-.75,-size/2+1.9,-h/2]) rt2 (2.5,12,5.2,h,.2);
  }
  translate ([-size/2+1.6,size/2-15,h/2-bt/2]) rotate (20) cube ([1.6,16,h],center=true);

}


translate ([70,0,0]) oldstl ();

color ("blue") translate ([0,0, 0.1]) oldstl ();
magazine ();
translate ([-70,0,0]) magazine ();


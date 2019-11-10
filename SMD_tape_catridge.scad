
module oldstl () 
{
  // rotate ([90,0,0]) import("files/SMD_Magazine_v1_-_15-1.5.stl", convexity=7);
  
  translate ([1,-65/2,0]) import("files/Compliant_SMD_Magazine_15_1.5.stl", convexity=7);
}

$fn = 100;

bt = 1;
size = 65;
wt=2;
tt=1.5;

tw = 9;  // tape width.

h = bt + tw + bt; // Use bt also as top thickness. 


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



module magazine (h)
{
  // rr=5;

  difference () {
    union () {
      // main body.
      translate ([0,0,-bt]) rc (size, size, h, 5);
      // cover-output
      translate ([size/2-3-1,size/2-4+1,-bt]) rotate (-24) translate ([-8+2,0,0])  rc (16, 6,h, 3);
    }
    // main space for the parts. 
    translate ([1,0,0])cylinder (d=size-2*wt-1, h=h);

    //cover exit path.
    translate ([size/2-15,size/2+3/2,-bt-.1])  translate ([-10+2,0,0])  rc (20, 3,h+1, 1.5);
    translate ([size/2-13.5,size/2+1.5,-bt-.1 ]) rotate (40) translate ([-3.5,0,0])  rc (7, 2,h+1, 1);

    // the "exit tube"
    translate ([.1,size/2-wt-tt-.5,0])  cube ([size/2,tt,tw]);
    
    // space for the rails to be in. 
    translate ([size/2-1,-size/2+7.5,-bt-.1]) rotate (90) rt (8,5.5,8,h+2,.2);
    translate ([-size/2,-size/2,h/2-.6]) cube ([14,22, h+1],center=true);

    // chamfer to ease putting in rails. 
    translate ([-size/2,-size/2,h/2-.7]) rotate (30) cube ([19,14, h+1],center=true);

    // space for the clip to move when activated. 
    translate ([-size/2-2,0,h/2-bt+.1]) rotate (4.5) cube ([8,size,h+2],center=true);
    translate ([-size/2-2,0,h/2-bt+.1]) rotate (-4.5) cube ([3,size+4,h+2],center=true);
    translate ([-size/2-10+4,17.5,-bt-.1]) cylinder (r=12,h=h+2);

  }

  // The clip. We print it in the "closed" position, rotated 4 degrees. 
  translate ([-size/2-.5,1.3,h/2-bt]) rotate (4.) 
    difference () {
    union () {
      cube ([4,size-2,h],center=true);
      translate ([-.75,-size/2+1.9,-h/2]) rt2 (2.5,10.8,5.2,h,.2);
    }
    translate ([-12,size/2-9,-h/2-.1])cylinder (r=12, h=h+1);
  }
  translate ([-size/2+1.6,size/2-15,h/2-bt]) rotate (20) cube ([1.6,16,h],center=true);


  // This ring prevents the slicer from putting a brim here in the
  // part where it is difficult to remove.
  difference () { 
    rw = 1;
    rd = 12;
    translate ([-size/2+6,-size/2,-bt])  cylinder (d=rd,h=0.2);
    translate ([-size/2+6,-size/2,-bt-.1])  cylinder (d=rd-2*rw,h=bt+1);
    translate ([-size/2+6-rd/2,-size/2+2,-bt-.1  ])  cube ([rd,rd,bt+1]);
  }

  // Another such ring. 
  difference () {
    rw = 1;
    rd = 12;

    translate ([-size/2+1, size/2-3,-bt])  cylinder (d=rd,h=0.2);
    translate ([-size/2+1, size/2-3,-bt-.1])  cylinder (d=rd-2*rw,h=bt+1);
    translate ([-size/2+1-rd/2, size/2-rd-1,-bt-.1  ])  cube ([rd,rd,bt+1]);
  }

  // Another such ring. 
  difference () {
    rw = 1;
    rd = 12;

    translate ([ size/2-17, size/2-1,-bt])  cylinder (d=rd,h=0.2);
    translate ([ size/2-17, size/2-1,-bt-.1])  cylinder (d=rd-2*rw,h=bt+1);
    //translate ([-size/2+1-rd/2, size/2-rd-1,-bt-.1  ])  cube ([rd,rd,bt+1]);
  }


}

function bit_set(b, n) = floor(n / pow(2, b)) % 2;

view=4;


if (bit_set(0, view)) translate ([70,0,0]) oldstl ();
if (bit_set(1, view)) color ("blue") translate ([0,0, 0.1]) oldstl ();
if (bit_set(1, view)) magazine (h);
if (bit_set(2, view)) translate ([-70,0,0]) magazine (h);


import peasy.*;

int DIM = 200;
PeasyCam cam;
ArrayList<PVector>mandelbulb = new ArrayList<PVector>();

void setup() {
  size (600, 600, P3D);
  windowMove(1200, 100);
  cam = new PeasyCam(this, 500);
  for (int i  = 0; i < DIM; i++) {
    for (int j = 0; j < DIM; j++) {
      boolean edge = false;
        for (int k = 0; k < DIM; k++){
        float x = map(i, 0, DIM, -1, 1);
        float y = map(j, 0, DIM, -1, 1);
        float z = map(k, 0, DIM, -1, 1);
                       
        PVector zaza = new PVector(0,0,0);
        int n = 8;
        int iteration_cap = 10;
        int iterate = 0;
        while (true) {
          Spherical sphericalZaza = spherical(zaza.x,zaza.y,zaza.z);
          float newx = pow(sphericalZaza.r,n) * sin(sphericalZaza.theta*n) * cos(sphericalZaza.phi*n);
          float newy = pow(sphericalZaza.r,n) * sin(sphericalZaza.theta*n) * cos(sphericalZaza.phi*n);
          float newz = pow(sphericalZaza.r,n) * cos(sphericalZaza.theta*n);
          zaza.x = newx + x;
          zaza.y = newy + y;
          zaza.z = newz + z;
          iterate++;
          
          if (sphericalZaza.r > 16) {
            if (edge) {
              edge = false;
            }
            break;
          }
          if (iterate > iteration_cap) {
            if (!edge) {
              edge = true;
              mandelbulb.add(new PVector(x*100,y*100,z*100));
             }
            break;
          }
        }
      }
    }
  }
}
class Spherical 
{
  float r, theta, phi;
  Spherical(float r, float theta, float phi) 
  {
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
  
}

Spherical spherical(float x, float y, float z) 
{
   float r = sqrt(x*x + y*y + z*z);
   float theta = atan2( sqrt(x*x+y*y), z);
   float phi = atan2(y,x);
   return new Spherical(r, theta, phi);
}


void draw(){
  background(0);

  for (PVector v : mandelbulb) { 
    stroke(255);
    point(v.x,v.y,v.z);
  }
}

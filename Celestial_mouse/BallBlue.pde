class BallBlue {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G = 0.05; 

  BallBlue(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  PVector attractB(BallRed red) {
    PVector force = PVector.sub(position, red.position);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 10.0, width);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = -(G * mass * red.mass) / (d * d);     // Calculate gravitional force magnitude
    force.mult(strength);     // Get force vector --> magnitude * direction
    return force;
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    velocity.limit(20);
  }

  void display() {
    noStroke();
    fill(170, 255, 255);
    ellipse(position.x, position.y, mass*5, mass*5);
  }




  void checkedges() {
    if ( position.x > width+100 ) {
      position.x = width+100;
      velocity.x *= -1;
    } else   if ( position.x < -100) {
      position.x = -100;
      velocity.x *= -1;
    }
    if ( position.y > height+100) {
      position.y = height+100;
      velocity.y *= -1;
    } else   if ( position.y < -100) {
      position.y = -100;
      velocity.y *= -1;
    }
  }
  boolean collide(BallRed other) {
    float d = dist(position.x, position.y, other.position.x, other.position.y);
    if ( d < mass*5/2 + other.mass*5/2 ) { 
      return true;
    } else {
      return false;
    }
  }

  boolean collideitself(BallBlue other) {
    float d = dist(position.x, position.y, other.position.x, other.position.y);
    if ( d < mass*5/2 + other.mass*5/2 ) { 
      return true;
    } else {
      return false;
    }
  }

  //  void collide(BallRed other){
  //float d = dist(position.x,position.y,other.position.x, other.position.y);
  //if ( d < mass*5*2){ 
  //    velocity.x *= -1;
  //    velocity.y *= -1;

  //}
  //}
}

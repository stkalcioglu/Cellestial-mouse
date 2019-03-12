class BallRed {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G = 0.05; 

  BallRed(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  
    PVector attractR(BallBlue blue) {
    PVector force = PVector.sub(position, blue.position);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 10.0, width);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = -(G * mass * blue.mass) / (d * d);     // Calculate gravitional force magnitude
    force.mult(strength);     // Get force vector --> magnitude * direction
    return force;
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    velocity.limit(2);
  }

  void display() {
    noStroke();
    fill(255, 100, 0);
    ellipse(position.x, position.y, mass*5, mass*5);
  }

  PVector attract(BallBlue blue) {
    PVector force = PVector.sub(position, blue.position);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 5.0, 25.0);                             // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction

    float strength = (g * mass * blue.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
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
  boolean collide(BallBlue other) {
    float d = dist(position.x, position.y, other.position.x, other.position.y);
    if ( d < mass*5/2 + other.mass*5/2 ) { 
      return true;
    } else {
      return false;
    }
  }
  
    boolean collideitself(BallRed other) {
    float d = dist(position.x, position.y, other.position.x, other.position.y);
    if ( d < mass*5/2 + other.mass*5/2) { 
      return true;
    } else {
      return false;
    }
  }


  //void collide(BallBlue other) {
  //  float d = dist(position.x, position.y, other.position.x, other.position.y);
  //  if ( d < mass*5*2) {
  //    velocity.x *= -1;
  //    velocity.y *= -1;
  //  }
  //}
}

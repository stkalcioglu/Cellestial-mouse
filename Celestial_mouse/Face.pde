// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A class for a draggable attractive body in our world

class Face {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on
  float a;
  float b; 


  Face(float x, float y) {
    position = new PVector(x, y);
    mass = random(18, 20);
    G = 0.01;
    dragOffset = new PVector(0.0, 0.0);
    float a = random(0.3, 3);
    float b = random(0.3, 3);
  }

  PVector attract(BallBlue blue) {
    PVector force = PVector.sub(position, blue.position);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 5.0, width);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = -(G * mass * blue.mass) / (d * d );     // Calculate gravitional force magnitude
    force.mult(strength);     // Get force vector --> magnitude * direction
    return force;
  }

  PVector attract2(BallRed red) {
    PVector force = PVector.sub(position, red.position);   // Calculate direction of force
    float d = force.mag();                              // Distance between objects
    d = constrain(d, 40.0, 500.0);                          // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * red.mass) / (d * d );     // Calculate gravitional force magnitude
    force.mult(strength);     // Get force vector --> magnitude * direction
    return force;
  }


  // Method to display
  void display(float orbitt) {
    ellipseMode(CENTER);
    strokeWeight(4);
    
    if (dragging) fill (255);
    else if (rollover) fill(255);
    else fill(255);
    stroke(255, 100, 0);
    strokeWeight(1);
    noFill();
    ellipse(position.x, position.y, mass*4+30, mass*orbitt);
    stroke(170, 255, 255);
    ellipse(position.x, position.y, mass*orbitt, mass*4+30 );
    noStroke();
    fill(255);
    ellipse(position.x, position.y, mass*4, mass*4);
  }
}

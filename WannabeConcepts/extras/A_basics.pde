// Document 1: Basic Environment and Structure

void setup() {
  size(800, 600);  // Window size
  background(200); // Set background color
}

void draw() {
  fill(255, 0, 0); // Set fill color to red
  noStroke();      // No outline for the circle
  ellipse(width / 2, height / 2, 100, 100); // Circle in the center of the window
}

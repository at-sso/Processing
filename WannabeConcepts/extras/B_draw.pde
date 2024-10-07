// Document 2: Drawing Functions and Color Manipulation

void setup() {
  size(800, 600);            // Window size
  background(100, 150, 200); // Set background color
}

void draw() {
  fill(0, 255, 0);   // Set fill color to green
  stroke(255, 0, 0); // Set outline color to red
  strokeWeight(5);   // Set the thickness of the outline
  rect(width / 2 - 50, height / 2 - 50, 100, 100); // Draw a rectangle in the center
}

// Document 5: Animation with draw()

float x = 0; // Initial x position of the circle

void setup() {
  size(800, 600); // Window size
}

void draw() {
  background(200); // Clear background each frame
  fill(255, 0, 0); // Set fill color to red
  ellipse(x, height / 2, 50, 50); // Draw the circle

  // Move the circle to the right
  x += 2;

  if (x > width) {
    x = 0; // Reset position when it reaches the end of the window
  }
}

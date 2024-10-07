// Document 6: Speed Control with frameRate()

float y = 0; // Initial y position of the rectangle

void setup() {
  size(800, 600); // Window size
  frameRate(30);  // Control the speed of the animation
}

void draw() {
  background(200);  // Clear background each frame
  fill(255, 255, 0); // Set fill color to yellow
  rect(width / 2 - 25, y, 50, 50); // Draw the rectangle

  // Move the rectangle downward
  y += 5;

  if (y > height) {
    y = 0; // Reset position when it reaches the bottom of the window
  }
}

// Document 3: Mouse Interaction

void setup() {
  size(800, 600); // Window size
}

void draw() {
  background(200); // Clear background each frame
  fill(0, 0, 255); // Set fill color to blue
  ellipse(mouseX, mouseY, 50, 50); // Circle follows the mouse position
}

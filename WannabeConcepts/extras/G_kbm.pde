// Document 7: Combined Interaction (Mouse and Keyboard)

float circleSize = 50; // Initial size of the circle

void setup() {
  size(800, 600); // Window size
}

void draw() {
  background(200); // Clear background each frame
  fill(0, 255, 0); // Set fill color to green
  ellipse(mouseX, mouseY, circleSize, circleSize); // Circle follows the mouse
}

void keyPressed() {
  if (key == '+') {
    circleSize += 10; // Increase size when '+' is pressed
  } else if (key == '-') {
    circleSize -= 10; // Decrease size when '-' is pressed
  }
}

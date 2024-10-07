// Document 4: Keyboard Interaction

color rectColor = color(255); // Default color of the rectangle

void setup() {
  size(800, 600); // Window size
}

void draw() {
  background(200); // Clear background each frame
  fill(rectColor); // Use the current rectangle color
  rect(width / 2 - 50, height / 2 - 50, 100, 100); // Draw rectangle
}

void keyPressed() {
  if (key == 'r') {
    rectColor = color(255, 0, 0); // Change to red when 'r' is pressed
  } else if (key == 'g') {
    rectColor = color(0, 255, 0); // Change to green when 'g' is pressed
  } else if (key == 'b') {
    rectColor = color(0, 0, 255); // Change to blue when 'b' is pressed
  }
}

// Globales
float circleX, circleY;       // For the center circle and the one following the mouse
float rectX, rectY;           // For the animated rectangle
float fallingRectY = 0;       // For the falling rectangle
float circleSize = 50;        // Size of the circle following the mouse
color rectColor = color(255); // Color of the rectangle that changes with keyboard input

void setup() {
  // Window size
  size(800, 600);
  circleX = width / 2;
  circleY = height / 2;
  rectX = 0;
  rectY = height - 100; // Position of the animated rectangle near the bottom
  frameRate(60);        // Control animation speed
}

void draw() {
  // Background
  background(100, 150, 200); // Constant background color

  // 1. Draw a circle in the center
  fill(255, 0, 0); // Red fill
  noStroke();
  ellipse(circleX, circleY, 100, 100); // Circle in the center

  // 2. Figure with colors and background (a different circle)
  fill(0, 255, 0); // Green circle
  ellipse(mouseX, mouseY, circleSize, circleSize); // Circle following the mouse

  // 3. Simple animation - circle moving from left to right
  fill(0, 0, 255); // Blue circle
  ellipse(rectX, height / 2, 50, 50);
  rectX += 2;
  if (rectX > width) {
    rectX = 0;
  }

  // 4. Rectangle that changes color with keyboard input
  fill(rectColor);
  rect(width / 2 - 50, height / 2 - 50, 100, 100);

  // 5. Animation with frameRate - rectangle falling down
  fill(255, 255, 0); // Yellow rectangle
  rect(width / 2 - 25, fallingRectY, 50, 50);
  fallingRectY += 3; // Increase speed
  if (fallingRectY > height) {
    fallingRectY = 0;
  }
}

// 6. Keyboard interaction - change rectangle color
void keyPressed() {
  if (key == 'r') {
    rectColor = color(255, 0, 0); // Change to red
  } else if (key == 'g') {
    rectColor = color(0, 255, 0); // Change to green
  } else if (key == 'b') {
    rectColor = color(0, 0, 255); // Change to blue
  }

  // 7. Combined mouse and keyboard interaction
  if (key == '+') {
    circleSize += 10; // Increase the size of the circle following the mouse
  } else if (key == '-') {
    circleSize -= 10; // Decrease the size of the circle
  }
}

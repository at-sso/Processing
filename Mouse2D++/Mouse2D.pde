// Colors for the first geometric event
float rColor1, gColor1, bColor1;
// Colors for the second geometric event
float rColor2, gColor2, bColor2;
// Background colors
float bgRColor, bgGColor, bgBColor;

// Keeps track of collision status
boolean isColliding = false;
// Ensures background color changes only once per collision
boolean hasChangedBg = false;

void setup() {
  size(640, 360);
  noStroke();  // Disables the stroke around shapes
  rectMode(CENTER);  // Sets rectangle drawing mode to center

  // Initialize random colors for the geometric events and background
  rColor1 = random(255);
  gColor1 = random(255);
  bColor1 = random(255);
  rColor2 = random(255);
  gColor2 = random(255);
  bColor2 = random(255);

  bgRColor = random(51);
  bgGColor = random(51);
  bgBColor = random(51);
}

void draw() {
  /* Gradually fade the background to a dark gray color
   * This creates a smooth return effect to the default background color over time */
  bgRColor = lerp(bgRColor, 51, 0.01);
  bgGColor = lerp(bgGColor, 51, 0.01);
  bgBColor = lerp(bgBColor, 51, 0.01);
  background(bgRColor, bgGColor, bgBColor);  // Set the background color

  /* Color change for the first geometric event
   * The lerp() function interpolates between the current color and a new random color, creating a smooth transition effect */
  rColor1 = lerp(rColor1, random(255), 0.02);
  gColor1 = lerp(gColor1, random(255), 0.02);
  bColor1 = lerp(bColor1, random(255), 0.02);

  // Color change for the second geometric event
  rColor2 = lerp(rColor2, random(255), 0.02);
  gColor2 = lerp(gColor2, random(255), 0.02);
  bColor2 = lerp(bColor2, random(255), 0.02);

  // Get the dimensions and positions of the geometric events based on mouse position
  int w1 = mouseY / 2 + 30;  // Width and height of the first shape, dependent on mouseY
  int h1 = w1;               // Keep the shape proportionate (square or circle)
  int x1 = mouseX;           // X position of the first shape, dependent on mouseX
  int y1 = height / 2;       // Y position is fixed to the center of the screen

  int w2 = (height - mouseY) / 2 + 20;  // Width and height of the second shape, inversely dependent on mouseY
  int h2 = w2;                          // Keep the shape proportionate (square or circle)
  int x2 = width - mouseX;              // X position is inversely dependent on mouseX
  int y2 = height / 2;                  // Y position is fixed to the center of the screen

  // Check if the two geometric events are colliding
  isColliding = checkCollision(x1, y1, w1, h1, x2, y2, w2, h2);

  // Layering logic: The larger shape will be drawn last to ensure it overlaps the smaller one
  if (w1 > w2) {
    // Draw the second shape first
    drawGeometricEvent(x2, y2, w2, h2, rColor2, gColor2, bColor2, 2);
    // Draw the first shape last
    drawGeometricEvent(x1, y1, w1, h1, rColor1, gColor1, bColor1, 1);
  } else {
    // Draw the first shape first
    drawGeometricEvent(x1, y1, w1, h1, rColor1, gColor1, bColor1, 1);
    // Draw the second shape last
    drawGeometricEvent(x2, y2, w2, h2, rColor2, gColor2, bColor2, 2);
  }

  // Handle background color change on collision
  if (isColliding) {
    // Change the background only once when the shapes collide
    if (!hasChangedBg) {
      // Set a new random background color
      bgRColor = random(255);
      bgGColor = random(255);
      bgBColor = random(255);

      // Mark that the background has been changed
      hasChangedBg = true;
    }
  } else {
    // Reset the flag if the shapes are no longer colliding
    hasChangedBg = false;
  }
}

/* This function draws the geometric event based on its type and color
 * type == 1: Rectangle
 * type == 2: Ellipse */
void drawGeometricEvent(int x, int y, int w, int h, float r, float g, float b, int type) {
  fill(r, g, b, 204);  // Set the fill color with some transparency

  // Choose the shape based on the type parameter
  if (type == 1) {
    // Draw a rectangle if type is 1
    rect(x, y, w, h);
  } else if (type == 2) {
    // Draw an ellipse if type is 2
    ellipse(x, y, w, h);
  }
}

/* This function checks for collisions between two rectangular shapes.
 * It returns true if the shapes are overlapping, and false otherwise. */
boolean checkCollision(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
  // Check if the distance between the centers of the shapes is less than the sum of their half-widths and half-heights
  // This simple bounding-box collision check works for both rectangles and circles
  return abs(x1 - x2) < (w1 / 2 + w2 / 2) && abs(y1 - y2) < (h1 / 2 + h2 / 2);
}

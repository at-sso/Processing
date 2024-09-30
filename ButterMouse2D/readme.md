## **Interactive 2D Geometric Events and Collision Detection in Processing**

### **Project Overview**

The goal of this project was to implement two interactive geometric shapes, each responding to mouse input by changing position, size, and color. When these shapes collide, they trigger an event that causes the background to change. Additionally, the larger shape dynamically layers over the smaller one, maintaining a realistic overlap effect. The program also ensures that the background only changes once upon collision, preventing rapid flashing that could be unpleasant or unsafe for viewers.

### **Key Concepts**

Let’s dive into the main concepts behind the project:

1. **Mouse Interaction:**
   The position and size of the geometric shapes are controlled by the mouse's X and Y coordinates. As you move the mouse, the shapes adjust their size based on these coordinates, making the interaction feel smooth and responsive. Here’s how we achieve this in the code:

   ```java
   // Get the dimensions and positions of the geometric events based on mouse position
   int w1 = mouseY / 2 + 30;  // Width and height of the first shape, dependent on mouseY
   int h1 = w1;               // Keep the shape proportionate (square or circle)
   int x1 = mouseX;           // X position of the first shape, dependent on mouseX
   int y1 = height / 2;       // Y position is fixed to the center of the screen
   ```

   As the mouse moves, the width and height of the first shape (`w1`, `h1`) are dynamically set based on the Y position of the mouse, while the X position (`x1`) follows the mouseX value.

2. **Geometric Events:**
   Each geometric shape is treated as a "geometric event." In our program, we have two types of geometric forms: rectangles and ellipses. These events change in size and color as you move the mouse, creating a dynamic visual effect:

   ```java
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
   ```

   In this function, the geometric event's color is determined by the `r`, `g`, and `b` values, and the shape is chosen based on the `type` parameter (either `rect()` or `ellipse()`).

3. **Collision Detection:**
   When the two shapes intersect or "collide," a special event occurs—the background color changes. To achieve this, the program checks whether the two shapes overlap by comparing their positions and sizes:

   ```java
   /* This function checks for collisions between two rectangular shapes.
    * It returns true if the shapes are overlapping, and false otherwise. */
   boolean checkCollision(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
     // Check if the distance between the centers of the shapes is less than the sum of their half-widths and half-heights
     // This simple bounding-box collision check works for both rectangles and circles
     return abs(x1 - x2) < (w1 / 2 + w2 / 2) && abs(y1 - y2) < (h1 / 2 + h2 / 2);
   }
   ```

   This simple bounding-box collision check returns `true` if the two shapes overlap, triggering the background color change.

4. **Layering by Size:**
   One interesting feature of this project is the layering of shapes. The larger shape always appears on top of the smaller one, which is accomplished by controlling the drawing order:

   ```java
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
   ```

   Here, the program compares the widths of the two shapes (`w1` and `w2`) and determines which one to draw last. The larger shape is drawn last to ensure it appears on top.

5. **Fade Effect and Smooth Color Transitions:**
   Instead of instant color changes, this project uses smooth transitions for both the shapes and the background. We achieve this by using the [`lerp()` function](https://processing.org/reference/lerp_.html), which gradually interpolates between colors:

   ```java
   rColor1 = lerp(rColor1, random(255), 0.02);  // Smooth transition for red color in shape 1
   gColor1 = lerp(gColor1, random(255), 0.02);  // Smooth transition for green color in shape 1
   bColor1 = lerp(bColor1, random(255), 0.02);  // Smooth transition for blue color in shape 1
   ```

   The [`lerp()` function](https://processing.org/reference/lerp_.html) interpolates between the current color value and a new random value, creating a smooth transition or “fade” effect over time.

6. **Controlling Background Changes on Collision:**
   To prevent rapid flashing of the background when the shapes collide, the program ensures the background only changes once per collision event:

   ```java
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
   ```

   The `hasChangedBg` flag ensures that the background color only changes once when the shapes collide and doesn’t keep changing while they remain in contact. This prevents rapid flashing, especially when the mouse is stationary, improving the user experience.

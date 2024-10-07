import java.io.File;

// Globales
String absolutePath;
String rendersPath = "/renders";
int fileCount = 0;
PImage img;

// This is used in the `draw` function, it helps while getting the index of `imageArray`.
int imageArrayIndex = 0;
// Holds a pointer to the image objects.
ArrayList<PImage> imageArray = new ArrayList<PImage>();

// Generic file name. This name must follow any possitive numeric sequence at the end, e.g.: Layer 1, Layer 2, etc...
String genericFileName = "/frame_";
// This extension can be anything that can be handled by Processing.
String genericFileNameExt = ".png";

public void settings() {
  size(1500, 1000);
}

void setup() {
  frameRate(25);

  // `sketchPath()` only works after `setup`.
  // https://stackoverflow.com/a/68964668
  println("File name pattern: " + genericFileName + "*" + genericFileNameExt);
  absolutePath = sketchPath();
  rendersPath = absolutePath + rendersPath;
  genericFileName = rendersPath + genericFileName;

  // Set the number of files.
  File folder = new File(rendersPath);
  File[] files = folder.listFiles();
  if (files != null) {
    fileCount = files.length;
  }

  // If the file count is zero (0), exit before the `draw` function is called.
  println("File count: " + fileCount);
  if (fileCount == 0) {
    println("File count is zero or null.");
    exit();
  }

  // Construct the `imageArray` variable.
  // Note: If the image doesn't exist, Processing will automatically skip the file and continue.
  println("Loading images...");
  String imageArrayFileName;
  for (int i = 0; i < fileCount; i++) {
    // Get the image file following the generic file name.
    imageArrayFileName = genericFileName + i + genericFileNameExt;
    println("Loading image: " + imageArrayFileName);
    img = loadImage(imageArrayFileName);
    imageArray.add(img);
  }
  println("Done.");
}

void draw() {
  // Start the animation.
  imageArrayIndex++;
  if (imageArrayIndex == fileCount) {
    imageArrayIndex = 0;
  }

  PImage currentImage = imageArray.get(imageArrayIndex); // A pointer to the current image.

  // Check if the image is larger than the canvas
  if (currentImage.width > width || currentImage.height > height) {
    // Calculate the scaling factor
    float aspectRatioImage = (float)currentImage.width / currentImage.height;
    float aspectRatioCanvas = (float)width / height;

    if (aspectRatioImage > aspectRatioCanvas) {
      // Image is wider than the canvas, fit by width
      currentImage.resize(width, 0);  // Resize to canvas width, height will adjust to maintain aspect ratio
    } else {
      // Image is taller or proportionally smaller than the canvas, fit by height
      currentImage.resize(0, height);  // Resize to canvas height, width will adjust to maintain aspect ratio
    }
  }

  int imgPosX = (width - currentImage.width) / 2;   // Calculate the image X axis.
  int imgPosY = (height - currentImage.height) / 2; // Calculate the image Y axis.

  background(255);
  image(currentImage, imgPosX, imgPosY); // Render the image in the center.
}

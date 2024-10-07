from PIL import Image
import tkinter as tk
from tkinter import filedialog
import os
import shutil


def extract_frames_from_gif(gif_path, output_folder) -> None:
    # Remove the output folder if it exists
    if os.path.exists(output_folder):
        shutil.rmtree(output_folder)

    # Open the GIF file
    with Image.open(gif_path) as img:
        # Ensure the output folder exists
        os.makedirs(output_folder, exist_ok=True)

        print("Extracting frames...")
        # Iterate through each frame
        for frame_number in range(img.n_frames):
            img.seek(frame_number)  # Move to the specific frame
            frame = img.copy()  # Copy the current frame

            # Save the frame as a PNG file
            frame.save(os.path.join(output_folder, f"frame_{frame_number:01d}.png"))
        print("Done.")


root = tk.Tk()
image_path = filedialog.askopenfilename(
    title="Select Image",  # Dialog title
    filetypes=(("Graphics Interchange Format", "*.gif"),),  # File types allowed
)

extract_frames_from_gif(image_path, "./SceneTest/renders")

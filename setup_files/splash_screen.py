import tkinter as tk
from PIL import Image, ImageTk

# Create window
root = tk.Tk()
root.attributes("-fullscreen", True)
root.configure(bg="black")
root.title("Arcade Splash")

# Always on top
root.attributes("-topmost", True)

# Load logo
img = Image.open("/home/upptech/Arcade_game/upptech_8-bit.png")
img = img.resize((700, 700), Image.LANCZOS)
photo = ImageTk.PhotoImage(img)

# Image label
img_label = tk.Label(root, image=photo, bg="black")
img_label.pack(pady=40)

# Blinking text
text_label = tk.Label(root, text="INSERT GAME...", font=("Courier New", 48), fg="white", bg="black")
text_label.pack()

def blink():
    current = text_label.cget("foreground")
    next_color = "black" if current == "white" else "white"
    text_label.config(foreground=next_color)
    root.after(700, blink)

blink()

# Run splash screen
root.mainloop()

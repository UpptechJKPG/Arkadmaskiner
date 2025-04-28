#! /usr/bin/bash

echo "== Arcade Pi Setup Script =="

# Exit on error
set -e

echo "1. Installing required packages..."
sudo apt update
sudo apt install -y x11-utils xdotool wmctrl python3 python3-tk python3-pil jq qjoypad
sudo apt install python-pil.imagetk

echo "2. Setting up systemd service..."
SERVICE_FILE="/etc/systemd/system/arcade-game-launcher.service"
if [ -f "arcade-game-launcher.service" ]; then
    sudo cp arcade-game-launcher.service "$SERVICE_FILE"
    sudo systemctl daemon-reload
    sudo systemctl enable arcade-game-launcher.service
    echo "   arcade-game-launcher.service installed and enabled."
else
    echo "   ERROR: arcade-game-launcher.service not found in current directory."
fi

echo "3. Copying launcher script and splash screen..."
mkdir -p /home/upptech/Arcade_game
cp arcade-game-launcher.sh /home/upptech/
chmod +x /home/upptech/arcade-game-launcher.sh
cp splash_screen.py /home/upptech/Arcade_game/
cp upptech_8-bit.png /home/upptech/Arcade_game/
cp qjoypad.desktop /home/upptech/.config/autostart/
cp player1-arrows.lyt /home/upptech/.qjoypad3/

echo "✅ Setup complete!"
echo "You can now change session to X11 and then reboot and plug in a USB with .sb3 or .elf files to test."
echo "Also, don't forget to download Turbowarp Desktop (if not already installed)"

#!/bin/bash

echo "== Arcade Pi Setup Script =="

# Exit on error
set -e

echo "1. Installing required packages..."
sudo apt update
sudo apt install -y x11-utils xdotool wmctrl python3 python3-tk python3-pil jq qjoypad
sudo apt install python-pil.imagetk

echo "2. Disabling USB auto-mount in PCManFM..."
CONFIG_FILE="/home/upptech/.config/pcmanfm/LXDE-pi/pcmanfm.conf"
if [ -f "$CONFIG_FILE" ]; then
    sed -i 's/mount_on_startup=1/mount_on_startup=0/' "$CONFIG_FILE"
    sed -i 's/mount_removable=1/mount_removable=0/' "$CONFIG_FILE"
    sed -i 's/autorun=1/autorun=0/' "$CONFIG_FILE"
    # sed -i 's/browse_removable=1/browse_removable=0/' "$CONFIG_FILE"
else
    echo "PCManFM config file not found. Please manually adjust USB automount settings later."
fi

echo "3. Setting up systemd service..."
SERVICE_FILE="/etc/systemd/system/arcade-game-launcher.service"
if [ -f "arcade-game-launcher.service" ]; then
    sudo cp arcade-game-launcher.service "$SERVICE_FILE"
    sudo systemctl daemon-reload
    sudo systemctl enable arcade-game-launcher.service
    echo "   arcade-game-launcher.service installed and enabled."
else
    echo "   ERROR: arcade-game-launcher.service not found in current directory."
fi

echo "4. Copying launcher script and splash screen..."
mkdir -p /home/upptech/Arcade_game
cp arcade-game-launcher.sh /home/upptech/
chmod +x /home/upptech/arcade-game-launcher.sh
cp splash_screen.py /home/upptech/Arcade_game/
cp upptech_8-bit.png /home/upptech/Arcade_game/
cp qjoypad.desktop /home/upptech/.config/autostart/
cp player1-arrows-lyt /home/upptech/.qjoypad3/

echo "✅ Setup complete!"
echo "You can now change session to X11 and then reboot and plug in a USB with .sb3 or .elf files to test."
echo "Also, don't forget to download Turbowarp Desktop (if not already installed)"

#!/bin/bash

MOUNT_POINT="/media/usb"
DEVICE=$(lsblk -J -o NAME,TYPE,TRAN | jq -r '.blockdevices[] | select(.tran=="usb") | .children[]?.name' | head -n 1)
DEVICE="/dev/$DEVICE"
SB3PLAYER="/usr/bin/turbowarp-desktop"
UF2PLAYER="/usr/bin/makecode-launcher"
current_game_file=""
current_game_file_type=""

game_is_running=0

# Start screen
xdotool mousemove 1919 1079 # Hide mouse cursor
python3 /home/upptech/Arcade_game/splash_screen.py &
SPLASH_PID=$!

# Wait for display (if just booted)
sleep 10

# Prevent screen from blanking or sleeping
xset s off
xset -dpms
xset s noblank

while true; do
	DEVICE=$(lsblk -J -o NAME,TYPE,TRAN | jq -r '.blockdevices[] | select(.tran=="usb") | .children[]?.name' | head -n 1)
	DEVICE="/dev/$DEVICE"
	echo "DEBUG: Clean device name is: $DEVICE"

	if [ -n "$DEVICE" ]; then
		echo "USB detected..."
		echo "Using USB device: $DEVICE"
		
		if mount | grep -q "$DEVICE"; then
			echo "Unmounting $DEVICE first..."
			sudo umount "$DEVICE"
		fi

		echo "Mounting USB to $MOUNT_POINT..."
		sudo mkdir -p "$MOUNT_POINT"
		sudo mount "$DEVICE" "$MOUNT_POINT"
		
		# Find SB3 or UF2 file
		found_file=$(find "$MOUNT_POINT" -maxdepth 1 \( -iname "*.sb3" -o -iname "*.uf2" \) | head -n 1)

		if [ -n "$found_file" ]; then
			echo "Found game: $found_file"
			if [ "$found_file" != "$current_game_file" ]; then
				current_game_file="$found_file"
			    if [[ "$current_game_file_type" == ".sb3" ]]; then
					pkill -f turbowarp-desktop
					sleep 2

					# Try to close the confirmation window for up to 5 seconds
					for i in {1..5}; do
						echo "Attempting to close TurboWarp confirmation popup..."
						wmctrl -c "TurboWarp Desktop"
						sleep 1

						if ! wmctrl -l | grep -q "TurboWarp Desktop"; then
							echo "Popup closed!"
							break
						fi
					done

					# Force kill if still stuck
					if wmctrl -l | grep -q "TurboWarp Desktop"; then
						echo "Popup still alive! Forcing with xkill..."
						xdotool search --name "TurboWarp Desktop" windowkill
					fi
					
			    elif [[ "$current_game_file_type" == ".uf2" ]]; then
			    echo "hello .uf2"
					# Kill MakeCode application
			    fi

				if [[ "$found_file" == *.sb3 ]]; then
					current_game_file_type=".sb3"
					
					# Launch with TurboWarp Desktop
					"$SB3PLAYER" "$found_file" &
					sleep 1  # Give it a second to start

					# Wait until the window appears and is ready (checking if the "TurboWarp Desktop" window exists)
					echo "Waiting for TurboWarp to load..."
					while ! wmctrl -l | grep -q "TurboWarp Desktop"; do
						echo "TurboWarp not loaded yet..."
						sleep 1  # Check every second
					done
					
					wmctrl -r "TurboWarp Desktop" -b add,fullscreen # Set it to fullscreen
					sleep 2 # Allow time for full-screening
					kill "$SPLASH_PID" # Destroy the Splash screen
					
					# Wait until the 'Start' button appears and interact with it
					echo "Waiting for 'Start' button to appear..."
					while ! xdotool search --name "TurboWarp Desktop" getwindowname | grep -q " TurboWarp Desktop"; do
						echo "'Start' button not found, retrying..."
						sleep 1  # Wait for button to be ready
					done
					
					sleep 2
					xdotool mousemove 1442 71 click 1 # Click Start
					xdotool mousemove 1898 71 click 1 # Click Fullscreen
					xdotool mousemove 1919 1079 # Hide mouse cursor

				elif [[ "$found_file" == *.uf2 ]]; then
					current_game_file_type=".uf2"
				
					# Launch with MakeCode
					"$UF2PLAYER" "$found_file" &
					
				fi
				game_is_running=1
				while [ "$game_is_running" -eq 1 ]; do
					DEVICE=$(lsblk -J -o NAME,TYPE,TRAN | jq -r '.blockdevices[] | select(.tran=="usb") | .children[]?.name' | head -n 1)
					DEVICE="/dev/$DEVICE"
					echo "DEBUG GAME RUNNING: Clean device name is: $DEVICE"

					if [ -n "$DEVICE" ]; then
						echo "Unmounting and mounting new USB device..."
						sudo umount "$DEVICE" 2>/dev/null
						sudo mkdir -p "$MOUNT_POINT"
						if sudo mount "$DEVICE" "$MOUNT_POINT"; then
							new_file=$(find "$MOUNT_POINT" -maxdepth 1 \( -iname "*.sb3" -o -iname "*.uf2" \) | head -n 1)

							if [ -n "$new_file" ] && [ "$new_file" != "$current_game_file" ]; then
								echo "New USB detected with a different game!"
								python3 /home/upptech/Arcade_game/splash_screen.py &
								SPLASH_PID=$!
								break # Exit loop to restart with new game
							fi
						else
							echo "Mount failed for $DEVICE"
						fi
					fi
					
					sleep 2
				done
			fi
		fi
	fi
	sleep 5
done

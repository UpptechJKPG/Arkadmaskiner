# Arkadmaskiner
Här finns allt som behövs för att få igång en arkadmaskin så att den kan köra spel programmerade i Scratch.
Allt som behövs göras är att: 
1. Köra "start-up"-skriptet "setup_arcade_pi.sh".
2. Använda X11-session, inte Wayland.
3. Stänga av USB-notiser.
4. Installera TurboWarp Desktop

## 1. Köra "start-up"-skriptet "setup_arcade_pi.sh"
Skriptet hittas i mappen "setup_files". För att köra skriptet på Pi:n, så behövs alla filer innuti "setup_files" kopieras över till en USB, som sedan sätts in i Pi:n. \
Kopiera sedan alla filer till skrivbordet (Desktop). \
Öppna en terminal (CTRL + ALT + T), skriv `cd Desktop/` och tryck Enter, skriv sedan in `chmod +x setup_arcade_pi.sh` och till sist, för att köra skriptet, `bash setup_arcade_pi.sh`.

## 2. Använda X11-session, inte Wayland
För att Pi:n ska kunna köra programmet för att spela spelen, behöver den använda X11, inte Wayland. \
För att se vad som används, skriv `echo $XDG_SESSION_TYPE` i terminalen och tryck Enter. \
Om det står "x11", kan du gå vidare till steg 3. \
Om det står "wayland", behlver du ändra till X11. \
För att ändra till X11, skriv `sudo raspi-config` och tryck Enter, då får du upp en meny. Välj "A6 Advanced Options", sedan "A6 Wayland" och till sist "W1 X11". \
Stäng ner menyn genom att trycka på Esc-knappen. \
För att ändringen ska gälla behövs en omstart. Starta om och kontrollera sedan sessionen med `echo $XDG_SESSION_TYPE` \
(ALT + CTRL + T för att öppna terminalen).

## 3. Stäng av USB-notiser
Öppna Filhanteraren (File Manager) och välj Redigera (Edit) och Inställningar (Settings). Sedan, under Volymhantering (Volume Management), avmarkera "Montera flyttbara enheter automatiskt när de ansluts" och "Visa tillgängliga alternatic från flyttbara medier när de ansluts".
![PCman_Volume_Management](https://github.com/user-attachments/assets/44aeba16-577e-42f1-9958-ab16864d8bd9)

## 4. Installera TurboWarp Desktop


Sedan är det bara att starta om Pi:n genom att skriva "sudo reboot" i terminalen (eller bara stänga av och sätta på strömmen).
Om TurboWarp Desktop inte redan är installerat behövs det också installeras genom att köra förljande kommandon:
> wget https://desktop.turbowarp.org/release-signing-key.gpg -qO- | gpg --dearmor | sudo tee /usr/share/keyrings/turbowarp.gpg > /dev/null

> echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/turbowarp.gpg] https://releases.turbowarp.org/deb stable main" | sudo tee /etc/apt/sources.list.d/turbowarp.list

> sudo apt update

> sudo apt install turbowarp-desktop


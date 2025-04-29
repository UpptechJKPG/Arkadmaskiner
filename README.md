# Arkadmaskiner
Här finns allt som behövs för att få igång en arkadmaskin så att den kan köra spel programmerade i Scratch.
Allt som behövs göras är att: 
1. Göra "start-up"-skriptet exekverbart.
2. Köra "start-up"-skriptet "setup_arcade_pi.sh".
3. Använda X11-session, inte Wayland.
4. Stänga av USB-notiser.
5. Installera TurboWarp Desktop

## 1. Göra "start-up"-skriptet exekverbart
Skriptet hittas i mappen "setup_files". Alla filer innuti "setup_files" behövs kopieras över till en USB, som sedan sätts in i Pi:n. \
Inne i Pi:n, kopiera sedan alla filer från USB:n till skrivbordet (Desktop). \
Öppna en terminal (CTRL + ALT + T), skriv `sudo apt-get update` och tryck Enter, och sedan `sudo apt-get install dos2unix` och tryck Enter. \
Kör sedan `cd Desktop/` och sedan `dos2unix setup_arcade_pi.sh`, nu är skriptet exekverbart.

## 2. Köra "start-up"-skriptet "setup_arcade_pi.sh"
I samma terminal från steg 1, skriv in `chmod +x setup_arcade_pi.sh` och tryck Enter och till sist, för att köra skriptet, `bash setup_arcade_pi.sh`.

## 3. Använda X11-session, inte Wayland
För att Pi:n ska kunna köra programmet för att spela spelen, behöver den använda X11, inte Wayland. \
För att se vad som används, skriv `echo $XDG_SESSION_TYPE` i terminalen och tryck Enter. \
Om det står "x11", kan du gå vidare till steg 3. \
Om det står "wayland", behlver du ändra till X11. \
För att ändra till X11, skriv `sudo raspi-config` och tryck Enter, då får du upp en meny. Välj "A6 Advanced Options", sedan "A6 Wayland" och till sist "W1 X11". \
Stäng ner menyn genom att trycka på Esc-knappen. \
För att ändringen ska gälla behövs en omstart. Starta om och kontrollera sedan sessionen med `echo $XDG_SESSION_TYPE` \
(ALT + CTRL + T för att öppna terminalen).

## 4. Stäng av USB-notiser
Öppna Filhanteraren (File Manager) och välj Redigera (Edit) och Inställningar (Settings). Sedan, under Volymhantering (Volume Management), avmarkera "Montera flyttbara enheter automatiskt när de ansluts" och "Visa tillgängliga alternatic från flyttbara medier när de ansluts".
![PCman_Volume_Management](https://github.com/user-attachments/assets/44aeba16-577e-42f1-9958-ab16864d8bd9)

## 5. Installera TurboWarp Desktop
TurboWarp Desktop är programmet som spelen startas i. \
Det kan vara så att TurboWarp Dekstop redan är installerat. Kontrollera genom att köra `turbowarp-desktop` i terminalen. \
Om en applikation öppnas upp, så är det installerat, annars är det inte installerat. \

Om det inte är installerat, så installerar man det genom att köra följande kommandon i terminalen:
1. `wget https://desktop.turbowarp.org/release-signing-key.gpg -qO- | gpg --dearmor | sudo tee /usr/share/keyrings/turbowarp.gpg > /dev/null`
2. `echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/turbowarp.gpg] https://releases.turbowarp.org/deb stable main" | sudo tee /etc/apt/sources.list.d/turbowarp.list`
3. `sudo apt update`
4. `sudo apt install turbowarp-desktop`

Sedan är det bara att starta om Pi:n genom att skriva "sudo reboot" i terminalen (eller bara stänga av och sätta på strömmen).

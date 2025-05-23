# Arkadmaskiner
Här finns allt som behövs för att få igång en arkadmaskin så att den kan köra spel programmerade i Scratch.
Allt som behövs göras är att: 
1. Göra "start-up"-skriptet exekverbart.
2. Köra "start-up"-skriptet "setup_arcade_pi.sh".
3. Använda X11-session, inte Wayland.
4. Stänga av USB-notiser.
5. Installera och ställa in TurboWarp Desktop.

Under [Instruktioner](#instruktioner) finns intruktioner för hur man kan använda arkadmaskinerna och hur man startar spel på dem.\
Under [Kontroller](#kontroller) finns en beskrivning av vilka tangenter joysticksen och knapparna är kopplade till.

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
Om det står "x11", kan du gå vidare till steg 4. \
Om det står "wayland", behöver du ändra till X11. \
För att ändra till X11, skriv `sudo raspi-config` i terminalen och tryck Enter, då får du upp en meny (navigera med hjälp av pil-tangenterna och Enter). Välj "6 Advanced Options", sedan "A6 Wayland" och till sist "W1 X11". \
Stäng ner menyn genom att trycka på Esc-knappen. \
För att ändringen ska gälla behövs en omstart. \
**=== OBS! ===** \
**När du startar om datorn så kommer en bild komma upp och täcka hela skärmen. Du behöver stänga ner bilden (ALT + F4) och sedan köra `sudo systemctl stop arcade-game-launcher.service` i terminalen.** \
**============** 

Efter omstart, kontrollera sessionen med `echo $XDG_SESSION_TYPE` \
(ALT + CTRL + T för att öppna terminalen).

## 4. Stäng av USB-notiser
Öppna Filhanteraren (File Manager) och välj Redigera (Edit) och Inställningar (Preferences). Sedan, under Volymhantering (Volume Management), avmarkera "Montera flyttbara enheter automatiskt när de ansluts" och "Visa tillgängliga alternativ från flyttbara medier när de ansluts". \
![PCman_Volume_Management](https://github.com/user-attachments/assets/44aeba16-577e-42f1-9958-ab16864d8bd9)

## 5. Installera och ställa in TurboWarp Desktop
TurboWarp Desktop är programmet som spelen startas i. \
Det kan vara så att TurboWarp Dekstop redan är installerat. Kontrollera genom att köra `turbowarp-desktop` i terminalen. \
Om en applikation öppnas upp, så är det installerat, annars är det inte installerat. 

Om det inte är installerat, så installerar man det genom att köra följande kommandon i terminalen:
1. `wget https://desktop.turbowarp.org/release-signing-key.gpg -qO- | gpg --dearmor | sudo tee /usr/share/keyrings/turbowarp.gpg > /dev/null`
2. `echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/turbowarp.gpg] https://releases.turbowarp.org/deb stable main" | sudo tee /etc/apt/sources.list.d/turbowarp.list`
3. `sudo apt update`
4. `sudo apt install -y turbowarp-desktop`

För att TurboWarp Desktop ska se bättre ut för arkadmaskinerna, behövs några inställningar göras inne i TurboWarp Desktop. \
Starta TurboWarp Desktop genom att köra `turbowarp-desktop` i terminalen. \
I menyn högst up finns "Settings" och "Addons", i de två ska vi göra ändringar.
![TurboWarp_Desktop_Taskbar](https://github.com/user-attachments/assets/436be9ee-c2ed-48f7-b81c-80e5ba3e8d30)

### 1. Settings
Under "Settings", tryck på "Switch To Dark Mode"
![TurboWarp_Deskop_Settings](https://github.com/user-attachments/assets/b2635873-a68b-4efa-b9f1-2f843abf1c6d)

### 2. Addons
När du trycker på "Addons" får du upp en meny med ett sökfält, sök på "Enhanced full screen". \
Då dyker det upp en Addon som heter just "Enhanced full screen". \
![TurboWarp_Desktop_Enhanced_full_screen_unselected](https://github.com/user-attachments/assets/d923d1e1-1df2-4352-8c40-9dc226fa949d)

Välj den, och välj sedan "Never" nedanför. \
![TurboWarp_Desktop_Enhanced_full_screen](https://github.com/user-attachments/assets/eeda246e-af5b-48df-82ac-4d82b7f85f37) \
Sen stänger du bara ner den menyn.

## 

## Klappat och klart!
Nu borde allt fungera. \
Sedan är det bara att starta om Pi:n genom att skriva "sudo reboot" i terminalen och hålla tummarna (eller bara stänga av och sätta på strömmen).

**OBS** Om det inte går att skriva i terminalen, testa trycka CTRL + C

# Instruktioner
Allt som behövs för att starta ett spel på arkadmaskinen är en USB-sticka som innehåller en SB3-fil (filändelse .sb3). Under mappen "Spel/" finns några SB3-filer (de som börjar på "Upptech_" är redigerade så att de passar för arkadmaskinerna).\
Stoppa in USB:n i arkadmaskinen så startar spelet efter ett litet tag.

**=== OBS! ===** \
**USB:n kan innehålla annat än bara spelfilen utan några problem, men den bör innehålla endast 1 fil av typ .sb3.** \
**USB:n bör inte dras ut innan spelet har startats helt, annars kommer programmet att krascha.** \
**============**

Efter att spelet har startats, kan USB:n säkert dras ut och spelet kommer att fortsätta köras.

## Starta nytt spel
Om "spel A" körs just nu, och en USB med "spel A" stoppas in på nytt i arkadmaskinen, så kommer ingenting att hända och "spel A" kör på som vanligt. Men om ett annat spel stoppas in (t.ex "spel B") så kommer "spel A" att avslutas och "spel B" att startas.\
Det enda sätter just nu för att stänga av ett spel utan att starta ett nytt, är att helt enkelt starta om arkadmaskinen.

# Kontroller
Om allt går som det ska (det gör oftast det) så är den högra spelaren "spelare 1" och den vänsta "spelare 2" (vid start av arkadmaskinen kan det ibland bli tvärtom).

## Spelare 1 (höger)
Joystick - Pil-tangenter [↑], [←], [↓], [→]\
Knappar  - [U], [I], [O], [P]

## Spelare 2 (vänster)
Joystick - WASD-tangenter [W], [A], [S], [D]\
Knappar  - [E], [R], [T], [Y]

## Centerknappar
Det finns 3 knappar i mitten, just nu har de ingen användning (de är inte kopplade till något).\
De hade möjligtvis kunnats kopplas till "kontrolltangenter" (t.ex. TAB, Enter, Space).\
Just nu är det qjoypad som används för att konfigurera kontrollerna. Om ändringar önskas göras till arkadmaskinens kontroller, så kan man köra `qjoypad` i terminalen. Filen som används för kontrollerna heter "player1-arrow.lyt" (även om den heter "player1" används den för båda spelares kontroller)

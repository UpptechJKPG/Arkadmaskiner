# Arkadmaskiner
Här finns allt som behövs för att få igång en arkadmaskin så att den kan köra spel programmerade i Scratch.
Allt som behövs göras är att köra "start-up"-skriptet "setup_arcade_pi.sh" som finns under "setup_files"-mappen. \
För att köra skriptet på Pi:n, så behövs alla filer innuti "setup_files" kopieras över till en USB, som sedan sätts in i Pi:n. \
Det bör se ut såhär i USB:n
()[]

Öppna en terminal (CTRL + ALT + T), navigera till USB:n, skriv sedan in följande och tryck Enter: \
> chmod +x setup_arcade_pi.sh \
Kör sedan det genom att skriva följande och trycka Enter: \
> ./setup_arcade_pi.sh 

Sedan är det bara att starta om Pi:n genom att skriva "sudo reboot" i terminalen (eller bara stänga av och sätta på strömmen).
Om TurboWarp Desktop inte redan är installerat behövs det också installeras genom att köra förljande kommandon:
> wget https://desktop.turbowarp.org/release-signing-key.gpg -qO- | gpg --dearmor | sudo tee /usr/share/keyrings/turbowarp.gpg > /dev/null \
> echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/turbowarp.gpg] https://releases.turbowarp.org/deb stable main" | sudo tee /etc/apt/sources.list.d/turbowarp.list \
> sudo apt update \
> sudo apt install turbowarp-desktop 

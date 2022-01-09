message() {
    clear
    echo	" ______                   __             ___    ___                  __  __"
    echo	"/\__  _\                 /\ \__         /\_ \  /\_ \                /\ \/\ \ " 
    echo	"\/_/\ \/     ___     ____\ \ ,_\    __  \//\ \ \//\ \      __   _ __\ \ \ \ \  _____    ____"  
    echo	"   \ \ \   /  _  \  / ,__\\ \ \/  / __ \  \ \ \  \ \ \   / __ \/\  __\ \ \ \ \/\  __ \  / ,__\ "   
    echo	"    \_\ \__/\ \/\ \/\__,  \\ \ \_/\ \L\.\_ \_\ \_ \_\ \_/\  __/\ \ \/ \ \ \_/ \ \ \L\ \/\__,  \ "  
    echo	"    /\_____\ \_\ \_\/\____/ \ \__\ \__/.\_\/\____\/\____\ \____\\ \_\  \  \___/\ \ ,__/\/\____/ " 
    echo	"    \/_____/\/_/\/_/\/___/   \/__/\/__/\/_/\/____/\/____/\/____/ \/_/    \/__/  \ \ \/  \/___/ " 
    echo	"                                                                                 \ \_\         " 
    echo	"                                                                                  \/_/         " 
    echo
    echo
    echo -e "$1"
    echo
    echo -e "$2"
    echo
}

nodeJSInstall() {
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    apt install -y nodejs
    echo "$(date '+%d/%m/%Y') | $(date '+%H:%M') > [Nodejs] Installer par le programme ($USER)!" >> /home/InstallerVps/logs.txt
    npm i pm2 -g
    echo "$(date '+%d/%m/%Y') | $(date '+%H:%M') > [PM2] Installer par le programme ($USER)!" >> /home/InstallerVps/logs.txt
    sleep 3
}

debian() {
    message "VPS : Debian | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Mise à jour de votre système !"
    apt update
    apt upgrade -y
    apt full-upgrade -y
    apt auto-remove
    sleep 3
    message "VPS : Debian | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Mise à jour effectuer, Installation des dépendances BASIC !"
    apt install screen htop nano curl
    sleep 3
    message "VPS : Debian | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Installation des dépendances BASIC effectuer, Création de l'environnement pour le programme !"
    mkdir /home/InstallerVps/
    cd /home/InstallerVps/
    echo "$(date '+%d/%m/%Y') | $(date '+%H:%M') > Environnement en cours d'installation !" >> logs.txt
    mkdir IV_dataSave
    echo "$(date '+%d/%m/%Y') | $(date '+%H:%M') > Dossier [IV_dataSave] créer par le programme ($USER)!" >> logs.txt
    mkdir IV_tempData
    echo "$(date '+%d/%m/%Y') | $(date '+%H:%M') > Dossier [IV_tempData] créer par le programme ($USER)!" >> logs.txt
    cd ./IV_tempData
    message "VPS : Debian | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Création de l'environnement pour le programme effectuer, Installation de nodeJS v16 !"
    nodeJS
}

ubuntu() {
    message "VPS : Ubuntu | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Mise à jour de votre système !"
    apt update
    apt upgrade -y
    apt full-upgrade -y
    apt auto-remove
    sleep 3
    message "VPS : Ubuntu | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Mise à jour effectuer, Installation des dépendances BASIC !"
    apt install screen htop nano curl
    sleep 3
    message "VPS : Ubuntu | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Installation des dépendances BASIC effectuer, Création de l'environnement pour le programme !"
    mkdir /home/InstallerVps/
    echo "$(date '+%d/%m/%Y') | $(date '+%H:%M') > Environnement en cours d'installation !" >> /home/InstallerVps/logs.txt
    mkdir IV_dataSave
    echo "$(date '+%d/%m/%Y') | $(date '+%H:%M') > Dossier [IV_dataSave] créer par le programme ($USER)!" >> /home/InstallerVps/logs.txt
    mkdir IV_tempData
    echo "$(date '+%d/%m/%Y') | $(date '+%H:%M') > Dossier [IV_tempData] créer par le programme ($USER)!" >> /home/InstallerVps/logs.txt
    message "VPS : Ubuntu50 | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Création de l'environnement pour le programme effectuer, Installation de nodeJS v16 !"
    nodeJSInstall
    echo "ready" >> IsReady.txt
}

home() {
    if [ -e IsReady.txt ]
    then
       message "Bienvenue dans l'Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Panel"
        echo " _____________________________________________________________________________"
        echo "|                                                                             |"
        echo -e "|    - \e[1;34mRe installer\e[0;31m [re_install] \e[0;m                                             |"
        echo "|                                                                             |"
        echo -e "|    - \e[1;34mDémarrage du panel [web]\e[0;31m [start_panel]\e[0;m                                 |"
        echo "|                                                                             |"
        echo -e "|    - \e[1;34mArrêt du panel [web]\e[0;31m [stop_panel] \e[0;m                                     |"
        echo "|                                                                             |"
        echo "|    -                                                                        |"
        echo "|                                                                             |"
        echo "|    -                                                                        |"
        echo "|                                                                             |"
        echo -e "|    - \e[1;34mRetour <- \e[0;31m [retour]\e[0;m                                                    |"
        echo "|_____________________________________________________________________________|"
        echo
        read -p "$USER > " choice

        if [$choice = "re_install"]
        then
            rm -d -r /home/InstallerVps/
            rm IsReady.txt
            home
        elif [$choice = "start_panel"]
        then
            pm2 start IV_panel
            home 
        elif [$choice = "stop_panel"]
        then
            pm2 stop IV_panel
            home 
        else
            echo "Stop Process"
        fi
    else
        message "Bienvenue dans l'Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "En cours de préparation !"
        read -p "$USER > Veuillez selectionné votre OS [debian/ubuntu] : " os

        if [ $os = "debian" ]
        then
            debian
        elif [ $os = "ubuntu" ]
        then
            ubuntu
        else
            home
        fi  
    fi
}

home
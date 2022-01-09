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

debian() {
    message "VPS : Debian | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Mise à jour de votre système !"
    apt update
    apt upgrade -y
    apt full-upgrade -y
    apt auto-remove
    message "VPS : Debian | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Mise à jour effectuer, Installation des dépendances BASIC !"
    apt install screen htop nano
    message "VPS : Debian | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Installation des dépendances BASIC effectuer, Création de l'environnement pour le programme !"
    mkdir /home/InstallerVps/
    cd /home/InstallerVps/
    heure = $ (date + %H:%M)
    jour = $ (date + %d/%m/%Y)
    echo "$jour | $heure : Environnement en cours d'installation !" >> logs.txt
    mkdir IV_dataSave
    echo "$jour | $heure : Dossier [IV_dataSave] créer par le programme ($USER)!" >> logs.txt
    mkdir IV_tempData
    echo "$jour | $heure : Dossier [IV_tempData] créer par le programme ($USER)!" >> logs.txt
}

ubuntu() {
    message "VPS : Ubuntu | Installateur de VPS par \e[34mDevNetwork#2103\e[39m", "Mise à jour de votre système !",
    sudo apt update
    sudo apt upgrade -y
    sudo apt auto-remove
}

home() {
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
}

home
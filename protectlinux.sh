#!/bin/bash
# AUTHOR: Airgold3 & https://github.com/Airgold3
# This file is part of ProtectLinux
# Copyright (C) 2024, Airgold3
#    ProtectLinux ( is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#    Automatic Fivem Server Creator ( is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#    You should have received a copy of the GNU General Public License
#    along with Automatic Fivem Server Creator.  If not, see <https://www.gnu.org/licenses/>.


    # COLORS
    Color_Off='\033[0m'       # Text Reset

    # Regular Colors
    Red='\033[0;31m'          # Red
    Green='\033[0;32m'        # Green
    Yellow='\033[0;33m'       # Yellow
    Purple='\033[0;35m'       # Purple
    Cyan='\033[0;36m'         # Cyan
   
    if [ $(id -u) = 0 ]; then
        echo -e "$Yellow

        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,''''''''''''''''''
        ;;;;;;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,'''''''''''''''''''''''
        ;;;;;;;;;;;;;;;;;;;,,,,,,,,,,,,,,,,,,,,,,,,,,,,'''''''''''''''''''''''''''..
        ;;;;;;;;;;;;;,,,.....,,,,,,,,,,,,,,,,,,,,''''''''''''''''''''''''''''.......
        ;;;;;;;,,,,,,,,       .,,,,,,,,,,,,'''' cddddddc:ddddddo;kkkkkkx '..........
        ;,,,,,,,,,,,,,,.;  :;  ',,,,,,''''''''' cooooooc:ooooodo;ddddddd ...........
        ,,,,,,,,,,,,,,,';xxcd  .''''''''''''''' :ll::llllloc;dddlddo,ddo ...........
        ,,,,,,,,,,,,,,,.kOOkO   ''''''''''''''' cddccddddxko:kkkoxkx,kkx ...........
        ,,,,,,,,,,,,,. xNXXWMX   .''''''''''''' ;cccccl:;llllllc:ooc:cll ...........
        ,,,,,,,'''''. cWMMMMWXx   .'''''''..... cdddxkOocOOOOOkxcooOxood '..........
        ,''''''''''. lMMMMMMMMM0   .'.......... ;cl::lllcllc;looooxMMNkooc;.........
        ''''''''''. .MMMMMMMMMMM    ........... lkOclOOOOOOo:doxX0WMMMMkdoo.........
        '''''''''';o:xWMMMMMMMWX   .'.......... :ll::llccllc:ooWMMMMMMMMMdo.........
        ''''''',k0KKKd.cMMMMMMXOocd0l'......... lOOOOOOlcOOOkooXMMMMMMMMKoc.........
        '''''..,kKKKKKOlNMWXk:.O00000x'........ ;cccccc;,cccc:ookKNWWNKko:..........
        .......,clooxkx, .    .xOkl;'.........................,;:cccc:,.............
        ............................................................................
        ............................................................................    
        ............................................................................         
        ............................................................................                                                                                                                                                                            


        Protect Linux es un script para proteger 
        tu servidor de linux frente a posibles 
        ataques de hackers. 

        --------------------------------------------
        By Airgold3 & 
        https://github.com/Airgold3 $Color_Off";           
        
        apt update && apt upgrade -y;
        # Pedir el nombre de usuario
        read -p "Creación de un nuevo usuario digame como se quiere llamar: " username;

        # Comprobar si el usuario ya existe
        if id "$username" &>/dev/null; then
            echo "El usuario $username ya existe.";
            exit 1
        fi

        # Pedir la contraseña del usuario
        read -sp "Introduce la contraseña para el usuario $username: " password;
        echo

        # Crear el usuario con la contraseña
        sudo useradd -m -s /bin/bash -p "$(openssl passwd -1 "$password")" "$username";

        # Añadir el usuario al grupo sudo
        sudo usermod -aG sudo "$username";
        
        echo "Usuario $username creado correctamente y añadido al grupo sudo.";

        sed -i 's/#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

        echo -e  "$Cyan\n El puerto 22 es inseguro para SSH dime que número quieres para el puerto: $Color_Off";
        
        read port;

        sed -i "s/#Port 22/Port $port/" /etc/ssh/sshd_config;

        echo -e "$Cyan\n Se ha cambiado el puerto por defecto del 22 al $port $Color_Off";
        
        echo -e "$Cyan\n Descargando (UFW) y configurandolo... $Color_Off";
        sudo apt install ufw -y;
        sudo ufw allow $port/tcp;
        sudo ufw allow 3306; #Puerto MYSQL
        sudo ufw allow 80; #Puerto HTTP
        sudo ufw allow 443; #Puerto HTTPs
        echo "y" | sudo ufw enable

        echo -e "$Cyan Descargando fail2ban para evitar la fuerza bruta $Color_Off";
        apt install fail2ban -y;

        # Configurar fail2ban para un solo intento y baneo permanente en el puerto 22
        cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local;
        sed -i "s/bantime  = 10m/bantime  = -1/g" /etc/fail2ban/jail.local;
        sed -i "s/maxretry = 5/maxretry = 1/g" /etc/fail2ban/jail.local;

        # Instalando Endlessh(HoneyPot)
        echo -e "Instalando y configurando Endlessh como honeypot...";
        apt install endlessh -y;
        cp /etc/endlessh/endlessh.conf /etc/endlessh/endlessh.conf.backup;
        #sed -i "s/Port 22/Port $port/g" /etc/endlessh/endlessh.conf;

        # Reiniciar servicios
        systemctl restart fail2ban;
        systemctl restart endlessh;
        systemctl restart sshd;

        echo -e "Configuración de seguridad completada.";
    else
       echo -e "$Red\n [ERROR] ¡No soy root! Abre el archivo con  $Yellow'sudo' $Color_Off \n";
       exit 1;
    fi

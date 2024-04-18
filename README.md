## ProtectLinux
Es un script automatizado para proteger nuestro servidor de ubuntu frente a posibles ataques de fuerza bruta de ssh, cuenta con cortafuegos y bloqueo del login con root. <br><br>
<div align="center"><img src="https://firewallauthority.com/wp-content/uploads/2021/12/Open-Source-Firewalls-for-Linux.png"></div>
<br>

<div align="center">
<img src="https://img.shields.io/badge/OS-Ubuntu Server-orange?style=for-the-badge&logo=linux"> <img src="https://img.shields.io/badge/Autor-airgold3-blue?logo=github&style=for-the-badge"> <img src="https://img.shields.io/badge/Licencia-GPLV3-red?style=for-the-badge&logo=gnu"> 
</div>

## Características de Seguridad 🔒
 
 <ul>
  <li><a>FAIL2BAN (Anti Force Brute & Anti Port Entry SSH)</a></li>
  <li><a>UFW (Uncomplicated Firewall)</a></li>
  <li><a>No Permit Root Login</a></li>
  
 </ul>
 
## CÓMO UTILIZAR 📚
Primero debe conectarse a través de sftp o ftp y mover el archivo allí o hacerlo manualmente de la siguiente forma:
<br>
```
# Descargas git clone
$ sudo apt install git

# Comienzas a clonar mi repositorio
$ sudo git clone https://github.com/Airgold3/ProtectLinux/

# Le das permisos de ejecución ☄️
$ chmod +x protectlinux.sh

# ¡INíCIALO! 🚀 
$ sudo ./protectlinux.sh
```

## Licencia 📄
   El proyecto está bajo la Licencia (GPLv3) aquí puedes ver el archivo [LICENSE](LICENSE) para ver más detalles.

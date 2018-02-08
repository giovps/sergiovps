#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "VPS Manager 2.0.1" ; tput sgr0
tput setaf 3 ; tput bold ; echo "" ; echo "Este script ir�:" ; echo ""
echo "? Instalar y configurar el proxy squid en las puertos 80, 3128, 8080 e 8799" ; echo "  para permitir conexiones SSH a este servidor"
echo "? Configurar OpenSSH para ejecutarse en los puertos 22 e 443"
echo "? Instalar un conjunto de secuencias de comandos y comandos del sistema para la gesti�n de los usuarios" ; tput sgr0
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Pulse cualquier tecla para continuar ... " ; echo "" ; echo "" ; tput sgr0
tput setaf 2 ; tput bold ; echo "	Terminos de uso" ; tput sgr0
echo ""
echo "Mediante el uso de 'Administrador de VPS 2.0' est� de acuerdo con las siguientes condiciones de uso:"
echo ""
echo "1. Tu puedes:"
echo "a. Instalar y utilizar el 'VPS Manager 2.0' en el servidor ."
echo "b. Crear, administrar y eliminar un n�mero ilimitado de usuarios a trav�s de este conjunto de scripts."
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
echo "2. Tu no puedes:"
echo "a. Editar, modificar, compartir o redistribuir"
echo "este conjunto de secuencias de comandos sin autorizaci�n desarrollador."
echo "b. Modificar O editar el conjunto de script para hacer que se mira el programador de scripts."
echo ""
echo "3. El usuario acepta que:"
echo "a. El importe pagado por este conjunto de scripts no incluye garant�as o apoyo adicional,"
echo "pero el usuario puede, promocional y de forma no vinculante, por un tiempo limitado,"
echo "recibir apoyo y ayuda para la soluci�n de problemas, siempre que re�na las condiciones de uso."
echo "b. El usuario de este conjunto de scripts es el �nico responsable de cualquier tipo de implicaci�n"
echo "legal o �tica causada por el uso de este conjunto de secuencias de comandos para cualquier prop�sito."
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
echo "4. El usuario acepta que el promotor no se hace responsable de:"
echo "a. Los problemas causados por el uso de scripts no autorizados distribuidos."
echo "b. Los problemas causados por conflictos entre este conjunto de secuencias de comandos y scripts de desarrollador."
echo "c. Los problemas causados por problemas o modificaciones de c�digo script sin permiso."
echo "d. problemas del sistema causados por programas de terceros o cambios / pruebas con usuarios."
echo "e. Los problemas causados por los cambios en el sistema del servidor."
echo "f. problemas causados por el usuario no sigue las instrucciones del conjunto de documentaci�n de los scripts."
echo "g. problemas ocurrieron durante el uso de scripts para beneficio comercial."
echo "h. Los problemas que pueden ocurrir cuando se utiliza el conjunto de scripts en sistemas que no est�n en la lista de sistemas a prueba."
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
echo "5. Este script fue editado por GIO :"
echo "a. Dale buen uso ."
echo "b. Whatsapp."
echo "c. +51 932022440."
echo "d. +51 932022440."
echo "e. +51 932022440."
echo "f. +51 932022440."
echo "g. +51 932022440."
echo "h. +51 932022440."
echo "i. CONTACTAME PARA VENTAS DE VPS FULL."
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Presina Cualquier tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
IP=$(wget -qO- ipv4.icanhazip.com)
read -p "Para continuar confirme o IP de este servidor: " -e -i $IP ipdovps
if [ -z "$ipdovps" ]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "" ; echo " No ha introducido la direcci�n IP de este servidor. Int�ntalo de nuevo. " ; echo "" ; echo "" ; tput sgr0
	exit 1
fi
if [ -f "/root/usuarios.db" ]
then
tput setaf 6 ; tput bold ;	echo ""
	echo "Se encontr� una base de datos de usuario ('usuarios.db')!"
	echo "�Quieres mantenerlo (preservando el l�mite de conexiones simult�neas de los usuarios)"
	echo "o crear una nueva base de datos?"
	tput setaf 6 ; tput bold ;	echo ""
	echo "[1] Mantener la base de datos actual"
	echo "[2] Crear una nueva base de datos"
	echo "" ; tput sgr0
	read -p "Op��o?: " -e -i 1 optiondb
else
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
echo ""
read -p "�Quieres activar la compresi�n de SSH (puede aumentar el consumo de memoria RAM)? [s/n]) " -e -i n sshcompression
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Espere a que la configuraci�n autom�tica" ; echo "" ; tput sgr0
sleep 3
apt-get update -y
apt-get upgrade -y
rm /bin/criarusuario /bin/expcleaner /bin/sshlimiter /bin/addhost /bin/listar /bin/sshmonitor /bin/ajuda > /dev/null
rm /root/ExpCleaner.sh /root/CriarUsuario.sh /root/sshlimiter.sh > /dev/null
apt-get install squid3 bc screen nano unzip dos2unix wget -y
killall apache2
apt-get purge apache2 -y
if [ -f "/usr/sbin/ufw" ] ; then
	ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
if [ -d "/etc/squid3/" ]
then
	wget https://raw.githubusercontent.com/ringhtprince/VpsManager/master/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://raw.githubusercontent.com/ringhtprince/VpsManager/master/squid2.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid3/squid.conf
	wget https://raw.githubusercontent.com/ringhtprince/VpsManager/master/payload.txt -O /etc/squid3/payload.txt
	echo " " >> /etc/squid3/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget http://http://seannsvps.esy.es/vpsmanager/scripts/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget http://seannsvps.esy.es/vpsmanager/scripts/alterarcontrase?a.sh -O /bin/alterarcontrase?a
	chmod +x /bin/alterarcontrase?a
	wget http://seannsvps.esy.es/vpsmanager/scripts/socks.sh -O /bin/socked
	chmod +x /bin/socked
	wget http://seannsvps.esy.es/vpsmanager/scripts/shadowsocks.sh -O /bin/shadowsocks
	chmod +x /bin/shadowsocks
	wget http://seannsvps.esy.es/vpsmanager/scripts/crearusuario2.sh -O /bin/crearusuario
	chmod +x /bin/crearusuario
	wget http://seannsvps.esy.es/vpsmanager/scripts/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget http://seannsvps.esy.es/vpsmanager/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget http://seannsvps.esy.es/vpsmanager/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget http://seannsvps.esy.es/vpsmanager/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget http://seannsvps.esy.es/vpsmanager/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget http://seannsvps.esy.es/vpsmanager/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget http://seannsvps.esy.es/vpsmanager/scripts/ayuda.sh -O /bin/ayuda
	chmod +x /bin/ayuda
	wget http://seannsvps.esy.es/vpsmanager/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	if [ ! -f "/etc/init.d/squid3" ]
	then
		service squid3 reload > /dev/null
	else
		/etc/init.d/squid3 reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
fi
if [ -d "/etc/squid/" ]
then
	wget http://seannsvps.esy.es/vpsmanager/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget http://seannsvps.esy.es/vpsmanager/squid.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid/squid.conf
	wget http://seannsvps.esy.es/vpsmanager/payload.txt -O /etc/squid/payload.txt
	echo " " >> /etc/squid/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget http://seannsvps.esy.es/vpsmanager/scripts/2/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget http://seannsvps.esy.es/vpsmanager/scripts/alterarcontrase�a.sh -O /bin/alterarcontrase?a
	chmod +x /bin/alterarcontrase?a
	wget http://seannsvps.esy.es/vpsmanager/scripts/crearusuario2.sh -O /bin/crearusuario
	chmod +x /bin/crearusuario
	wget http://seannsvps.esy.es/vpsmanager/scripts/2/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget http://seannsvps.esy.es/vpsmanager/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget http://seannsvps.esy.es/vpsmanager/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget http://seannsvps.esy.es/vpsmanager/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget http://seannsvps.esy.es/vpsmanager/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget http://seannsvps.esy.es/vpsmanager/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget http://seannsvps.esy.es/vpsmanager/scripts/ayuda.sh -O /bin/ayuda
	chmod +x /bin/ayuda
	wget http://seannsvps.esy.es/vpsmanager/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
	if [ ! -f "/etc/init.d/squid" ]
	then
		service squid restart > /dev/null
	else
		/etc/init.d/squid restart > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh restart > /dev/null
	else
		/etc/init.d/ssh restart > /dev/null
	fi
fi
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Proxy squid instalado y en ejecuci�n en los puertos: 80, 3128, 8080 y 8799" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "OpenSSH se ejecuta en los puertos 22 y 443" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "scripts para la gesti�n de usuarios instalados" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Lea la documentaci�n para evitar preguntas y problemas!" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Para ver los comandos disponibles, usar el comando: ayuda" ; tput sgr0
echo ""
if [[ "$optiondb" = '2' ]]; then
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
if [[ "$sshcompression" = 's' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
	echo "Compression yes" >> /etc/ssh/sshd_config
fi
if [[ "$sshcompression" = 'n' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
fi
exit 1
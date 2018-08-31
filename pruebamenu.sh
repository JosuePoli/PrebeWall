#!/bin/bash

#Creacion de nuestras listas blanca y negra donde pondremos el nombre de las usb's
if [ -d /mnt/blanca.txt/ ]; then
        RELLENO=1
else
    	touch /mnt/blanca.txt
fi

if [ -d /mnt/negra.txt/ ]; then
        RELLENO=1
else
    	touch /mnt/negra.txt
fi
CONTROL=0
while [ $CONTROL=0 ] ; do

	#Declaracion de la varible USB
	cat /etc/mtab | grep media >> /dev/null
        if [ $? -ne 0 ]; then
                RELLENO=0
		CONTROL=0
	#Verificamos si el dispositivo ya se encuentra en la lista Blanca para que proceda a montarse y ejecutarse
	else
		CONTROL=1
                id=$( blkid | grep sd[^a] | grep UUID  | cut -d "=" -f 3 | sed -e 's/TYPE//g' | sed -e 's/"//g' )
                direc=$( blkid | grep sd[^a] | cut -c 1-9 )
                if [ $( grep -c $id /mnt/negra.txt ) -ne 0 ]; then
                        umount $direc
                        rm -f $direc
                        echo esta memoria esta en blacklist, se bloqueara su acceso
                else
			if [ $( grep -c $id /mnt/blanca.txt ) -ne 0 ]; then
				CONTROL=0

			else
        			#Si es un nuevo dispositivo se despliega el menu, con las siguientes opciones
                		RELLENO=1


				echo "Se a conectado una USB"
				echo "Montar un dispositvo puede significar un riesgo lógico y humano"; echo $!
        			echo -e	"1)Montar y Ejecutar \n"
				echo -e	"2)Añadir a la lista Blanca \n"
				echo -e	"3)Añadir a la lista Negra \n"

				echo "elegir una opcion)"
				read eleccion
				case $eleccion in
					1)	echo $id >> /mnt/blanca.txt
						ruta="/run/media/$USER/$ip"
						mount $direc $ruta
						;;

					2)	umount $direc
                        			rm -f $direc
                        			echo esta memoria esta en blacklist, se bloqueara su acceso cada vez que se inseerte
						;;

				esac
			fi
		fi
	fi
done
exit 0

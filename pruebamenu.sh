#Creacion de nuestras listas blanca y negra donde pondremos el nombre de las usb's
if [ -d /mnt/blanca.txt/ ]; then
        echo "BIENVENIDO"
else
    	touch /mnt/blanca.txt
fi

if [ -d /mnt/negra.txt/ ]; then
        echo "PREBEWALL"
else
    	touch /mnt/negra.txt
fi

while [ 1=1 ] ; do

        #Declaracion de la varible USB
        cat /etc/mtab | grep media >> /dev/null
        if [ $? -ne 0 ]; then
                RELLENO=0
        #Verificamos si el dispositivo ya se encuentra en la lista Blanca para que proceda a montarse y ejecutarse
        else
            	prueba=$( cat /mnt/blanca.txt )
                id=$( blkid | grep sd[^a] | grep UUID  | cut -d "=" -f 3 | sed -e 's/TYPE//g' | sed -e 's/"//g' )
                direc=$( blkid | grep sd[^a] | cut -c 1-9 )
                if [ $( grep -c $id /mnt/negra.txt ) -ne 0 ]; then
                        umount $direc
                        rm -f $direc
                        echo esta memoria esta en blacklist, se bloqueara su acceso


while [ $CONTROL=0 ] ; do
        #Creacion de nuestras listas blanca y negra donde pondremos el nombre de las usb's
        touch blanca.txt | touch negra.txt
        cat /etc/mtab | grep media >> /dev/null
	#Declaracion de la varible USB

        if [ $? -ne 0 ]; then
                CONTROL=0
	#Verificamos si el dispositivo ya se encuentra en la lista Blanca para que proceda a montarse y ejecutarse
	else if [ $(grep -c $USB blanca.txt) -ne 0 ]; then
		CONTROL=1
        	"El dispositivo: $USB , se encuentra en la lista blanca, procedera a montarse"
        	mount /mnt/
            	sudo eject /etc/mtab
		exit 0
        #Si es un nuevo dispositivo se despliega el menu, con las siguientes opciones
	else
                CONTROL=1


		echo "Se a conectado: $USB"
		echo "Montar un dispositvo puede significar un riesgo lógico y humano"; echo $!
                echo 	"1)Montar y Ejecutar \n"
		echo	"2)Añadir a la lista Blanca \n"
		echo	"3)Añadir a la lista Negra \n"

		echo	"elegir una opcion")
                #read opcion
                	case $eleccion in

	1) echo $id >> /mnt/blanca.txt
			mount /mnt/blanca.txt
                        sudo eject /dev/sdc1
			CONTROL=1
			echo "El dispositivo se encuentra en la lista blanca"
			exit 0;;

	2) echo $USB >> blanca.txt
			CONTROL=1
			echo "El sipositivo se encuetra en la lista blanca"
			exit 0;;

	3) echo $USB >> Negra.txt
			CONTROL=1
			echo "El dispositivo se encuentra en la lista negra"
			exit 0;;

	4) echo $USB >> Negra.txt
			umount /mnt/negra.txt
			echo "El dispositivo se encuentra en la lista negra"
			exit 0;;

	*) echo "opcion invalida";;
			esac
		break;
		fi
	done
exit 0


asdfasdfas

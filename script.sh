# Script para recoleccion de datos volatil en Android
# Geovanny Andrés González - 201719528
# Luis Gomez Amado - 201719960
# Computación Forense
# Departamento de Ingenieria de Sistemas y Computación - Facultad de Ingenieria
# Universidad de los Andes - Bogotá Colombia

out=$HOME/evidencia
SOfile=data.txt
mkdir $out
cd $out
touch $SOfile
line="================================================"

echo "Recolección de evidencia digital sistema" >> $SOfile
echo $line >> $SOfile
echo "Dispositivos conectados"
adb devices >> $SOfile
echo $line >> $SOfile
echo "Servicios del sistema" >> $SOfile
adb shell service list >> $SOfile
echo $line >> $SOfile
echo "IMEI del dispositivo" >> $SOfile
adb shell service call iphonesubinfo 1| cut -d "'" -f2| grep -Eo '[0-9]'| xargs| sed 's/\ //g' >> $SOfile
echo $line >> $SOfile
echo "Paquetes instalados" >> $SOfile
adb shell pm list packages >> $SOfile
echo $line >> $SOfile
echo "Paquetes instalados deshabilitados" >> $SOfile
adb shell pm list packages -d >> $SOfile
echo $line >> $SOfile
echo "Paquetes instalados habilitados" >> $SOfile
adb shell pm list packages -e >> $SOfile
echo $line >> $SOfile
echo "Paquetes instalados de terceros" >> $SOfile
adb shell pm list packages -e >> $SOfile
echo $line >> $SOfile
echo "Caracterisiticas de hardware del telefono" >> $SOfile
adb shell pm list features >> $SOfile
echo $line >> $SOfile
echo "Interfaces de Red" >> $SOfile
adb shell netcfg >> $SOfile
echo $line >> $SOfile
echo "Conexiones activas" >> $SOfile
adb shell netstat >> $SOfile
echo $line >> $SOfile
echo "Localización" >> $SOfile
adb shell settings put secure location_providers_allowed gps,wifi,network
adb shell dumpsys location >> $SOfile
echo $line >> $SOfile
echo "Registro Dumpsys" >> $SOfile
adb shell dumpsys >> $SOfile
echo $line >> $SOfile
echo "Contactos" >> $SOfile
adb shell content query --uri content://com.android.contacts/data --projection display_name:data1:data4:contact_id >> $SOfile
echo $line >> $SOfile
echo "Obtener fotos"
adb pull /sdcard/DCIM/ $out
echo "Captura de evidencia completada"



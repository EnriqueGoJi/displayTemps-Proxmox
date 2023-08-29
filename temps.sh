#!/bin/bash
#Enrique Gómez quique2010botoa@hotmail.com

#Descargo de responsabilidad, utiliza este codigo bajo tu propia responsabilidad

#Siguiente revision añadir comprobacion de lineas existentes en los ficheros

nodes=/usr/share/perl5/PVE/API2/Nodes.pm
pvemanager=/usr/share/pve-manager/js/pvemanagerlib.js
checkNode=$(grep -n temps $nodes >> /dev/null)
checkPveManager=$(grep -n thermal $pvemanager >> /dev/null)

function filesBackup(){
   if [ -f $nodes.original ]; then
      echo "El fichero de backup ya existe"
   else
      cp $nodes $nodes.backup
      echo "Se ha creado una copia .original a modo de backup"
   fi
   if [ -f $pvemanager.original ]; then
      echo "El fichero de backup ya existe"
   else
      cp $pvemanager $pvemanager.backup
      echo "Se ha creado una copia .original a modo de backup"
   fi
}

function displayOptions(){
   clear
   echo 
   echo "--------- Elija la operacion que quiere realizar: ---------"
   echo 
   echo "1 - Temperatura media de todos los cores"
   echo

   read -p "Indique que opcion quiere elegir: " option
   clear
}

function addSensor(){
   sensors
   echo -e "Observa el nombre del sensor que quieres mostrar en el Summary.(Composite, Sensor 1....)"
   read -p "Pon el nombre tal y como aparezca: " sensorName
}

function selectOperation(){
   grep -n thermal $pvemanager >> /dev/null

   if [ $? -eq 0 ]; then
      echo "Ya existe esta configuracion en el fichero"
   else
      line=$(grep -n pveversion $pvemanager | cut -d ':' -f 1)
      sumLine=$(($line+2))
      echo "El sensor elegido es: " $sensorName

      case $option in
         1) sed ''$sumLine' a \\r\n        {\n            itemId: "thermalstate",\n            colspan: 2,\n            printBar: false,\n            title: gettext("CPU Temps"),\n            textField: "temps",\n            renderer:function(value){\n                const c0 = value.match(/'$sensorName'.*?\\+([\\d\\.]+)Â/)[1];\n                return `CPU: ${c0} ºC`\n            }\n        },' -i $pvemanager
         ;;
         *) echo "fallo"
         ;;
      esac
   fi
}

function infoAdd(){
   grep -n temps $nodes >> /dev/null
   if [ $? -eq 0 ]; then
      echo "Ya existe esta configuracion en el fichero"
   else
      line2=$(grep -n pveversion $nodes | cut -d ':' -f 1)
      sumLine2=$(($line2+1))
      sed ''$sumLine2' a \\n        $res->{temps} = `sensors`;' -i $nodes
   fi
}

clear
echo -e "Instala lm-sensors si no lo tienes (Pulsa enter para continuar)"
read -p ""

filesBackup
displayOptions
addSensor
selectOperation
infoAdd

echo 
echo "Recarga la pagina para reiniciar el servicio"
systemctl restart pveproxy.service
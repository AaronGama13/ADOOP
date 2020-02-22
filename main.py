# -*- coding: utf-8 -*-
# AUTORES: García Medina Saúl, Palacios Lugo Alan Yoltic,
#		   Sánchez Castro Aarón Gamaliel.
# DESCRIPCIÓN
# FECHA: 14/02/2020. Todos los derechos reservados

#Ésta librería nos permite revisar las excepciones que se presenten
import sys
#Ésta librería nos permite listar los archivos contenidos en un dir.
from os import listdir 
#Ésta librería permite verificar si una ruta no es un directorio
from os.path import isfile, join
from analyzer import Analyzer

print("Bienvenido al analizador de archivos")
path = input("Ingresa la ruta a la carpeta contenedora de archivos:\n>")
#Creando un arreglo de puros archivos, la función isfile verifica que ruta+nombre es un archivo
files = [file for file in listdir(path) if isfile(join(path,file))]  
#Creando un objeto de la clase Analyzer
myAnalizer = Analyzer(path,files[0][:files[0].find('.')])

for file in files:
	try:
		print("In file "+file+" WCM="+str(myAnalizer.wmc(file)))
		print("In file "+file+" DIT="+str(myAnalizer.dit(file,0)))
		myAnalizer.noc(file)	
	except UnicodeDecodeError:
		print("Unexpected error decoding "+file+"")
		continue
print("NOC:")
print(myAnalizer.nocs)
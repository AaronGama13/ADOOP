# -*- coding: utf-8 -*-

from os import listdir #Ésta librería nos permite listar los archivos contenidos en un dir.
from os.path import isfile, join
from collections import Counter

#Variables
keyWords = ["if","while","for","do while"]
fileContent = 0
count = 0

print("Bienvenido al analizador de archivos")
path = input("Ingresa la ruta a la carpeta contenedora de archivos:\n>")
#Creando un arreglo de puros archivos, la función isfile verifica que ruta+nombre es un archivo
files = [file for file in listdir(path) if isfile(join(path,file))]  
for file in files:
	try:
		fileContent = open(join(path,file),"r").read()
	except Exception:
		print("Error")
		continue
	for word in keyWords:
		count = count + fileContent.count(word)
	print("In file "+file+" WMC="+str(count))
	count = 0
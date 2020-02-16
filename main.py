# -*- coding: utf-8 -*-

from os import listdir #Ésta librería nos permite listar los archivos contenidos en un dir.
from os.path import isfile, join
from collections import Counter

#Variables
keyWords = ["if","while","for","do while"]
fileContent = 0
auxFile = 0
path = 0
files = []

#Funciones
#DIP (list,int,string)
#file es una lista resultado de hacer split al contenido del archivo
#depth es un contador de la altura del árbol
#fileExt es la extensión del archivo para abrir el siguiente
def DIP(file,depth,fileExt): 
	#¿El arreglo contiene la palabra extends?
	if 'extends' in file: #Si
		depth = depth + 1 #Aumentamos el contador 
		#Obtenemos el nombre del siguiente archivo
		#join(path,file.find('extends')+1,fileExt)
		auxFile = open(join(path,file[file.index('extends')+1],fileExt),"r").read()
		#auxFile es el contenido del siguiente archivo
		return DIP(auxFile.split(),depth,fileExt)
	else:
		return depth

#WMC(string)
#file es un String con todo el contenido del archivo
def WMC(file): 
	counter = 0 
	for word in keyWords: #Verificamos que el archivo contenga las palabras almacenadas en keywords
		counter = counter + file.count(word)
	return counter

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
	#print("In file "+file+" WMC="+str(WMC(fileContent)))
	try:
		print("In file "+file+" DIP="+str(DIP(fileContent.split(),0,file[file.find('.'):])))
	except FileNotFoundError:
		print("El archivo "+file+" extiende de una clase ubicada en una libreria")
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
#file es un archivo (el archivo raíz)
#depth es un contador de la altura del árbol
#files es una lista de todos los archivos
def DIP(file,depth,files): 
	#Vamos a comparar con todos los demás archivos para ver si alguno extiende de file
	for f in files:
		auxFile = open(join(path,f),"r").read() #Contenido del archivo f
		if ('extends '+file) in auxFile: #Si el auxFile extiende de file (archivo raíz)
			depth = depth + 1
			return DIP(f,depth,files)
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
	try:
		#print("In file "+file+" WMC="+str(WMC(fileContent)))
		print("In file "+file+" DIP="+str(DIP(file,0,files)))
	except FileNotFoundError:
		print("El archivo "+file+" extiende de una clase ubicada en una libreria")
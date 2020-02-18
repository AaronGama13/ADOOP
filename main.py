# -*- coding: utf-8 -*-

from os import listdir #Ésta librería nos permite listar los archivos contenidos en un dir.
from os.path import isfile, join
from collections import Counter
from nodo import Nodo
from arboln import Arboln

#Variables
keyWords = ["if","while","for","switch,"]
fileContent = 0
auxFile = 0
path = 0
files = []


#Funciones
def DIP(file,height):
	if os.path.exists(join(path,file)): #Si el archivo existe en la carpeta indicada
		file = open(file,"r").read() #Leemos el contenido del archivo
		parents = [] #Todos los padres aquí jiji
		length = 0
		auxFile = open(join(path,file),"r").read() #Contenido del archivo
		for x in file[file.find('extends'):file.find('{')].split():
			if x != 'extends' and x != 'implements' and x != ',':
			parents.append(x) #Si la cadena es una clase entonces agregala
		for p in parents:
			return height + DIP(p,length)
	else:
		return height


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
	except FileNotFoundError:
		print("El archivo "+file+" extiende de una clase ubicada en una libreria")
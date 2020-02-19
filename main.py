# -*- coding: utf-8 -*-
import sys # ello syster
from os import listdir #Ésta librería nos permite listar los archivos contenidos en un dir.
from os.path import isfile, join, exists

#Variables
keyWords = ["if","while","for","switch,"]
fileContent = 0
auxFile = 0
path = 0
files = []

#Funciones
def NOC(file):
	auxFile = open(join(path,file),"r").read() #Leemos el contenido del archivo
	for x in auxFile[auxFile.find('extends'):auxFile.find('{')].split():
		if x != 'extends' and x != 'implements' and x != ',':
			if x not in nocs.keys():
				nocs[x] = 1
			else:
				nocs[x] = nocs.get(x) + 1
		

def DIP(file,height):
	if exists(join(path,file)): #Si el archivo existe en la carpeta indicada
		auxFile = open(join(path,file),"r").read() #Leemos el contenido del archivo
		parents = [] #Todos los padres aquí jiji
		for x in auxFile[auxFile.find('extends'):auxFile.find('{')].split():
			if x != 'extends' and x != 'implements' and x != ',':
				parents.append(x+file[file.find('.'):]) #Si la cadena es una clase entonces agregala
		for p in parents:
			return DIP(p,height+1)
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
nocs = dict.fromkeys([files[0]],0)
for file in files:
	try:
		fileContent = open(join(path,file),"r").read()
	except Exception:
		print("Error")
		continue
	try:
		#print("In file "+file+" WMC="+str(WMC(fileContent)))
		#print("In file "+file+" DIP="+str(DIP(file,0)))
		NOC(file)
	except Exception as Err:
		print(Err)
print(nocs)
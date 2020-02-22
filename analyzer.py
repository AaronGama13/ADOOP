# -*- coding: utf-8 -*-
# AUTORES: García Medina Saúl, Palacios Lugo Alan Yoltic,
#		   Sánchez Castro Aarón Gamaliel.
# DESCRIPCIÓN
# FECHA: 14/02/2020. Todos los derechos reservados

from os.path import join, exists

class Analyzer:

	#Palabras a ubicar en un archivo para el método MWC
	keyWords = ["if","while","for","switch,"]
	#Ruta a la carpeta que contiene todos los archivos a analizar
	path = None
	#Diccionario que contiene todas las clases con su número de hijos
	nocs = None

	#Constructor de la clase Analyzer, no requiere parámetros para inicialización
	def __init__(self,pathFolder,firstFile):
		self.path = pathFolder
		print(firstFile)
		self.nocs = dict.fromkeys([firstFile],0)

	#WMC (Weighted Method per Class)
	#Ésta función recibe un archivo (file) lo convierte en cadena y busca 
	#coincidencias con cada palabra reservada ubicada en el arreglo keyWords
	def wmc(self,file): 
		counter = 0
		auxFile = open(join(self.path,file),"r").read()
		for word in self.keyWords: #Verificamos que el archivo contenga las palabras almacenadas en keywords
			counter = counter + auxFile.count(word)
		return counter

	#DIT (Depth Inheritance Tree)
	#Ésta función realiza un conteo recursivo por cada archivo recibido (file)
	#retorna la altura más alta alcanzada por el árbol de ascendencia
	def dit(self,file,height):
		if exists(join(self.path,file)): #Si el archivo existe en la carpeta indicada
			auxFile = open(join(self.path,file),"r").read() #Leemos el contenido del archivo
			parents = [] #Todos los padres aquí jiji
			for x in auxFile[auxFile.find('class'):auxFile.find('{')].split():
				if x != 'extends' and x != 'implements' and x != ',' and x != 'class':
					parents.append(x+file[file.find('.'):]) #Si la cadena es una clase entonces agregala
			if len(parents)==0:
				for p in parents:
					return self.dit(p,height+1)
			else:
				return height
		else:
			return height

	#NOC (Number Of Children)
	def noc(self,file):
		auxFile = open(join(self.path,file),"r").read() #Leemos el contenido del archivo
		for x in auxFile[auxFile.find('extends'):auxFile.find('{')].split():
			if x != 'extends' and x != 'implements' and x != ',':
				if x not in self.nocs.keys():
					self.nocs[x] = 1
				else:
					self.nocs[x] = self.nocs.get(x) + 1
## FILOGENIA MOLECULAR DE LA FAMILIA RANIDAE USANDO MULTIPLES GENES NUCLEARES

## Autor
* Madison Cando

## Propósito del proyecto
* Este proyecto tiene como objetivo reconstruir la filogenia de la familia *Ranidae* utilizando cuatro genes nucleares ampliamente utilizados en estudios evolutivos: **RAG1**, **BDNF**, **POMC** y **TRPV4**. La información filogenética se generará a partir de árboles individuales por gen y se integrará en un árbol de especies utilizando el enfoque de coalescencia con **ASTRAL**.

## Objetivo
* Identificar el ancestro común en la familia *Ranidae* que comparta los cuatro genes específicos mencionados, observar las variantes genéticas desde el ancestro común y su diversificación, la filogenia permitirá entender las relaciones evolutivas entre diferentes grupos de la familia *Ranidae*, además de identificar que genes se han mantenido través del tiempo evolutivo.

## Genes utilizados
* RAG1 (Recombination Activating Gene 1)
* BDNF (Brain-Derived Neurotrophic Factor)
* POMC (Pro-opiomelanocortina)
* TRPV4 (Transient Receptor Potential Vanilloid 4)

## Herramientas utilizadas
* datasets (NCBI CLI): descarga de secuencias genéticas por símbolo
* muscle3.8.31_i86linux64: alineamiento de secuencias por gen
* iqtree/2.2.2.6: inferencia filogenética por gen
* astral.5.7.8.jar: inferencia del árbol de especies
* Atom: edición de scripts y archivos
* FigTree: visualización y edición gráfica de árboles filogenéticos

## Procedimeinto de trabajo

# 1. Descargar genes con NCBI datasets en Git bash
* ./datasets download gene symbol RAG1 BDNF POMC TRPV4 --species "Ranidae" --reference
* Descomprimir los archivps con unzip
* mover los cuatro rna.fna. a una sola carpeta

# 2. Preparación de las secuencias (edición manual previa al alineamiento)
* Descargar la carpeta con los rna.fna. al computador personal del comando datasets
* Abrir cada archivo en Atom y editar para dejar el nombre de la especie
* Editar cada línea de encabezado (>) para que contenga solo el nombre de la especie
- w+/letras
- d+/numeros
- s/espacios
- ./signos 

# 3. Alineamiento con MUSCLE
* ./muscle3.8.31_i86linux64
- for filename in *.fna
- do muscle3.8.31_i86linux64 -in $filename -out muscle_$filename -maxiters 1 -diags
- done 

# 4. Inferencia filogenética con IQ-TREE
* module load iqtree/2.2.2.6
- for filename in muscle_*
- do iqtree2 -s $filename
- done
* crear un archivo con los arboles cat *.treefile > All.trees

# 5. Árbol de especies con ASTRAL
* java -jar astral.5.7.8.jar 
- java -jar astral -i All.trees -o Astral.Ranidae.tree

# 6. Visualización con FigTree
* Abrir los archivos .treefile con FigTree para inspección.

## Requisitos del sistema

* Unix/Linux
* Java (para ASTRAL)
* Acceso a terminal con bash
* Conexión a internet para descarga de datos

## Citaciones

* NCBI Genome Database. https://www.ncbi.nlm.nih.gov/genome/
* Edgar, R.C. (2004). MUSCLE: multiple sequence alignment with high accuracy. Nucleic Acids Res.
* Minh, B.Q., et al. (2020). IQ-TREE 2. Molecular Biology and Evolution.
* hang, C., et al. (2018). ASTRAL-III: polynomial time species tree reconstruction. Systematic Biology.

## Fotos del organismo
![ ](https://inaturalist-open-data.s3.amazonaws.com/photos/17781494/medium.jpeg)
![ ](https://inaturalist-open-data.s3.amazonaws.com/photos/5997078/medium.jpg)

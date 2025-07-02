## Script de filogenia

## Procedimeinto de trabajo

## 1. Descargar genes con NCBI datasets en hoffman 
* Usar el comando en hoffman 

* MastBio/edirect/esearch -db nuccore -query "rag1[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 100 | efetch -db nuccore -format fasta > rag1_Ranidae.fasta
* MastBio/edirect/esearch -db nuccore -query "cytb[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 100 | efetch -db nuccore -format fasta > cytb_Ranidae.fasta
* MastBio/edirect/esearch -db nuccore -query "pomc[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 100 | efetch -db nuccore -format fasta > pomc_Ranidae.fasta
* mover los archivos fasta a una sola nueva carpeta
* en la carpeta agregar el programa *./muscle3.8.31_i86linux64*

## 2. Preparación de las secuencias (edición manual previa al alineamiento)
* Descargar la carpeta con los archivos `.fasta` desde hoffman al computador personal
* Abrir cada archivo en Atom y editar para dejar la línea de encabezado (>) junto con el ID, nombre de la especies y Gen
- w+/letras
- d+/numeros
- s/espacios
- ./signos
* Una vez editado las secuencias en Atom, mover el documento con los archivos `.fasta` a hoffman

## 3. Alineamiento con MUSCLE
* usar el progrema *./muscle3.8.31_i86linux64* con:
- for filename in *.fasta
- do muscle3.8.31_i86linux64 -in $filename -out muscle_$filename -maxiters 1 -diags
- done

## 4. Inferencia filogenética con IQ-TREE
* usar module load iqtree/2.2.2.6
- for filename in muscle_*
- do iqtree2 -s $filename
- done
* crear un archivo con los arboles usando cat *.treefile > All.trees

## 5. Árbol de especies con ASTRAL
* usar el programa java -jar astral.5.7.8.jar
- java -jar astral -i All.trees -o Astral.Ranidae.tree

## 6. Visualización con FigTree
* bajar el archivo `Astral.Ranidae.tree` desde hoffman al computador personal 
* Abrir el archivo `Astral.Ranidae.tree` con FigTree para inspección.

## Herramientas utilizadas
* datasets (NCBI CLI): descarga de secuencias genéticas por símbolo
* muscle3.8.31_i86linux64: alineamiento de secuencias por gen
* iqtree/2.2.2.6: inferencia filogenética por gen
* astral.5.7.8.jar: inferencia del árbol de especies
* Atom: edición de scripts y archivos
* FigTree: visualización y edición gráfica de árboles filogenéticos

## Requisitos del sistema

* Unix/Linux
* Java (para ASTRAL)
* Acceso a terminal con bash
* Conexión a internet para descarga de datos

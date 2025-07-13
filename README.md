## FILOGENIA MOLECULAR DE LA FAMILIA RANIDAE USANDO MULTIPLES GENES NUCLEARES

## Autor
* Madison Cando

## Propósito del proyecto
* Este proyecto tiene como objetivo construir la filogenia de la familia *Ranidae* utilizando tres genes ampliamente utilizados en estudios evolutivos: **RAG1**, **POMC** y **CYTB**. La información filogenética se generará a partir de árboles individuales por gen y se integrará en un árbol de especies utilizando el enfoque de coalescencia con **ASTRAL**.

## Objetivo
* Identificar el ancestro común en la familia *Ranidae* que comparta los tres genes específicos mencionados, observar las variantes genéticas desde el ancestro común y su diversificación, la filogenia permitirá entender las relaciones evolutivas entre diferentes grupos de la familia *Ranidae*, además de identificar que genes se han mantenido través del tiempo evolutivo.

## Genes utilizados
* RAG1 (Recombination Activating Gene 1)
* CYBT (Citocromo b)
* POMC (Pro-opiomelanocortina)

## Herramientas utilizadas
* datasets (NCBI CLI): descarga de secuencias genéticas por símbolo
* muscle3.8.31_i86linux64: alineamiento de secuencias por gen
* iqtree/2.2.2.6: inferencia filogenética por gen
* FigTree: visualización y edición gráfica de árboles filogenéticos

## Procedimeinto de trabajo

## 1. Descargar genes con NCBI datasets en hoffman
* /u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "rag1[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 70 | efetch -db nuccore -format fasta > rag1_Ranidae.fasta
* /u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "cytb[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 70 | efetch -db nuccore -format fasta > cytb_Ranidae.fasta
* /u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "pomc[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 70 | efetch -db nuccore -format fasta > pomc_Ranidae.fasta
* mover los archivos fasta a una sola carpeta

# 2. Preparación de las secuencias (edición en hoffman del alineamiento)
* Copiar muscle3.8.31_i86linux64 a la carpeta
* perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' cytb_Ranidae.fasta > Ranidae.cytb.fasta
* perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' rag1_Ranidae.fasta > Ranidae.rag1.fasta
* perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' pomc_Ranidae.fasta > Ranidae.pomc.fasta

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

## 5. Combinar árboles
cat *.treefile > Ranidae.All.trees

## Final
## Filogenia completada

## Descarga Ranidae.All.trees desde Hoffman a tu computador personal
* scp dechavez@hoffman2.idre.ucla.edu:/u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/MadisonCa/ProyectoF/Secuencias_muscle/

## Abrirlo con FigTree para inspección

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

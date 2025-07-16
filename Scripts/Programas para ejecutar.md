# Programas
## Herramientas utilizadas
* datasets (NCBI CLI): descarga de secuencias genéticas por símbolo
* muscle3.8.31_i86linux64: alineamiento de secuencias por gen
* iqtree/2.2.2.6: inferencia filogenética por gen
* astral.5.7.8.jar: construir filogenia apartir de multiples arboles genicos
* FigTree: visualización y edición gráfica de árboles filogenéticos

## Proceso
* cd /u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/MadisonCa/ProyectoF
* mkdir -p Secuencias_muscle
* cd Secuencias_muscle

## Descargar genes con edirect
* /u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "rag1[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 30 | efetch -db nuccore -format fasta > rag1_Ranidae.fasta
* /u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "cytb[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 30 | efetch -db nuccore -format fasta > cytb_Ranidae.fasta
* /u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "pomc[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 30 | efetch -db nuccore -format fasta > pomc_Ranidae.fasta

## Organizar carpeta con MUSCLE

## Crear carpeta nueva para mantener orden
* cp ../../muscle3.8.31_i86linux64 .
* perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3_cytb/g' cytb_Ranidae.fasta > Ranidae.cytb.fasta
* perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3_rag1/g' rag1_Ranidae.fasta > Ranidae.rag1.fasta
* perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3_pomc/g' pomc_Ranidae.fasta > Ranidae.pomc.fasta

## Alineamiento con MUSCLE
* for filename in *.fasta
* do ./muscle3.8.31_i86linux64 -in $filename -out muscle_$filename -maxiters 1 -diags
* done

## Inferencia con IQ-TREE
* module load iqtree/2.2.2.6
* for filename in muscle_*.fasta
* do iqtree2 -s $filename
* done

## Combinar árboles
* cat *.treefile > Ranidae.All.trees

## Convertir a Astral
* astral=/u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/OneHundred.Genes.Canids/Astral/astral.5.7.8.jar
* java -jar $astral -i All.trees -o Astral.Ranidae.tree

## Descarga Astral.Ranidae.trees desde Hoffman a tu computador personal
* scp dechavez@hoffman2.idre.ucla.edu:/u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/MadisonCa/ProyectoF/Secuencias_muscle/Astral.Ranidae.trees .

## Abrirlo con FigTree para inspección
* Modificar el tamaño de las ramas y etiquetas para mejor observacion 

## Herramientas utilizadas
* datasets (NCBI CLI): descarga de secuencias genéticas por símbolo
* muscle3.8.31_i86linux64: alineamiento de secuencias por gen
* iqtree/2.2.2.6: inferencia filogenética por gen
* astral.5.7.8.jar: construir filogenia apartir de multiples arboles genicos
* FigTree: visualización y edición gráfica de árboles filogenéticos

## Requisitos del sistema
* Unix/Linux
* Acceso a terminal con bash
* Conexión a internet para descarga de datos

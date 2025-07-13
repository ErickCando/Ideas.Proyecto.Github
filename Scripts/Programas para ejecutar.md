  GNU nano 8.3                                                                            ProyectoFinal.sh
# Programas

cd /u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/MadisonCa/ProyectoF
mkdir -p Secuencias_muscle
cd Secuencias_muscle

# Descargar genes con edirect

/u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "rag1[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 70 | efetch -db nuccore -format fasta > rag1$
/u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "cytb[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 70 | efetch -db nuccore -format fasta > cytb$
/u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "pomc[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 70 | efetch -db nuccore -format fasta > pomc$

# Organizar carpeta con MUSCLE2

## Crear carpeta nueva para mantener orden
cp ../../muscle3.8.31_i86linux64 .
perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' cytb_Ranidae.fasta > Ranidae.cytb.fasta
perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' rag1_Ranidae.fasta > Ranidae.rag1.fasta
perl -pe 's/(>\w+.\d)\s(\w+)\s(\w+).*/\1_\2_\3/g' pomc_Ranidae.fasta > Ranidae.pomc.fasta


# Alineamiento con MUSCLE
for filename in *.fasta
do ./muscle3.8.31_i86linux64 -in $filename -out muscle_$filename -maxiters 1 -diags
done

# Inferencia con IQ-TREE
module load iqtree/2.2.2.6
for filename in muscle_*.fasta
do iqtree2 -s $filename
done

# Combinar árboles
cat *.treefile > Ranidae.All.trees

# Final
## Filogenia completada
## Descarga Ranidae.All.trees desde Hoffman a tu computador personal
*scp dechavez@hoffman2.idre.ucla.edu:/u/scratch/d/dechavez/Bioinformatica-PUCE/RepotenBio/MadisonCa/ProyectoF/Secuencias_muscle/
## Abrirlo con FigTree para inspección

## Herramientas utilizadas
datasets (NCBI CLI): descarga de secuencias genéticas por símbolo
muscle3.8.31_i86linux64: alineamiento de secuencias por gen
iqtree/2.2.2.6: inferencia filogenética por gen
FigTree: visualización y edición gráfica de árboles filogenéticos

## Requisitos del sistema
Unix/Linux
Acceso a terminal con bash
Conexión a internet para descarga de datos

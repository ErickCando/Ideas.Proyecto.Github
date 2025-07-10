#!/bin/bash
# ===============================================
# nano.sh : Pipeline filogenético Ranidae - Hoffman
# Autor: Madison Cando
# Descripción: Descarga, edita, alinea y construye árbol de especies
# ===============================================

# === 1. Crear carpeta de trabajo ===
mkdir -p ~/Proyecto_Filogenia
cd ~/Proyecto_Filogenia

echo "Carpeta Proyecto_Filogenia creada y abierta."

# 2. Descargar genes con edirect ===
echo "Descargando secuencias con MastBio/edirect..."

/u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "rag1[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 100 | efetch -db nuccore -format fasta > rag1_Ranidae.fasta

/u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "cytb[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 100 | efetch -db nuccore -format fasta > cytb_Ranidae.fasta

/u/scratch/d/dechavez/Bioinformatica-PUCE/MastBio/edirect/esearch -db nuccore -query "pomc[GENE] AND Ranidae[ORGN]" | efetch -format uid | head -n 100 | efetch -db nuccore -format fasta > pomc_Ranidae.fasta

echo "Descarga completada."

# 3. Organizar carpeta y MUSCLE
echo "Organizando archivos..."

# Crear carpeta nueva para mantener orden
mkdir -p Secuancias_muscle
mv *.fasta Secuancias_muscle/
# Asegúrate de tener muscle3.8.31_i86linux64 en esta carpeta
cp /muscle3.8.31_i86linux64 Secuencias_muscle/

echo "Archivos .fasta y MUSCLE copiados a carpeta genes_y_muscle."

# 4. Instrucción para edición manual
echo "=============================================="
echo "DESCARGA la carpeta genes_y_muscle a tu computador personal."
echo "ABRE cada archivo .fasta en Atom y edita cada cabecera:"
echo "Mantén solo ID, nombre de la especie y gen. E.g. >ID_Especie_Gen"
echo "Usa Regex: w+/letras, d+/números, s/espacios, ./signos"
echo "Cuando termines, SUBE de nuevo los archivos editados a la misma carpeta en Hoffman."
echo "=============================================="
echo "Presiona ENTER para continuar cuando ya hayas subido los archivos editados."
read

# 5. Alineamiento con MUSCLE
echo "Alineando con MUSCLE..."
cd Secuencias_muscle
muscle3.8.31_i86linux64

for filename in *.fasta
do
./muscle3.8.31_i86linux64 -in $filename -out muscle_$filename -maxiters 1 -diags
done

echo "Alineamiento completado."

# 6. Inferencia con IQ-TREE
echo "Inferencia filogenética con IQ-TREE..."
module load iqtree/2.2.2.6

for filename in muscle_*.fasta
do iqtree2 -s $filename
done

echo "Inferencia por gen completada."

# 7. Combinar árboles
echo "Uniendo archivos treefile..."
cat *.treefile > All.trees

# 8. Árbol de especies con ASTRAL
echo "Ejecutando ASTRAL..."
java -jar astral.5.7.8.jar -i All.trees -o Astral.Ranidae.tree

echo "Árbol de especies generado: Astral.Ranidae.tree"

# 9. Final
echo "Pipeline completado."
echo "Descarga Astral.Ranidae.tree desde Hoffman a tu computador personal"
echo "y ábrelo con FigTree para inspección."
echo "=============================================="

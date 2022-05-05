#!/bin/bash
source functions.sh 

gui(){
while [ 1 ] 
do
    action=$(yad --width 500 --entry --title="Sys stats"  \
    --window-icon=./stats.ico \
    --image=./stats.ico \
    --scale=0.1 \
    --button="gtk-ok:0" --button="gtk-close:1" \
    --text "Veuillez choisir l'action:" \
    --entry-text \
    "Taille total occupé" \
    "Taille total occupé par les fichiers/répertoires cachés" \
    "Nombre de fichiers/répertoires(non vides)/liens symboliques" \
    "Nombre des fichiers < 512ko et Nombre des fichiers > 15Mo" \
    "Nombre des fichiers et répertoires vides" \
    "Nombre des fichiers d extention spécifique" \
    "Help")

    ret=$?

[[ $ret -eq 1 ]] && exit 0
	
if [[ $ret -eq 2 ]]; then
    echo saved
    exit 0
fi

case $action in
    "Taille total occupé")
        Taille_totale_occupee >> tmp.txt
        yad --width=700 --height=200 --text-info --fore= red < tmp.txt 
        rm tmp.txt  
        ;;
    "Taille total occupé par les fichiers/répertoires cachés") 
        Taille_occupee_cachee >> tmp.txt
        yad --width=700 --height=200 --text-info --fore= red < tmp.txt  
        rm tmp.txt
        ;;
    "Nombre de fichiers/répertoires(non vides)/liens symboliques") 
        Nb_files_links_directories >> tmp.txt
        yad --width=700 --height=200 --text-info --fore= red < tmp.txt  
        rm tmp.txt
        ;;
    "Nombre des fichiers < 512ko et Nombre des fichiers > 15Mo")
        Nombre_petit_gros_fichiers >> tmp.txt
        yad --width=700 --height=200 --text-info --fore= red < tmp.txt  
        rm tmp.txt
    ;;
    "Nombre des fichiers et répertoires vides")
        Nombre_fichier_repertoire_vide >> tmp.txt
        yad --width=700 --height=200 --text-info --fore= red < tmp.txt  
        rm tmp.txt
    ;;
    "Nombre des fichiers d extention spécifique")
        type=$(yad --text "Veillez entrer l'extension désirée." --entry)
        Nombre_fichier_d_ext "${type}" >> tmp.txt
        yad --width=700 --height=200 --text-info --fore= red < tmp.txt  
        rm tmp.txt
    ;;
    Help*) help >> tmp.txt
        yad --width=700 --height=200 --text-info --fore= red < tmp.txt  
        rm tmp.txt
        ;; 
    *) exit 1 ;;  
esac
done   
}
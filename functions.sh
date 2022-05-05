#!/bin/bash
show_usage()
{
 echo "$0: [-h] [-T] [-t] [-n] [-N] [-d] [-m] [-s] [-g] chemin.." exit 1;
}

ouvrir_help()
{
    cat help.txt
}

Taille_totale_occupee()
{
    total_size=$(du -shc . | tail -1)
    echo "taille total occupée : $total_size"
}

Taille_occupee_cachee()
{
    hidden_size=$(du -sch .[!.]* 2>/dev/null | tail -1)
    echo "talle occuppée par les fichiers et repertoires cachés : $hidden_size"
}

Nb_files_links_directories()
{
    non_empty_dirs=$(du --max-depth=1 -cb . |grep -c "^4096"$'\t')
    # dirs=$(find . -type d -printf '.' | wc -c)
    # empty_dirs=$(find . -type d -empty -printf '.' | wc -c)
    links=$(find . -type l -printf '.' | wc -c)
    files=$(find . -type f -printf '.' | wc -c)

    echo "Nombre de repertoires non vides : $non_empty_dirs"
    echo "Nombre de fichiers : $files"
    echo "Nombre de liens symboliques : $links"

}

Nombre_petit_gros_fichiers()
{
    petit=$(find . -type f -size -512k -printf '.' |wc -c)
    gros=$(find . -type f -size +15M -printf '.' |wc -c)
    echo "Nombre des petit fichers (-512ko) : $petit"
    echo "Nombre des gros fichiers (+15Mo) : $gros"
}

Nombre_fichier_repertoire_vide()
{
    rep=$(find . -type d -empty -printf '.' | wc -c)
    files=$(find . -type f -empty -printf '.' | wc -c)
    echo "Nombre de fichiers vides : $files"
    echo "Nombre de repertoires vides : $rep"
}

Nombre_fichier_d_ext(){
    nb=$(find . -name "*.$1" -printf '.' | wc -c)
    echo "Nombre des fichier de l'extention .""$1"" : $nb"
}

Menu_textuel()
{
    trap "echo 'Control-C ne peut plus etre utilise' ; sleep 1 ; clear ; continue " 1 2 3
    while true
    do
    clear
    echo -e "\t MENU 

    \t [1] \t Help
    \t [2] \t Acceder au GUI
    \t [3] \t Taille total occupé
    \t [4] \t Taille total occupé par les fichiers/répertoires cachés
    \t [5] \t Nombre de fichiers/répertoires(non vides)/liens symboliques
    \t [6] \t Nombre des fichiers < 512ko et Nombre des fichiers > 15Mo
    \t [7] \t Nombre des fichiers et répertoires vides 
    \t [8] \t Nombre des fichiers d extention spécifique
    \t [0] \t QUITTER 

    \t Entrez un choix [0 - 9]"


    read answer
    clear

    case "$answer" in
        
        1) 
        ouvrir_help
        ;;
        2) 
        gui
        ;;
        3) Taille_totale_occupee
        ;;
        4) Taille_occupee_cachee
        ;;
        5) Nb_files_links_directories
        ;;
        6) Nombre_petit_gros_fichiers
        ;;
        7) Nombre_fichier_repertoire_vide
        ;;
        8) echo "Donner l'extention de fichier"; read -r n; Nombre_fichier_d_ext "$n"
        ;;
        0)  echo "sortie du programme" ; exit 0 ;;
        *)  echo "Choisissez une option affichee dans le menu:" ;;
    esac
    echo ""
    echo "tapez RETURN pour le menu"
    read dummy
    done
}
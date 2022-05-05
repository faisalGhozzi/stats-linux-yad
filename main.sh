#!/bin/bash
source graphique.sh

main()
{
if [ $# -eq 0 ] 
then
    show_usage
    exit 1
else
    while getopts "hgTtnNmsd:-:" opt ; do

    case "${opt}" in
        -)
            case "${OPTARG}" in
                help)
                ouvrir_help
                ;;
                *)show_usage
                ;;
            esac;;
        m)
        Menu_textuel
        ;;
        h) 
        ouvrir_help
        ;;
        g) 
        gui
        ;;
        T) Taille_totale_occupee
        ;;
        t) Taille_occupee_cachee
        ;;
        n) Nombre_petit_gros_fichiers
        ;;
        N) Nb_files_links_directories
        ;;
        d) Nombre_fichier_d_ext ${OPTARG}
        ;;
        s) Nombre_fichier_repertoire_vide
        ;;
        *) show_usage
        ;;
    esac
    done
fi
}

main "$*"
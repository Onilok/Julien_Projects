#!/bin/bash

reponse="oui"
echo "voulez vous executez letape 1 ? Entrez oui si c'est le cas"
read reponse

date=$(date +"%d-%m-%Y-%Hh%Mm%Ss")  # ici je recupere l'heure au format voulu 

if [ "$reponse" = "oui" ]; then
    echo "vous avez choisis d'executé la première etape"
    if [ -d /home/molok/work/in/ ]; then
        echo " le dossier in existe bien passons a l'etape suivante"
    else  
        mkdir /home/molok/work/in
        echo "le dossier in a ete crée"
    fi

    if [ -d /home/molok/work/log ]; then
        echo " le dossier log existe bien passons a l'etape suivante"
    else  
        mkdir /home/molok/work/log
    fi

    if [ ! -f /home/molok/work/in/data.json ]; then
        wget -O /home/molok/work/in/data.json -o  /home/molok/work/log/wgetlog-$date.log https://microsoftedge.github.io/Demos/json-dummy-data/5MB.json
        echo "recuperation des données en format json dans le dossier in/data.json"
    else 
        echo "le fichier data.json est déja present passons a l'étape suivante"
    fi
    echo "des logs onts ete ajoutée dans le dossier log"
else 
    echo "passage a l'etape 2"
fi

mysql -u julien -ppass < "/home/molok/work/script.sql"
echo "lancement du script sql"

echo "remplisage de la base de donnée via le script python"
python3 /home/molok/work/db.py

echo "souhaitez vous faire une recherche simple ou composer ? tapez 1 pour simple et 2 pour composer"
read reponse
if [ "$reponse" = "1" ]; then
    echo "recherche simple, tapez 1 si vous voulez recuperez tout les element d'un champ par exemple tout les name, ou tapez 2 si vous voulez recuperez seulement les information relatif a un name donnée par exemple Abla Dilmurat"
    read reponse
    if [ "$reponse" = "1" ]; then
        echo "tapez name pour recuperer tout les name par exemple"
        read reponse
        echo "tapez 1 si vous voulez terminal et 2 pr fichier"
        read reponse2
        if [ "$reponse2" = "1" ]; then
            case $reponse in 
                name)
                    mysql -u julien -ppass banta -e "select name from full_object;"
                    ;;
                language)
                    mysql -u julien -ppass banta -e "select language from full_object;"
                    ;;
                external_id)
                    mysql -u julien -ppass banta -e "select external_id from full_object;"
                    ;;
                bio)
                    mysql -u julien -ppass banta -e "select bio from full_object;"
                    ;;
                version)
                    mysql -u julien -ppass banta -e "select version from full_object;"
                    ;;
                *) # sa cest si l'utilisateur  a rentrer quelque chose ne correspondant a aucun des cas 
                    echo "champs incorrect"
                    ;;
            esac # sa c'est comme fi mais pour les case histoire de dire c fini les cas ici
        elif [ "$reponse2" = "2" ]; then

            if [ -d /home/molok/work/out ]; then
                echo " le dossier out existe bien passons a l'etape suivante"
            else  
                mkdir /home/molok/work/out
            fi

            echo "choissisez donc un nom de fichier"
            read reponse3

            while [ -f "/home/molok/work/out/$reponse3.txt" ]; do 
                echo "le fichier existe deja choissisez un autre nom"
                read reponse3
            done

            case $reponse in 
                name)
                    mysql -u julien -ppass banta -e "select name from full_object;" > /home/molok/work/out/$reponse3.txt
                    ;;
                language)
                    mysql -u julien -ppass banta -e "select language from full_object;" > /home/molok/work/out/$reponse3.txt
                    ;;
                external_id)
                    mysql -u julien -ppass banta -e "select external_id from full_object;" > /home/molok/work/out/$reponse3.txt
                    ;;
                bio)
                    mysql -u julien -ppass banta -e "select bio from full_object;" > /home/molok/work/out/$reponse3.txt
                    ;;
                version)
                    mysql -u julien -ppass banta -e "select version from full_object;" > /home/molok/work/out/$reponse3.txt
                    ;;
                *) # sa cest si l'utilisateur a rentrer quelque chose ne correspondant a aucun des cas 
                    echo "champs incorrect"
                    ;;
            esac # sa c'est comme fi mais pour les case histoire de dire c fini les cas ici
        fi
    elif [ "$reponse" = "2" ]; then
        echo "dans ce cas tapez l'information connu pour recuperer le contenue lié a cette information par exemple Adile Qadir"
        read reponse
        echo "tapez 1 si vous voulez terminal et 2 pr fichier"
        read reponse2
        if [ "$reponse2" = "1" ]; then
            mysql -u julien -ppass banta -e "select * from full_object where name='$reponse' OR language='$reponse' OR bio='$reponse' OR version='$reponse' OR id='$reponse';"
        elif [ "$reponse2" = "2" ]; then
            if [ -d /home/molok/work/out ]; then
                echo " le dossier out existe bien passons a l'etape suivante"
            else  
                mkdir /home/molok/work/out
            fi

            echo "choissisez donc un nom de fichier"
            read reponse3

            while [ -f "/home/molok/work/out/$reponse3.txt" ]; do 
                echo "le fichier existe deja choissisez un autre nom"
                read reponse3
            done

            mysql -u julien -ppass banta -e "select * from full_object where name='$reponse' OR language='$reponse' OR bio='$reponse' OR version='$reponse' OR id='$reponse';" > /home/molok/work/out/$reponse3.txt
        else    
            echo "choix incorrect"
        fi
    else
        echo "choix incorrect"
    fi
elif [ "$reponse" = "2" ]; then
    echo "entrez votre premiez parametre de recherche exemple Adile Qadir"
    read reponse
    echo "entrez votre deuxieme parametre de recherche exemple 6.49"
    read reponse2
    echo "tapez 1 si vous voulez terminal et 2 pr fichier"
    read reponse3
    if [ "$reponse3" = "1" ]; then
        resultat=$(mysql -u julien -ppass banta -e "select * from full_object where name='$reponse' OR language='$reponse' OR bio='$reponse' OR version='$reponse' OR id='$reponse' AND (name='$reponse2' OR language='$reponse2' OR bio='$reponse2' OR version='$reponse2' OR id='$reponse2');")
        if [ -z "$resultat" ]; then # -z verifie si la variable est vide ou non 
            echo "Aucun résultat trouvé pour les valeurs $reponse et $reponse2" > &2  #regirige la sortie d'erreur
            exit 1
        else
            echo "$resultat"
        fi
    elif [ "$reponse3" = "2" ]; then
        echo "choissisez donc le nom du fichier"
        read reponse3
        while [ -f "/home/molok/work/out/$reponse3.txt" ]; do 
            echo "le fichier existe deja choissisez un autre nom"
            read reponse3
        done
        mysql -u julien -ppass banta -e "select * from full_object where name='$reponse' OR language='$reponse' OR bio='$reponse' OR version='$reponse' OR id='$reponse' AND (name='$reponse2' OR language='$reponse2' OR bio='$reponse2' OR version='$reponse2' OR id='$reponse2');" > "/home/molok/work/out/$reponse3.txt"
    else 
        echo "choix incorrect"
    fi
else 
    echo "choix incorrect"
fi

#!/bin/bash 
##-----UTN FACULTAD REGIONAL HAEDO----------------* - shell - *------------------
## _______     ___       __   __   __  |
##|   ____|   /   \     |  | |  | |  | | CATEDRA ESTRUCTURAS AERONAUTICAS III
##|  |__     /  ^  \    |  | |  | |  | |
##|   __|   /  /_\  \   |  | |  | |  | |    GENERADOR LATEX TP RR
##|  |____ /  _____  \  |  | |  | |  | |
##|_______/__/     \__\ |__| |__| |__| | generador: script principal
##                                     |
##-------------------------------------------------------------------------------
##################### DECLARACIONES ########################

#declare -r nNac=$(ls -lB ./bancoEjercicios/nacho/ | tail -n +2 | wc -l)

declare -r nMau=$(ls -lB ./bancoEjercicios/mauri/ | tail -n +2 | wc -l)

declare -r nNic=$(ls -lB ./bancoEjercicios/nico/ | tail -n +2 | wc -l)

#let nac=1

let mau=1

let nic=1

let numeroLinea=1

################### FUNCIONES ###############################

	
#@@@@@@@@@@@@@@@@@@ SCRIPT ##################################	

echo "ALUMNO,EJERCICIO" >asignacionEjercicios.csv

while read line
do

    ### Limita rango de variables
    
    #test "$nac" -gt "$nNac" && let nac=1

    test "$mau" -gt "$nMau" && let mau=1

    test "$nic" -gt "$nNic" && let nic=1


    cat ./db/planillaBase.tex | sed 's/ALUMNO/'"${line}"'/' >EngCalcPaper.tex
    
    
    #cat bancoEjercicios/nacho/${nac} >>EngCalcPaper.tex


    
    ### Interprete ayudantes

    if [ $((numeroLinea%2)) -eq 1 ]
    then

	cat bancoEjercicios/mauri/${mau} >>EngCalcPaper.tex

	echo "${line},mauri ${mau}" >>asignacionEjercicios.csv
	
	let mau++

    else
	
	cat bancoEjercicios/nico/${nic} >>EngCalcPaper.tex

	echo "${line},nico ${nic}" >>asignacionEjercicios.csv

	let nic++
	
    fi
    
    ### Adecuacion de variables
   
    let numeroLinea++

    ## Post-procesamiento

    pdflatex -interaction=nonstopmode EngCalcPaper.tex

    pdftk caratula/Caratula.pdf EngCalcPaper.pdf cat output informesFinales/"${line}".pdf
    
done<./db/listadoAlumnos.csv   	


################## MANTENIMIENTO FINAL ###################


#exit 0


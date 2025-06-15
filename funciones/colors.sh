#!/bin/bash

# Colores normales
negro()    { echo -e "\e[30m$1\e[0m"; }
rojo()     { echo -e "\e[31m$1\e[0m"; }
verde()    { echo -e "\e[32m$1\e[0m"; }
amarillo() { echo -e "\e[33m$1\e[0m"; }
azul()     { echo -e "\e[34m$1\e[0m"; }
magenta()  { echo -e "\e[35m$1\e[0m"; }
cian()     { echo -e "\e[36m$1\e[0m"; }
blanco()   { echo -e "\e[37m$1\e[0m"; }

# Colores en negrita
negro_b()    { echo -e "\e[1;30m$1\e[0m"; }
rojo_b()     { echo -e "\e[1;31m$1\e[0m"; }
verde_b()    { echo -e "\e[1;32m$1\e[0m"; }
amarillo_b() { echo -e "\e[1;33m$1\e[0m"; }
azul_b()     { echo -e "\e[1;34m$1\e[0m"; }
magenta_b()  { echo -e "\e[1;35m$1\e[0m"; }
cian_b()     { echo -e "\e[1;36m$1\e[0m"; }
blanco_b()   { echo -e "\e[1;37m$1\e[0m"; }
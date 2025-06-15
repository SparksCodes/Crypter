#!/bin/bash

source funciones/colors.sh
source funciones/password.sh
source funciones/crypting.sh
source funciones/decrypting.sh

mostrar_banner() {
    clear
    echo
    amarillo "   ██████╗██████╗ ██╗   ██╗██████╗ ████████╗███████╗██████╗ "
    amarillo "  ██╔════╝██╔══██╗╚██╗ ██╔╝██╔══██╗╚══██╔══╝██╔════╝██╔══██╗"
    amarillo "  ██║     ██████╔╝ ╚████╔╝ ██████╔╝   ██║   █████╗  ██████╔╝"
    amarillo "  ██║     ██╔══██╗  ╚██╔╝  ██╔═══╝    ██║   ██╔══╝  ██╔══██╗"
    amarillo "  ╚██████╗██║  ██║   ██║   ██║        ██║   ███████╗██║  ██║"
    amarillo_b "   ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝        ╚═╝   ╚══════╝╚═╝  ╚═╝  by PM"
    sleep .3
}

password_generada="" 

mostrar_menu_principal() {
    clear
    mostrar_banner
    echo
    amarillo_b " ==== ¿Qué deseas hacer? ===="
    echo
    echo " 1) Generar contraseña"
    echo " 2) Cifrar un archivo"
    echo " 3) Descifrar un archivo"
    echo " 4) Salir"
    echo
    amarillo_b " ============================"
    read -p "Selecciona una opción [1-4]: " opcion_principal
}

while true; do
    mostrar_menu_principal
    
    case $opcion_principal in
        1)generar_password;;
        2)mostrar_menu_cifrado;;
        3)mostrar_menu_descifrado;;
        4)
            unset password_generada
            echo " 👋 Bye Bye..."
            exit 0
            ;;
        *)
            rojo " ❌ Opción inválida."
            read -p "Pulsa Enter para continuar..."
            ;;
    esac
done

# En los archivos .sh que se metan dentro de un a carpeta solo deben tener funciones.
# Si se usa un while true y los case de control deben estar solo en el script principal.
# Los source deben ir una sola vez, fuera del bucle.
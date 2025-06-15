#!/bin/bash

source funciones/colors.sh

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

generar_password() {
    clear
    mostrar_banner
    echo
    azul  " 🔐 GENERADOR CONTRASEÑAS SEGURAS"
    echo
    read -p " ¿Elige la cantidad de caracteres [12 ~ 16]? " longitud

    if ! [[ "$longitud" =~ ^[0-9]+$ ]]; then
        rojo " ❌ Debes introducir solo números."
        read -p "Pulsa Enter para continuar..."
    return
    elif ((longitud < 12 || longitud > 16)); then
        rojo " ❌ Longitud inválida. Debe ser entre 12 y 16."
        read -p "Pulsa Enter para continuar..."
    return
    fi

    password_generada=$(< /dev/urandom tr -dc 'A-Za-z0-9!@#$%^&*()-_=+[]{}' | head -c "$longitud")

    echo
    rojo " ========================="
    verde_b "  ✅ Contraseña generada:"
    amarillo_b "  $password_generada"
    rojo " ========================="
    echo
    amarillo " ⚠️  No hace falta copiar la contraseña ahora. Se mostrará visible en los siguientes menús."
    echo
    read -p "Pulsa Enter para continuar..."
}

#!/bin/bash

source funciones/colors.sh
source funciones/password.sh

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

mostrar_menu_descifrado() {
    clear
    mostrar_banner
    echo
    if [[ -n "$password_generada" ]]; then
        rojo " ========================================="
        amarillo_b " 🔑 Contraseña generada: $password_generada"
        rojo " ========================================="
    fi
    echo
    verde " ====== SELECCIONA EL TIPO DE DESCIFRADO ======"
    echo
    echo " 1) Descifrar archivo .enc (AES OpenSSL)"
    echo " 2) Descifrar archivo .gpg (GPG simétrico)"
    echo " 3) Descifrar archivo .rsa.enc (RSA OpenSSL)"
    echo " 4) Volver"
    echo
    verde " ==========================================="
    read -p "Introduce una opción [1-4]: " opcion

    case $opcion in
        1) descifrado_aes_openssl ;;
        2) descifrado_gpg ;;
        3) descifrado_rsa_openssl ;;
        4) return ;;
        *) rojo " ❌ Opción inválida."; read -p "Pulsa Enter para continuar..." ;;
    esac
}

descifrado_aes_openssl() {
    echo
    azul_b " 🔓 Descifrado con OpenSSL (AES)"
    echo

    read -p " 📌 Introduce la ruta del archivo .enc a descifrar: " archivo

    if [[ ! -f "$archivo" ]]; then
        rojo " ❌ El archivo no existe."
        read -p "Pulsa Enter para continuar..."
        return
    fi

    read -s -p " 🔐 Introduce la contraseña de descifrado: " password
    echo

    salida="${archivo%.enc}.dec"

    openssl enc -d -pbkdf2 -aes-256-cbc -in "$archivo" -out "$salida" -pass pass:"$password"

    if [[ $? -eq 0 ]]; then
        verde " ✅ Archivo descifrado correctamente: $salida"
    else
        rojo " ❌ Error al descifrar el archivo."
    fi

    read -p "Pulsa Enter para continuar..."
}

descifrado_gpg() {
    echo
    azul_b " 🔓 Descifrado con GPG (simétrico)"
    echo

    read -p " 📌 Introduce la ruta del archivo .gpg a descifrar: " archivo

    if [[ ! -f "$archivo" ]]; then
        rojo " ❌ El archivo no existe."
        read -p "Pulsa Enter para continuar..."
        return
    fi

    salida="${archivo%.gpg}.dec"

    gpg --batch --yes -o "$salida" -d "$archivo"

    if [[ $? -eq 0 ]]; then
        verde " ✅ Archivo descifrado correctamente: $salida"
    else
        rojo " ❌ Error al descifrar con GPG."
    fi

    read -p "Pulsa Enter para continuar..."
}

descifrado_rsa_openssl() {
    echo
    azul_b " 🔓 Descifrado con OpenSSL (RSA)"
    echo

    read -p " 📌 Introduce la ruta del archivo .rsa.enc a descifrar: " archivo

    if [[ ! -f "$archivo" ]]; then
        rojo " ❌ El archivo no existe."
        read -p "Pulsa Enter para continuar..."
        return
    fi

    clave_priv="claves/clave_privada.pem"

    if [[ ! -f "$clave_priv" ]]; then
        rojo " ❌ No se encontró la clave privada: $clave_priv"
        read -p "Pulsa Enter para continuar..."
        return
    fi

    salida="${archivo%.rsa.enc}.dec"

    openssl rsautl -decrypt -inkey "$clave_priv" -in "$archivo" -out "$salida"

    if [[ $? -eq 0 ]]; then
        verde " ✅ Archivo descifrado correctamente: $salida"
    else
        rojo " ❌ Error al descifrar con RSA."
    fi

    read -p "Pulsa Enter para continuar..."
}



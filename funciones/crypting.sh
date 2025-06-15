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

mostrar_menu_cifrado() {
    clear
    mostrar_banner
    echo
    if [[ -n "$password_generada" ]]; then
        rojo " ========================================="
        amarillo_b " 🔑 Contraseña generada: $password_generada"
        rojo " ========================================="
    fi
    echo
    verde " ====== SELECCIONA EL TIPO DE CIFRADO ======"
    echo
    echo " 1) Cifrado simétrico con OpenSSL (AES)"
    echo " 2) Cifrado simétrico con GPG"
    echo " 3) Cifrado asimétrico con OpenSSL (RSA)"
    echo " 4) Volver"
    echo
    verde " ==========================================="
    read -p "Introduce una opción [1-4]: " opcion

    case $opcion in
        1) cifrado_aes_openssl ;;
        2) cifrado_gpg_simetrico ;;
        3) cifrado_rsa_openssl ;;
        4) return ;;
        *) rojo "Opción inválida."; read -p "Pulsa Enter..." ;;
    esac
}

cifrado_aes_openssl() {
    echo
    azul_b " 🔐 Cifrado simétrico con OpenSSL"
    echo
    read -p " 📌 Introduce la ruta del archivo a cifrar: " archivo

    if [[ ! -f "$archivo" ]]; then
        rojo " ❌ El archivo no existe. Inténtalo de nuevo."
        read -p " Pulsa Enter para continuar..."
        return
    fi

    read -s -p " 🔐 Introduce una contraseña para el cifrado: " password
    echo
    read -s -p " 🔐 Repite la contraseña: " password_confirm
    echo

    if [[ "$password" != "$password_confirm" ]]; then
        rojo " ❌ Las contraseñas no coinciden."
        read -p " Pulsa Enter para continuar..."
        return
    fi

    salida="${archivo}.enc"

    openssl enc -pbkdf2 -salt -aes-256-cbc -in "$archivo" -out "$salida" -pass pass:"$password"

    if [[ $? -eq 0 ]]; then
        verde " ✅ Archivo cifrado correctamente: $salida"
    else
        rojo " ❌ Error al cifrar el archivo."
    fi

    read -p " Pulsa Enter para continuar..."
}

cifrado_gpg_simetrico() {
    echo
    azul_b " 🔐 Cifrado simétrico con GPG"
    echo
    read -p " 📌 Introduce la ruta del archivo a cifrar: " archivo

    if [[ ! -f "$archivo" ]]; then
        rojo " ❌ El archivo no existe. Inténtalo de nuevo."
        read -p "Pulsa Enter para continuar..."
        return
    fi

    read -s -p " 🔐 Introduce una contraseña para el cifrado: " password
    echo
    read -s -p " 🔐 Repite la contraseña: " password_confirm
    echo

    if [[ "$password" != "$password_confirm" ]]; then
        rojo " ❌ Las contraseñas no coinciden."
        read -p "Pulsa Enter para continuar..."
        return
    fi

    salida="${archivo}.gpg"

    echo "$password" | gpg --batch --yes --passphrase-fd 0 --symmetric --cipher-algo AES256 -o "$salida" "$archivo"

    if [[ $? -eq 0 ]]; then
        verde " ✅ Archivo cifrado correctamente con GPG: $salida"
    else
        rojo " ❌ Error al cifrar con GPG."
    fi

    read -p "Pulsa Enter para continuar..."
}

generar_claves_rsa() {
    mkdir -p claves

    if [[ ! -f claves/clave_privada.pem || ! -f claves/clave_publica.pem ]]; then
        azul_b " 🔐 Generando par de claves RSA (2048 bits)..."
        openssl genpkey -algorithm RSA -out claves/clave_privada.pem -pkeyopt rsa_keygen_bits:2048
        openssl rsa -pubout -in claves/clave_privada.pem -out claves/clave_publica.pem

        if [[ $? -eq 0 ]]; then
            verde " ✅ Claves generadas correctamente en la carpeta 'claves/'."
        else
            rojo " ❌ Error al generar las claves."
        fi
    else
        amarillo_b "📂 Ya existen claves en la carpeta 'claves/'."
    fi
}

cifrado_rsa_openssl() {
    echo
    azul_b " 🔐 Cifrado asimétrico con OpenSSL (RSA)"
    echo
    
    generar_claves_rsa
    clave_pub="claves/clave_publica.pem"

    read -p " 📌 Introduce la ruta del archivo a cifrar: " archivo

    if [[ ! -f "$archivo" ]]; then
        rojo " ❌ El archivo no existe. Inténtalo de nuevo."
        read -p "Pulsa Enter para continuar..."
        return
    fi

    read -p " 🔑 Introduce la ruta de la clave pública (.pem): " clave_pub

    if [[ ! -f "$clave_pub" ]]; then
        rojo " ❌ La clave pública no existe. Inténtalo de nuevo."
        read -p "Pulsa Enter para continuar..."
        return
    fi

    salida="${archivo}.rsa.enc"

    openssl rsautl -encrypt -pubin -inkey "$clave_pub" -in "$archivo" -out "$salida"

    if [[ $? -eq 0 ]]; then
        verde " ✅ Archivo cifrado correctamente con RSA: $salida"
    else
        rojo " ❌ Error al cifrar con RSA."
    fi

    read -p "Pulsa Enter para continuar..."
}
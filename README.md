# CRYPTER 🔐

**CRYPTER** es una herramienta en Bash para cifrar, descifrar y generar contraseñas seguras desde la terminal.

## 🚀 Funcionalidades principales

- ✅ Generar contraseñas seguras personalizadas
- ✅ Cifrar archivos con AES-256 (OpenSSL)
- ✅ Descifrar archivos cifrados con AES-256 (OpenSSL)
- 🔜 Preparado para integración con GPG y RSA

## 🖥️ Menú principal

Al ejecutar el script, se presenta un menú inicial con 4 opciones:

1. Generar contraseña
2. Cifrar un archivo
3. Descifrar un archivo
4. Salir

[Imagen del menú principal]
![Menú principal](./2025-06-15_13-30.png)

---

## 🔐 Generador de contraseñas seguras

Permite generar contraseñas entre 12 y 16 caracteres, con símbolos especiales, números y letras. La contraseña generada queda memorizada para su uso inmediato en cifrado o descifrado.

[Generador de contraseñas]
![Generador de contraseñas](./2025-06-15_13-31.png)

---

## 🔒 Cifrado de archivos

Tras generar o definir una contraseña, puedes elegir el tipo de cifrado deseado. Actualmente se encuentra disponible:

- Cifrado simétrico con OpenSSL (AES-256-CBC con `-pbkdf2`)

[Menú de cifrado]
![Menú de cifrado](./2025-06-15_13-32.png)

Al seleccionar OpenSSL, se te pedirá:

1. La ruta del archivo a cifrar
2. La contraseña (se autocompleta si usaste el generador)

[Proceso de cifrado]
![Proceso de cifrado](./2025-06-15_13-34.png)

Si todo va bien, se guarda el archivo como `archivo.ext.enc`.

---

## 🔓 Descifrado de archivos

Desde el menú de descifrado puedes seleccionar:

1. Archivos `.enc` (AES/OpenSSL)
2. Archivos `.gpg` (GPG simétrico, próximamente)
3. Archivos `.rsa.enc` (RSA/OpenSSL, próximamente)

[Menú de descifrado]
![Menú de descifrado](./2025-06-15_13-35.png)

Para descifrar con AES:

- Introduces el archivo `.enc`
- Se solicita la contraseña

[Proceso de descifrado]
![Proceso de descifrado](./2025-06-15_13-36.png)

El archivo resultante se guarda como `archivo.ext.dec`.

---

## 🚪 Salir

Seleccionar la opción 4 en el menú principal cierra el programa con un mensaje de despedida.

[Salida del programa]
![Salir](./2025-06-15_13-37.png)

---

## ⚙️ Requisitos

- GNU/Linux o entorno compatible con Bash
- `openssl` instalado
- `tput` para manejo de posición del cursor (presente en casi todas las terminales)

---

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

![2025-06-15_13-30](https://github.com/user-attachments/assets/07ae5310-4c15-4ec4-8a88-3c8151e507b3)

---

## 🔐 Generador de contraseñas seguras

Permite generar contraseñas entre 12 y 16 caracteres, con símbolos especiales, números y letras. La contraseña generada queda memorizada para su uso inmediato en cifrado o descifrado.

![2025-06-15_13-31](https://github.com/user-attachments/assets/949861f0-3cb7-4009-9e47-5f9787cd21ce)

---

## 🔒 Cifrado de archivos

Tras generar o definir una contraseña, puedes elegir el tipo de cifrado deseado. Actualmente se encuentra disponible:

- Cifrado simétrico con OpenSSL (AES-256-CBC con `-pbkdf2`)

![2025-06-15_13-32](https://github.com/user-attachments/assets/0d02d476-c75f-4411-a5dd-2061de328cfe)

Al seleccionar OpenSSL, se te pedirá:

1. La ruta del archivo a cifrar
2. La contraseña (se autocompleta si usaste el generador)

![2025-06-15_13-34](https://github.com/user-attachments/assets/d4c38251-8fff-4f76-9475-30aed3ca2790)

Si todo va bien, se guarda el archivo como `archivo.ext.enc`.

---

## 🔓 Descifrado de archivos

Desde el menú de descifrado puedes seleccionar:

1. Archivos `.enc` (AES/OpenSSL)
2. Archivos `.gpg` (GPG simétrico, próximamente)
3. Archivos `.rsa.enc` (RSA/OpenSSL, próximamente)

![2025-06-15_13-35](https://github.com/user-attachments/assets/d27d1619-6f8c-42bd-b542-2753f4227b44)

Para descifrar con AES:

- Introduces el archivo `.enc`
- Se solicita la contraseña

![2025-06-15_13-36](https://github.com/user-attachments/assets/c68842d6-48c9-462f-a2f0-31f14d8f758f)

El archivo resultante se guarda como `archivo.ext.dec`.

---

## 🚪 Salir

Seleccionar la opción 4 en el menú principal cierra el programa con un mensaje de despedida.

![2025-06-15_13-37](https://github.com/user-attachments/assets/e12a6b72-cf64-4690-92d1-7d42623b72b1)

---

## ⚙️ Requisitos

- GNU/Linux o entorno compatible con Bash
- `openssl` instalado
- `tput` para manejo de posición del cursor (presente en casi todas las terminales)

---

@ECHO OFF
ECHO Se intentara crear el archivo en "%cd%\ejerciciosNASM\%1\%1.asm"
ECHO Creando el .obj
"C:\Program Files (x86)\NASM\nasm.exe" -f win32 "%cd%\ejerciciosNASM\%1\%1.asm" --PREFIX _
ECHO Creando el .exe
"%cd%\gcc.exe" "%cd%\ejerciciosNASM\%1\%1.obj" -o ejerciciosNASM\%1\%1.exe
ECHO Proceso finalizado
PAUSE
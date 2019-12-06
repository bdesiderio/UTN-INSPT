; Se ingresa una cadena. La computadora la muestra en mayusculas.
;
; En Windows (1 en la consola de NASM; 2 y 3 en la consola de Visual Studio):
; 1) nasm -f win32 ej3.asm --PREFIX _
; 2) link /out:ej3.exe ej3.obj libcmt.lib
; 3) ej3
;
; En GNU/Linux:
; 1) nasm -f elf ej3.asm
; 2) ld -s -o ej3 ej3.o -lc -I /lib/ld-linux.so.2
; 3) ./ej3
;


        global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
        global _start

        extern printf            ;
        extern scanf             ; FUNCIONES DE C (IMPORTADAS)
        extern exit              ;
        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!



section .bss                     ; SECCION DE LAS VARIABLES

numero:
        resd    1                ; 1 dword (4 bytes)

cadenaSorteo:
        resb    0x0100           ; 256 bytes

nrosGanadores:
        resd    10               ; 10 dword

cadena:
        resb    0x0100           ; 256 bytes

caracter:
        resb    1                ; 1 byte (dato)
        resb    3                ; 3 bytes (relleno)



section .data                    ; SECCION DE LAS CONSTANTES

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtChar:
        db    "%c", 0            ; FORMATO PARA CARACTERES

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)

ingreseNroGanador:             db     "Ingrese nro ganador: " ,0
cadenaOrdenada:				db     "0123456789abcdefghijklmnopqrstuvwxyz",0		

section .text                    ; SECCION DE LAS INSTRUCCIONES
 
leerCadena:                      ; RUTINA PARA LEER UNA CADENA USANDO GETS
        push cadena
        call gets
        add esp, 4
        ret

leerNumero:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret

leerCaracter:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push caracter
        push fmtChar
        call scanf
        add esp, 8
        ret
    
mostrarCadena:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push cadena
        push fmtString
        call printf
        add esp, 8
        ret

mostrarIngreseNroGanador:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push ingreseNroGanador
        push fmtString
        call printf
        add esp, 8
        ret 	

mostrarNumero:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword [numero]
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarCaracter:                 ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
        push dword [caracter]
        push fmtChar
        call printf
        add esp, 8
        ret

mostrarSaltoDeLinea:             ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
        push fmtLF
        call printf
        add esp, 4
        ret

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        push 0
        call exit

agregarNroSorteo:
    call leerNumero
    mov eax,[numero]
    call mostrarNumero
    mov [nrosGanadores+edi],eax
    
    mov ebx,[nrosGanadores+edi]
    mov [numero],ebx
    call mostrarNumero
    
    ret

_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
    mov al,0
    mov bl,0
    mov cl,0
    mov dl,0
    mov edi,0
    mov esi,0

agregar10Nros:
    call mostrarIngreseNroGanador
    call agregarNroSorteo
    inc edi
    call mostrarSaltoDeLinea
    cmp edi,11
        je mostrarCadenaYSalir
    jmp agregar10Nros

mostrarCadenaYSalir:
    mov esi,0

escribirCadena:
    mov bx,[nrosGanadores+esi]
    mov [numero],bx
    call mostrarNumero
    inc esi
    cmp esi,10
        je salirDelPrograma
    jmp escribirCadena

        global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
        global _start

        extern printf            ;
        extern scanf             ; FUNCIONES DE C (IMPORTADAS)
        extern exit              ;
        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!



section .bss                     ; SECCION DE LAS VARIABLES

numero:
        resd    1                ; 1 dword (4 bytes)
        
resultado:
        resd    1                ; 1 dword (4 bytes)

section .data                    ; SECCION DE LAS CONSTANTES

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)

section .text                    ; SECCION DE LAS INSTRUCCIONES
 
leerNumero:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret

mostrarNumero:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword [resultado]
        push fmtInt
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

_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
        call leerNumero

        mov ebx, [numero]
        mov [resultado], ebx

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        add [resultado],ebx
        call mostrarNumero
        call mostrarSaltoDeLinea

        mov edi,0
        mov eax, 0

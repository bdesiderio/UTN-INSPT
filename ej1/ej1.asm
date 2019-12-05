
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

fmtInt:         db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS
fmtLF:          db    0xA, 0             ; SALTO DE LINEA (LF)
fmtEqual:       db    "=", 0                ; SALTO DE LINEA (LF)
fmtX:           db    0x78, 0                ; SALTO DE LINEA (LF)

section .text                    ; SECCION DE LAS INSTRUCCIONES
 
leerNumero:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret

mostrarNumero:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword [numero]
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarResultado:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword [ebx]
        push fmtInt
        call printf
        add esp, 8
        ret

mostarEDI:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword edi
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarMultiplicador:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push fmtX
        call printf
        add esp, 4
        ret

mostrarEqual:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push fmtEqual
        call printf
        add esp, 4
        ret
        
mostrarSaltoDeLinea:             ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
        push fmtLF
        call printf
        add esp, 4
        ret

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        push 0
        call exit

multiplicarYMostrar:
        mul edi
        mov ebx,[eax]
        call mostrarNumero
        inc edi
        ret

_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
        call leerNumero

        mov edi,0

        call while

        call salirDelPrograma

while:  
        call mostrarNumero
        call mostrarMultiplicador
        call mostarEDI
        call mostrarEqual
        call mostrarResultado
        
        call mostrarSaltoDeLinea
        mov eax,[numero]
        inc edi
        mul edi
        mov [ebx],eax
        cmp edi,11
                je salirDelPrograma
        jmp while
        ret



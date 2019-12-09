
        global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
        global _start

        extern printf            ;
        extern scanf             ; FUNCIONES DE C (IMPORTADAS)
        extern exit              ;
        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!



section .bss                                ; SECCION DE LAS VARIABLES
numero:             resd    1                ; 1 dword (4 bytes)

cadena:   			resb    0x0100          ; 256 bytes

caracter: 			resb    1           ; 1 byte (dato)
					resb    3           ; 3 bytes (relleno)

section .data                               ; SECCION DE LAS CONSTANTES

fmtInt:             db    "%d", 0           ; FORMATO PARA NUMEROS ENTEROS
fmtLF:              db    0xA, 0            ; SALTO DE LINEA (LF)
fmtChar:            db    "%c", 0           ; FORMATO PARA CARACTERES

fmtIngreseTexto:    db    "Ingrese un texto: ", 0               ; SALTO DE LINEA (LF)

section .text                               ; SECCION DE LAS INSTRUCCIONES
 

leerCadena:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push cadena
    call gets
    add esp, 4
    ret

mostrarCaracter:                            ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
    push dword [caracter]
    push fmtChar
    call printf
    add esp, 8
    ret

mostrarBX:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push bx
    call printf
    add esp, 4
    ret

mostrarIngreseTexto:                        ;RUTINA PARA MOSTRAR POR PANTALLA LA INDICACION AL USUARIO
    push fmtIngreseTexto
    call printf
    add esp, 4
    ret

mostrarSaltoDeLinea:                        ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
    push fmtLF
    call printf
    add esp, 4
    ret

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
    push 0
    call exit

_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
    call mostrarIngreseTexto
    call leerCadena

    mov edi,0
    call convertirSigCaracterEnMayuscula

    call salirDelPrograma

convertirSigCaracterEnMayuscula:
    mov bl,[cadena+edi]
    mov cl,96
    mov dl,122

    mov [numero],bl
    mov bl,[numero]

    cmp cl,bl
        jg continuar

    cmp bl,dl
        jg continuar

    converMayus:
    sub bx,32                                        

    continuar:
    mov [numero],bl
    mov bl, [numero]
    mov [caracter],bl                              ;mov [caracter],bx
    call mostrarCaracter

    inc edi

    mov ax,[cadena+edi]

    cmp ax,0
        je salirDelPrograma
    jmp convertirSigCaracterEnMayuscula
    ret

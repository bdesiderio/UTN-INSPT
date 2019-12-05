
        global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
        global _start

        extern printf            ;
        extern scanf             ; FUNCIONES DE C (IMPORTADAS)
        extern exit              ;
        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!



section .bss                                ; SECCION DE LAS VARIABLES

cadena:   			resb    0x0100          ; 256 bytes
len:                equ $ - cadena              ;length of our string
section .data                               ; SECCION DE LAS CONSTANTES

fmtInt:             db    "%d", 0           ; FORMATO PARA NUMEROS ENTEROS
fmtLF:              db    0xA, 0            ; SALTO DE LINEA (LF)

fmtIngreseTexto:    db    "Ingrese un texto: ", 0               ; SALTO DE LINEA (LF)

fmtEsPalindromo:    db    "El texto ingresado es un Palindromo", 0               ; SALTO DE LINEA (LF)
fmtNoEsPalindromo:  db    "El texto ingresado no es un Palindromo", 0            ; SALTO DE LINEA (LF)

section .text                               ; SECCION DE LAS INSTRUCCIONES
 

leerCadena:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push cadena
    call gets
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
    mov esi,0
    dec esi
    dec edi
    call irAlFinal
   
    call salirDelPrograma

irAlFinal:
    inc edi
    mov bx,[cadena+edi]
    cmp bx,0
            je verificarPalindromo
    jmp irAlFinal
    ret

verificarPalindromo:
    dec edi
    inc esi
    
    cmp edi,0
        je esPalindromo

    mov al,[cadena+esi]
    mov ah,[cadena+edi]

    cmp al,ah
        je verificarPalindromo
    jmp noEsPalindromo
    ret

esPalindromo:
    push fmtEsPalindromo
    call printf
    add esp, 4
    call salirDelPrograma

noEsPalindromo:
    push fmtNoEsPalindromo
    call printf
    add esp, 4
    call salirDelPrograma
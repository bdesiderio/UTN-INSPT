
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
fmtEsPolindromo:    db    "El texto ingresado es un polindromo", 0               ; SALTO DE LINEA (LF)
fmtNoEsPolindromo:  db    "El texto ingresado no es un polindromo", 0            ; SALTO DE LINEA (LF)
fmtX:               db    0x78, 0           ; SALTO DE LINEA (LF)

caracterEDI: 			resb    1           ; 1 byte (dato)
					    resb    3           ; 3 bytes (relleno)

caracterESI: 			resb    1           ; 1 byte (dato)
					    resb    3           ; 3 bytes (relleno)

section .text                               ; SECCION DE LAS INSTRUCCIONES
 

leerCadena:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push cadena
    call gets
    add esp, 4
    ret

mostrarEDI:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword edi
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarESI:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword esi
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarSaltoDeLinea:                        ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
    push fmtLF
    call printf
    add esp, 4
    ret

mostrarCaracterEDI:                        ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
    push caracterEDI
    call printf
    add esp, 4
    ret

mostrarCaracterESI:                        ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
    push caracterESI
    call printf
    add esp, 4
    ret

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
    push 0
    call exit

_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
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
            je verificarPolindromo
    jmp irAlFinal
    ret

verificarPolindromo:
    dec edi
    inc esi
    
    call mostrarESI
    call mostrarEDI

    cmp edi,0
        je esPolindromo

    mov al,[cadena+esi]
    mov [caracterESI],al
    call mostrarCaracterESI

    mov ah,[cadena+edi]
    mov [caracterEDI],ah
    call mostrarCaracterEDI
    
    mov ax,[caracterESI]
    mov bx,[caracterEDI]

    cmp ax,bx
        je verificarPolindromo
    jmp noEsPolindromo
    ret

esPolindromo:
    push fmtEsPolindromo
    call printf
    add esp, 4
    call salirDelPrograma
    ret

noEsPolindromo:
    push fmtNoEsPolindromo
    call printf
    add esp, 4
    ret
    call salirDelPrograma
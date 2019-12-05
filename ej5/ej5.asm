
        global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
        global _start

        extern printf            ;
        extern scanf             ; FUNCIONES DE C (IMPORTADAS)
        extern exit              ;
        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!



section .bss                                ; SECCION DE LAS VARIABLES

cadena:   			resb    0x0100          ; 256 bytes

cadenaAuxiliar:   	resb    0x0100          ; 256 bytes

caracter: 			resb    1           ; 1 byte (dato)
					resb    3           ; 3 bytes (relleno)

section .data                               ; SECCION DE LAS CONSTANTES

fmtInt:             db    "%d", 0           ; FORMATO PARA NUMEROS ENTEROS
fmtString:          db    "%s", 0           ; FORMATO PARA CADENAS
fmtLF:              db    0xA, 0            ; SALTO DE LINEA (LF)
fmtChar:            db    "%c", 0           ; FORMATO PARA CARACTERES

fmtIngreseTexto:    db    "Ingrese un texto: ", 0               ; SALTO DE LINEA (LF)

section .text                               ; SECCION DE LAS INSTRUCCIONES
 

leerCadena:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push cadena
    call gets
    add esp, 4
    ret

mostrarCadenaAuxiliar:                            ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
    push cadenaAuxiliar
    push fmtString
    call printf
    add esp, 8
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

salirDelPrograma:                           ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
    push 0
    call exit

_start:
main:                                       ; PUNTO DE INICIO DEL PROGRAMA
    call mostrarIngreseTexto
    call leerCadena

    mov edi,0
    mov dl,64
    mov [cadenaAuxiliar],dl

    call recorrerCadena

    call mostrarCadenaAuxiliar
    
    call salirDelPrograma

recorrerCadena:
    mov bx,[cadena+edi]
    mov [caracter],bx

    inc edi

    cmp bx,0
        je salirDelPrograma
    jmp agregarCaracterACadena
    ret

agregarCaracterACadena:
    mov esi,-1
    call recorrerCadenaAuxiliar
    jmp recorrerCadena
    ret

recorrerCadenaAuxiliar:
    inc esi

    mov bx,[cadenaAuxiliar+esi]     ;Asigno en bx el caracter de la cadena aux.
    mov cx,[caracter]               ;Asigno en cx el caracter que quiero incorp.
    
    cmp bx,0
        je agregarEnCadenaAuxiliar
    
    cmp bx,cx
        jnb recorrerCadena
        jb recorrerCadenaAuxiliar
    ret

agregarEnCadenaAuxiliar
    call mostrarCaracter
    mov bx,[caracter]
    mov [cadenaAuxiliar+esi],bx
    jmp recorrerCadena

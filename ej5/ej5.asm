
        global main              ; ETIQUETAS QUE MARCAN EL PUNTO DE INICIO DE LA EJECUCION
        global _start

        extern printf            ;
        extern scanf             ; FUNCIONES DE C (IMPORTADAS)
        extern exit              ;
        extern gets              ; GETS ES MUY PELIGROSA. SOLO USARLA EN EJERCICIOS BASICOS, JAMAS EN EL TRABAJO!!!



section .bss                                ; SECCION DE LAS VARIABLES

numero:              resd    1                ; 1 dword (4 bytes)
bandera:             resd    1                ; 1 dword (4 bytes)

cadena:   			resb    0x0100          ; 256 bytes

caracter: 			resb    1           ; 1 byte (dato)
					resb    3           ; 3 bytes (relleno)

caracterAux: 		resb    1           ; 1 byte (dato)
					resb    3           ; 3 bytes (relleno)

lastCharacter: 		resb    1           ; 1 byte (dato)
					resb    3           ; 3 bytes (relleno)

section .data                               ; SECCION DE LAS CONSTANTES

fmtInt:             db    "%d", 0           ; FORMATO PARA NUMEROS ENTEROS
fmtString:          db    "%s", 0           ; FORMATO PARA CADENAS
fmtLF:              db    0xA, 0            ; SALTO DE LINEA (LF)
fmtChar:            db    "%c", 0           ; FORMATO PARA CARACTERES

fmtIngreseTexto:                    db    "Ingrese un texto: ", 0               ; SALTO DE LINEA (LF)
fmtIngreseSetearCaracter:           db    "Setear Caracter mas bajo", 0               ; SALTO DE LINEA (LF)
fmtObtenerSigCaracterMasBajo:       db    "obtenerSigCaracterMasBajo", 0               ; SALTO DE LINEA (LF)
fmtRecorrerCadena:       db    "recorrerCadena", 0               ; SALTO DE LINEA (LF)

section .text                               ; SECCION DE LAS INSTRUCCIONES
 

leerCadena:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push cadena
    call gets
    add esp, 4
    ret

mostrarNumero:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword [numero]
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarBandera:                   ; RUTINA PARA MOSTRAR UN NUMERO ENTERO USANDO PRINTF
        push dword [bandera]
        push fmtInt
        call printf
        add esp, 8
        ret

mostrarCaracter:                            ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
    push dword [caracter]
    push fmtChar
    call printf
    add esp, 8
    ret

mostrarCaracterAux:                            ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
    push dword [caracterAux]
    push fmtChar
    call printf
    add esp, 8
    ret



mostrarBX:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push bx
    call printf
    add esp, 4
    ret

mostrarCX:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push cx
    call printf
    add esp, 4
    ret

mostrarIngreseTexto:                        ;RUTINA PARA MOSTRAR POR PANTALLA LA INDICACION AL USUARIO
    push fmtIngreseTexto
    call printf
    add esp, 4
    ret

mostrarObtenerSiguienteCaracter:                        ;RUTINA PARA MOSTRAR POR PANTALLA LA INDICACION AL USUARIO
    push fmtObtenerSigCaracterMasBajo
    call printf
    add esp, 4
    ret

mostrarRecorrerCadena:                        ;RUTINA PARA MOSTRAR POR PANTALLA LA INDICACION AL USUARIO
    push fmtRecorrerCadena
    call printf
    add esp, 4
    ret


mostrarIngreseSetearCaracter:                        ;RUTINA PARA MOSTRAR POR PANTALLA LA INDICACION AL USUARIO
    push fmtIngreseSetearCaracter
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
    mov [caracterAux],cx                                ;al=el valor mas chico

obtenerSigCaracterMasBajo:
    call mostrarSaltoDeLinea
    call mostrarObtenerSiguienteCaracter
    mov edi,-1
    mov cx,0x00c8
    jmp recorrerCadena

recorrerCadena:
    call mostrarSaltoDeLinea
    call mostrarRecorrerCadena
    inc edi

    mov bx,[cadena+edi]
    
    mov [caracter],bx
    mov cx,[caracterAux]

    cmp bx,0
        je mostrarCaracterMasBajo

    mov bx,[cadena+edi]
    mov cx,[caracterAux]
    mov ax,[lastCharacter]

    cmp ax,bx
        jng recorrerCadena

    cmp bx,cx
        je recorrerCadena           ;Si ambos registros son iguales
        jg recorrerCadena           ;Si el de la izquierda es mas grande
        jng setearCaracterMasBajo   ;Si el de la derecha es mas grande
    
    call salirDelPrograma

setearCaracterMasBajo:
    call mostrarSaltoDeLinea
    call mostrarIngreseSetearCaracter
    mov dl,1
    mov [bandera],dl
    mov bx,[cadena+edi]
    mov [caracterAux],bx
    call mostrarCaracterAux
    jmp recorrerCadena

mostrarCaracterMasBajo:
    call mostrarCaracterAux
    mov dl,[bandera]
    mov dh,0
    call mostrarSaltoDeLinea
    call mostrarBandera
    mov bl, [caracterAux]
    mov [lastCharacter], bl

    cmp dl,dh
        je obtenerSigCaracterMasBajo
        jne salirDelPrograma

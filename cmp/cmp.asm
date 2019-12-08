
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

caracterAux: 		resb    1       ; 1 byte (dato)
					resb    3           ; 3 bytes (relleno)

section .data                               ; SECCION DE LAS CONSTANTES

fmtInt:             db    "%d", 0           ; FORMATO PARA NUMEROS ENTEROS
fmtString:          db    "%s", 0           ; FORMATO PARA CADENAS
fmtLF:              db    0xA, 0            ; SALTO DE LINEA (LF)
fmtChar:            db    "%c", 0           ; FORMATO PARA CARACTERES

fmtIngreseTexto:    db    "Ingrese un texto", 0               ; SALTO DE LINEA (LF)
fmtTexto1:    db    "Texto 1", 0               ; SALTO DE LINEA (LF)
fmtTexto2:    db    "Texto 2", 0               ; SALTO DE LINEA (LF)
fmtTexto3:    db    "Texto 3", 0               ; SALTO DE LINEA (LF)

section .text                               ; SECCION DE LAS INSTRUCCIONES
 

leerCadena:                                 ; RUTINA PARA LEER UNA CADENA USANDO GETS
    push cadena
    call gets
    add esp, 4
    ret

mostrarTexto1:                            ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
    push fmtTexto1
    push fmtString
    call printf
    add esp, 8
    ret

mostrarTexto2:                            ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
    push fmtTexto2
    push fmtString
    call printf
    add esp, 8
    ret

mostrarTexto3:                            ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
    push fmtTexto3
    push fmtString
    call printf
    add esp, 8
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
    mov al,1                              ;al=el valor mas chico
    mov bl,100

     cmp al,bl    
        je mostrarTexto1    ;Si ambos registros son iguales
        jg mostrarTexto2    ;Si el de la izquierda es mas grande
        jng mostrarTexto3   ;Si el de la derecha es mas grande
    call salirDelPrograma
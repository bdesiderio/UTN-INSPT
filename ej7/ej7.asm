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
numero:             resd    1                ; 1 dword (4 bytes)
numeroMinimo:       resd    1          ; 1 dword (4 bytes)
filas:              resd    1                ; 1 dword (4 bytes)
columnas:           resd    1                ; 1 dword (4 bytes)

filaActual:         resd    1                ; 1 dword (4 bytes)
columnaActual:      resd    1                ; 1 dword (4 bytes)

cadena:     resb    0x0100       ; 256 bytes

section .data                    ; SECCION DE LAS CONSTANTES

fmtAbreParentesis:      db     0x28,0

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtChar:
        db    "%c", 0            ; FORMATO PARA CARACTERES

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)

columnasMatrizText:             db    "Columnas de la matriz: " ,0
filasMatrizText:                db    "Filas de la matriz: " ,0
ingresadoEnPosicionText:        db    " Ingrese el nro: " ,0
fmtAbrirParentesis:				db     0x28,0
fmtCerrarParentesis:			db     0x29,0
fmtComa:						db     0x2C,0
fmtPuntoComa:					db	   0x3B,0	

section .text                    ; SECCION DE LAS INSTRUCCIONES
 

leerNumero:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret

mostrarColumnasMatrizText:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push columnasMatrizText
        push fmtString
        call printf
        add esp, 8
        ret 
        
mostrarFilasMatrizText:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push filasMatrizText
        push fmtString
        call printf
        add esp, 8
        ret 

mostrarIngresadoEnPosicionText:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
    push ingresadoEnPosicionText
    push fmtString
    call printf
    add esp, 8
    ret 

mostrarCommaText:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
    push fmtComa
    push fmtString
    call printf
    add esp, 8
    ret 	

mostrarCadena:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
    push cadena
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

mostrarSaltoDeLinea:             ; RUTINA PARA MOSTRAR UN SALTO DE LINEA USANDO PRINTF
        push fmtLF
        call printf
        add esp, 4
        ret

solicitarNro:
    
    mov cx, [filaActual]
    mov [numero],cx
    call mostrarNumero

    call mostrarCommaText

    mov cx, [columnaActual]
    mov [numero],cx
    call mostrarNumero

    call mostrarIngresadoEnPosicionText

    ret


salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        call mostrarCadena
        call mostrarSaltoDeLinea
        push 0
        call exit


_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
    mov ax,0
    mov bx,0
    mov edi,0
    mov esi,0

    mov cx,100
    mov [numeroMinimo],cx
    mov cx,0 

    mov [cadena],bx
    mov [cadena+1],bx

    mov [columnaActual],bx

    mov dx,-1
    mov [filaActual],dx
    mov dx,0

    call mostrarColumnasMatrizText              ; Seteo las columnas en [columnas]
    call leerNumero
    mov bx, [numero]
    mov [columnas],bx

    call mostrarFilasMatrizText                 ; Seteo las filas en [filas]
    call leerNumero
    mov bx, [numero]
    mov [filas],bx
    
    mov dx,0
    mov [filaActual],dx
    mov dx,0

cambiarFila:
    mov esi,[filaActual]
    inc esi
    mov [filaActual],esi

    dec esi
    
    mov ax,[filas]
    mov [numero],ax

    call mostrarNumero
    call mostrarSaltoDeLinea

    mov [numero],esi
    call mostrarNumero
    call mostrarSaltoDeLinea
    
    cmp esi,[filas]
        je salirDelPrograma

cambiarColumna:
    mov edi,0
    mov [columnaActual],edi

    continuarCambiarColumna:
    mov edi,[columnaActual]
    inc edi
    mov [columnaActual],edi

    call solicitarNro
    call leerNumero
    mov bx,[numero]

    cmp bx,[numeroMinimo]
        je agregarCordeenadas
        jng cambiarNroMinimo

    continuarContinuarCambiarColumna:
    cmp [columnas],edi
        je cambiarFila
    jmp continuarCambiarColumna


cambiarNroMinimo:
    mov bx, [numero]
    mov [numeroMinimo], bx
    call limpiarCadena

agregarCordeenadas:
    call escribirCoordenadas
    jmp continuarContinuarCambiarColumna


irAlFinalDeLaCadena:
    mov esi,0

    continuarIrAlFinalDeLaCadena:
    mov cx,[cadena+esi]
    inc esi
    cmp cx,0
        jg continuarIrAlFinalDeLaCadena
    ret    

escribirCoordenadas:
    call irAlFinalDeLaCadena
    dec esi
    mov bx, [fmtAbrirParentesis]
    mov [cadena+esi],bx
    
    inc esi
    mov bx, [filaActual]
    add bx,48
    mov [cadena+esi],bx
    
    inc esi
    mov bx, [fmtComa]
    mov [cadena+esi],bx
    
    inc esi
    mov bx, [columnaActual]
    add bx,48
    mov [cadena+esi],bx

    inc esi
    mov bx, [fmtCerrarParentesis]
    mov [cadena+esi],bx

    inc esi
    mov bx, [fmtPuntoComa]
    mov [cadena+esi],bx
    ret

limpiarCadena:
    mov esi,0
    
    continuarLimpiando:
    mov dx,0
    mov [cadena+esi],dx
    inc esi
    mov dx,[cadena+esi]
    cmp dx,0
        jne continuarLimpiando
    ret

    
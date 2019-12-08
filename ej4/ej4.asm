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



section .bss                                         ; SECCION DE LAS VARIABLES
numero:                     resd    1                ; 1 dword (4 bytes)
numeroAnterior:             resd    1                ; 1 dword (4 bytes)
diferenciaAnterior:         resd    1                ; 1 dword (4 bytes)
diferenciaActual:           resd    1                ; 1 dword (4 bytes)
nrosSumados:                resd    1                ; 1 dword (4 bytes)
cantidadNros:               resd    1                ; 1 dword (4 bytes)

section .data                    ; SECCION DE LAS CONSTANTES

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtChar:
        db    "%c", 0            ; FORMATO PARA CARACTERES

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)

txtIngreseNro:                  db    "Ingrese un nro: " ,0
txtSumaTotal:                   db    "Suma Total: " ,0
txtCantidadNrosIngresados:      db    "Cantidad de nros ingresados: " ,0
txtGuiones:                     db    "==================================" ,0
txtDiferencia:                  db    "Diferencia entre ambos numeros: " ,0
txtUltimoNroIngresado:          db    "Ultimo nro ingresado: " ,0
txtPromedio:          db    "Promedio: " ,0

section .text                           ; SECCION DE LAS INSTRUCCIONES
 

leerNumero:                             ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret

mostrarTxtIngreseNro:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push txtIngreseNro
        push fmtString
        call printf
        add esp, 8
        ret 

mostrarTxtPromedio:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push txtPromedio
        push fmtString
        call printf
        add esp, 8
        ret      

mostrarTxtDiferencia:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push txtDiferencia
        push fmtString
        call printf
        add esp, 8
        ret 

mostrarTxtSumaTotal:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push txtSumaTotal
        push fmtString
        call printf
        add esp, 8
        ret 

mostrarTxtCantidadNrosIngresados:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push txtCantidadNrosIngresados
        push fmtString
        call printf
        add esp, 8
        ret 
        
mostrarTxtGuiones:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push txtGuiones
        push fmtString
        call printf
        add esp, 8
        ret 

mostrarTxtUltimoNroIngresado:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
    push txtUltimoNroIngresado
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

salirDelPrograma:                ; PUNTO DE SALIDA DEL PROGRAMA USANDO EXIT
        call mostrarTxtSumaTotal
        mov bx, [nrosSumados]
        mov [numero],bx
        call mostrarNumero

        call mostrarSaltoDeLinea
        call mostrarSaltoDeLinea
        call mostrarTxtGuiones
        call mostrarSaltoDeLinea

        call mostrarTxtCantidadNrosIngresados

        mov bx, [cantidadNros]
        mov [numero],bx
        call mostrarNumero

        call mostrarSaltoDeLinea

        mov ax,[nrosSumados]
        mov bx,[cantidadNros]
        
        div bx
        mov [numero],al
        
        call mostrarTxtPromedio
        call mostrarNumero
        call mostrarSaltoDeLinea
        call mostrarTxtGuiones

        push 0
        call exit


_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
    mov ax,0
    mov bx,0
    mov cx,0
    mov dx,0
    mov edi,0
    mov esi,0

    mov [numeroAnterior],ax
    mov [diferenciaAnterior],ax
    mov [nrosSumados],ax
    mov [cantidadNros],ax
    mov [numero],ax


ingresarNuevoNro:
    call mostrarTxtIngreseNro
    call leerNumero
    
    mov bx, [numero]
    add bx, [nrosSumados]
    mov [nrosSumados],bx

    mov bx, [cantidadNros]
    add bx, 1
    mov [cantidadNros],bx

calcularDiferencia:
    mov bx,[numero]
    
    cmp bx,[numeroAnterior]
        je restarAnteriorMasChico
        jg restarAnteriorMasChico
        jng restarAnteriorMasGrande

    continuarCalcularDiferencia:

    mov bx,[diferenciaActual]
    cmp bx,[diferenciaAnterior]
        je salirDelPrograma
    
    call mostrarTxtGuiones
    call mostrarSaltoDeLinea

    mov cx,[numero]
    mov [numeroAnterior],cx 
    call mostrarTxtUltimoNroIngresado
    call mostrarNumero
    call mostrarSaltoDeLinea

    mov bx,[diferenciaActual]
    mov [diferenciaAnterior],bx
    call mostrarTxtDiferencia
    mov [numero],bx
    call mostrarNumero

    call mostrarSaltoDeLinea

    jmp ingresarNuevoNro

restarAnteriorMasChico:
    mov bx,[numero]
    mov cx,[numeroAnterior]

    sub bx,cx
    mov [diferenciaActual],bx
    jmp continuarCalcularDiferencia

restarAnteriorMasGrande:
    mov bx,[numero]
    mov cx,[numeroAnterior]

    sub cx,bx
    mov [diferenciaActual],cx
    jmp continuarCalcularDiferencia
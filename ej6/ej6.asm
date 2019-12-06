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

numero:         resd    1                ; 1 dword (4 bytes)
numero1:        resd    1                ; 1 dword (4 bytes)
numero2:        resd    1                ; 1 dword (4 bytes)
numero3:        resd    1                ; 1 dword (4 bytes)
numero4:        resd    1                ; 1 dword (4 bytes)
numero5:        resd    1                ; 1 dword (4 bytes)
numero6:        resd    1                ; 1 dword (4 bytes)
numero7:        resd    1                ; 1 dword (4 bytes)
numero8:        resd    1                ; 1 dword (4 bytes)
numero9:        resd    1                ; 1 dword (4 bytes)
numero10:       resd    1                ; 1 dword (4 bytes)

cadenaSorteo:
        resb    0x0100           ; 256 bytes

nrosGanadores:
        resd    10               ; 10 dword

cadena:
        resb    0x0100           ; 256 bytes

caracter:
        resb    1                ; 1 byte (dato)
        resb    3                ; 3 bytes (relleno)



section .data                    ; SECCION DE LAS CONSTANTES

fmtInt:
        db    "%d", 0            ; FORMATO PARA NUMEROS ENTEROS

fmtString:
        db    "%s", 0            ; FORMATO PARA CADENAS

fmtChar:
        db    "%c", 0            ; FORMATO PARA CARACTERES

fmtLF:
        db    0xA, 0             ; SALTO DE LINEA (LF)

consulteElNro:             db     "Consulte el Nro: " ,0
ingreseNroGanador:             db     "Ingrese nro ganador: " ,0
ingresadoEnPosicion:             db     "El nro fue ingresado en la posicion: " ,0

section .text                    ; SECCION DE LAS INSTRUCCIONES
 
leerCadena:                      ; RUTINA PARA LEER UNA CADENA USANDO GETS
        push cadena
        call gets
        add esp, 4
        ret

leerNumero:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push numero
        push fmtInt
        call scanf
        add esp, 8
        ret

leerCaracter:                      ; RUTINA PARA LEER UN NUMERO ENTERO USANDO SCANF
        push caracter
        push fmtChar
        call scanf
        add esp, 8
        ret
    
mostrarCadena:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push cadena
        push fmtString
        call printf
        add esp, 8
        ret

mostrarConsulteElNro:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push consulteElNro
        push fmtString
        call printf
        add esp, 8
        ret 


mostrarIngreseNroGanador:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push ingreseNroGanador
        push fmtString
        call printf
        add esp, 8
        ret 

mostrarIngresadoEnPosicion:                   ; RUTINA PARA MOSTRAR UNA CADENA USANDO PRINTF
        push ingresadoEnPosicion
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

mostrarCaracter:                 ; RUTINA PARA MOSTRAR UN CARACTER USANDO PRINTF
        push dword [caracter]
        push fmtChar
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

agregarNroSorteo:
    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero1],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero2],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero3],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero4],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero5],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero6],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero7],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero8],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero9],eax

    call mostrarIngreseNroGanador
    call leerNumero
    mov eax,[numero]
    mov [numero10],eax
    ret

_start:
main:                            ; PUNTO DE INICIO DEL PROGRAMA
    mov al,0
    mov bl,0
    mov cl,0
    mov dl,0
    mov edi,0
    mov esi,0

    call agregarNroSorteo

consultarNros:
    call mostrarSaltoDeLinea
    call mostrarConsulteElNro
    call leerNumero
    mov eax,[numero]

    cmp eax,0
        je salirDelPrograma

    call verificarSiFueIngresado

verificarSiFueIngresado:
    cmp [numero1],eax
        je mostrarEnPosicion1
    cmp [numero2],eax
        je mostrarEnPosicion2
    cmp [numero3],eax
        je mostrarEnPosicion3
    cmp [numero4],eax
        je mostrarEnPosicion4
    cmp [numero5],eax
        je mostrarEnPosicion5
    cmp [numero6],eax
        je mostrarEnPosicion6
    cmp [numero7],eax
        je mostrarEnPosicion7
    cmp [numero8],eax
        je mostrarEnPosicion8
    cmp [numero9],eax
        je mostrarEnPosicion9
    cmp [numero10],eax
        je mostrarEnPosicion10
    call consultarNros

mostrarEnPosicion1:
    call mostrarIngresadoEnPosicion
    mov ecx,1
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion2:
    call mostrarIngresadoEnPosicion
    mov ecx,2
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion3:
    call mostrarIngresadoEnPosicion
    mov ecx,3
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion4:
    call mostrarIngresadoEnPosicion
    mov ecx,4
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion5:
    call mostrarIngresadoEnPosicion
    mov ecx,5
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion6:
    call mostrarIngresadoEnPosicion
    mov ecx,6
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion7:
    call mostrarIngresadoEnPosicion
    mov ecx,7
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion8:
    call mostrarIngresadoEnPosicion
    mov ecx,8
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion9:
    call mostrarIngresadoEnPosicion
    mov ecx,9
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros

mostrarEnPosicion10:
    call mostrarIngresadoEnPosicion
    mov ecx,10
    mov [numero],ecx
    call mostrarNumero    
    jmp consultarNros


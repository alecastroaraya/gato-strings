;--------------------------------------------Portada-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Tarea de ASM: Gato Strings
; Curso: Arquitectura de Computadores
; Grupo: 2
; Escuela de Computacion
; Instituto Tecnologico de Costa Rica
; Fecha de entrega: 7 de octubre del 2020
; Estudiante: Alejandro Castro Araya
; Carne: 2020034944
; Profesor: Kirstein Gatjens
;--------------------------------------------Manual de Usuario-------------------------------------------------------------------------------------------------------------------------------------------------------------------
; Este programa recibe una letra como opcion, y dependiendo de ella, llama diferentes rutinas de strings. Dependiendo de la letra se toman diferentes parametros. Se separa todo por medio de gatos (#).
; Significado de los parametros: num -> un numero, C -> un caracter, string -> un string.
; Las posibles opciones con sus diferentes parametros y la explicacion de lo que hacen son:
; #H                           Despliega la ayuda del programa. Dice las posibles opciones de letra y lo que hace el programa dependiendo de la opcion escogida. Tambien se despliega si no se escribe nada.
; #L#string                    Desplega la longitud del string.
; #I#num#string1#string2       Inserta el string1 dentro del string2 en la posicion num.
; #Y#num#string1#string2       Remplaza el string1 dentro del string2 en la posicion num.
; #F#string1#string2           Busca el string1 dentro del string2 y retorna la posicion exacta del string1 si la encuentra en el string2. Si no la encuentra, retorna que no la encontro.
; #Q#C1#C2#string1             Sustituye todas las apariciones del caracter1 por el caracter2 dentro del string1.
; #K#string1#string2#string3   Sustituye todas las apariciones del string1 por el string2 dentro del string3.
; #A#string                    Despliega todos los anagramas de una palabra dada en el campo de string.
; #X#num1#num2#string          Extrae un substring que empieza en la posicion num1 y que tiene la longitud num2 dentro del string. Luego despliega el substring que se recorto del string.
; #R#num1#num2#string          Extrae un substring que empieza en la posicion num1 y que tiene la longitud num2 dentro del string. Luego despliega lo que no se recorto del string.
; #E#C#string                  Elimina todas las apariciones de un caracter dado en el string.
; #C#C#num#string              Clona todas las apariciones del caracter dado en un string por la cantidad de veces dada en el num.
;--------------------------------------------Analisis de resultados-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;+-----------------------------------------------------------------------------------------------------+------+--------------------------------------------------------------------------------------------------------------------------------+
;|                                            Parte                                                    | Nota | Explicacion Adicional                                                                                                          |
;+-----------------------------------------------------------------------------------------------------+------+--------------------------------------------------------------------------------------------------------------------------------+
;| Mini acerca de                                                                                      | A    | Funciona correctamente                                                                                                         |
;| Recibir todas las posibles opciones y sus otros parametros correspondientes en la linea de comando. | A    | Funciona correctamente                                                                                                         |
;| Validaciones y desplegar mensajes de error.                                                         | A    | Funciona correctamente                                                                                                         |
;| Implementacion de rutinas de strings en formato Like C con instrucciones de hileras.                | A    | Funciona correctamente                                                                                                         |
;| #H                         Despliega ayuda cuando es solicitada y cuando no se escribe nada.        | A    | Funciona correctamente                                                                                                         |
;| #L#string                  Despliega la longitud del string.                                        | A    | Funciona correctamente                                                                                                         |
;| #I#num#string1#string2     Inserta el string1 dentro del string2 en la posicion num.                | A    | Funciona correctamente                                                                                                         |
;| #Y#num#string1#string2     Despliega el calendario de una semana correctamente.                     | A    | Funciona correctamente                                                                                                         |
;| #F#string1#string2         Busca el string1 dentro del string2 y retorna si se encontro o no.       | D    | Solo dice si se encontro o no, no dice la posicion, ademas a veces dice que se encontro y no deberia haberlo encontrado        |
;| #Q#C1#C2#string1           Sustituye todas las apariciones del caracter1 por el caracter2.          | A    | Funciona correctamente                                                                                                         |
;| #K#string1#string2#string3 Sustituye todas las apariciones del string1 por el string2.              | D    | Solo sustituye el primer caracter del string1 por el primer caracter del string2                                               |
;| #A#string                  Despliega todos los anagramas de una palabra dada en el campo de string. | D    | Solo despliega los caracteres por separado de la palabra                                                                       |
;| #X#num1#num2#string        Despliega el substring extraido de la longitud num2 que empieza en num1. | A    | Funciona correctamente                                                                                                         |
;| #R#num1#num2#string        Despliega lo que quedo del string luiego de sacarle un substring.        | A    | Funciona correctamente                                                                                                         |
;| #E#C#string                Elimina todas las apariciones de un caracter dado en el string.          | A    | Funciona correctamente                                                                                                         |
;| #C#C#num#string            Clona todas las apariciones del caracter dado en un string.              | A    | Funciona correctamente                                                                                                         |
;| Documentación (Portada, manual de usuario y analisis de resultados con ABCDE) y comentarios.        | A    | Escrita correctamente                                                                                                          |
;+-----------------------------------------------------------------------------------------------------+------+--------------------------------------------------------------------------------------------------------------------------------+
;--------------------------------------------Formato de strings utilizado, listado de rutinas implementadas y que trabajo se hizo con la o las string instructions------------------------------------------------------------------------------
;Formato de strings utilizado: Like C (tienen un caracter null al final del string)
;Listado de rutinas implementadas:
;largoStringL: Utiliza scasb para determinar el largo del string y lo retorna en el cx lo que eventualmente se despliega con un interrupt. Esta es la opcion L.
;insertarStringI: Utiliza scasb para determinar el largo del string2, esto lo hace para saber si la posicion del num es mayor a la del string2. Si la posicion del num es mayor, printea el string1 al final. Esta es la opcion I.
;remplazarStringY: Utilizar scasb para determinar el largo del string2, esto lo hace para saber si la posicion del num es mayor a la del string2. Si la posicion del num es mayor, printea el string1 al final. Esta es la opcion Y.
;remplazarCharQ: Utiliza scasb para determinar el largo del string dado, y luego usa el largo como un contador y lo va decrementando por uno cada loop. Cuando el largo es 0, termina de printear el string con los chars remplazados. Esta es la opcion Q.
;cortarSubstringX: Utiliza scasb para determinar el largo del string dado, y usa el largo como contador para recorrer el string cortado hasta que el largo sea 0, printeando los caracteres cortados como sea necesario. Esta es la opcion X.
;recortarSubstringR: Utiliza scasb para determinar el largo del string dado, y lo usa como un contador para ir printeando los caracteres que quedaron sin recortar del string hasta que el largo sea 0. Esta es la opcion R.
;eliminarCharE: Utiliza scasb para determinar el largo del string dado, y lo usa como contador al que se le va decrementando para ir printeando la string a la que se le quitaron los caracteres hasta que el largo sea 0. Esta es la opcion E.
;clonarCharC: Utiliza scasb para determinar el largo del string dado, y luego usa el largo como contador y printea el string con los caracteres clonados hasta que el largo sea 0. Esta es la opcion C.
;anagramasA: Usa scasb para sacar el largo del string que se dio, y luego lo usa como un contador para printear los caracteres separados del string hasta que el largo sea 0. Esta es la opcion A.
;findReplaceK: Para la opcion K no logre encontrar la manera de hacerlo con una instruccion de hilera. Esta es la opcion K.
;buscarposicionF: Usa scasb para sacar el largo del string y recorre el string hasta que el largo sea 0 si no se encontro, o hasta que se encuentre. Esta es la opcion F.
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


data segment

	acercade db 'Arquitectura de Computadores Gr 2 Alejandro Castro Araya Tarea Gato Strings' ,13, 10, 'Carne 2020034944 Ver. 0.74-3 14/09/2020', 13, 10, ' ', 13, 10, '$'
	ayuda1 db 'Escriba una letra con parametros separados por gatos para llamar una rutina de strings. Opciones:',13,10, 13,10, '#H para ayuda.',13,10, '#L#string dice el largo del string.',13,10, '#I#num#string1#string2 para insertar el string1 en el string2.',13,10, '$'
	ayuda2 db '#Y#num#string1#string2 para remplazar el string1 en el string2.',13,10, '#F#string1#string2 para buscar el string1 en el string2.',13,10, '$'
	ayuda3 db '#Q#C1#C2#string1 sustituye el C1 por C2 en el string.',13,10, '#K#string1#string2#string3 sustituye todas las veces que sale string1 por string2 en string3.',13,10, '$'
	ayuda4 db '#A#string desplega todos los anagramas de una palabra.',13,10, '#X#num1#num2#string corta un substring y lo despliega.',13,10, '$'
	ayuda5 db '#R#num1#num2#string recorta un substring y despliega el resto.',13,10, '#E#C#string elimina todas las apariciones del C en string.',13,10, '#C#C#num#string clona todas las apariciones de C num veces en string.$'
	letra db 80, 0, 80 dup('$')
	largo dw 80, 0, 80 dup('$')
	largo2 dw 0
	numero db 80, 0, 80 dup('$')
	numero2 db 80, 0, 80 dup('$')
	errorletra db 'No ingreso una letra correcta. Terminando el programa...$'
	errorchar db 'No ingreso un caracter correcto. Terminando el programa...$'
	errornum db 'No ingreso un numero correcto. Terminando el programa...$'
	char1 db 80, 0, 80 dup('$')
	char2 db 80, 0, 80 dup('$')
	div1 dw 0
	div2 dw 0
	espacio db ' $'
	found db 'Encontrado$'
	notfound db 'No esta$'

data ends


pila segment stack 'stack'
   dw 256 dup(?)

pila ends


code segment
.model small
.386

        assume  cs:code, ds:data, ss:pila

mostrarAyudaH Proc
	cmp letra,20h ; Se compara la letra con null para ver si no se escribio nada. Si no se escribio nada se desplega la ayuda.
	jl desplegarAyuda
	cmp letra,48h ; Se compara la letra con H en hexadecimal. Si se escribio H se desplega la ayuda.
	je desplegarAyuda
	jmp volverMostrarAyuda
desplegarAyuda:	
	lea dx,ayuda1 ; Despliega ls mensajes de ayuda.
	mov ah,9h
	int 21h
	lea dx,ayuda2
	mov ah,9h
	int 21h
	lea dx,ayuda3
	mov ah,9h
	int 21h
	lea dx,ayuda4
	mov ah,9h
	int 21h
	lea dx,ayuda5
	mov ah,9h
	int 21h
	jmp terminarAyuda
terminarAyuda:	
	mov ah,4ch ; Hace interrupt para hacer exit hacia DOS para terminar el programa.
	int 21h
volverMostrarAyuda:
	ret
mostrarAyudaH endP

largoStringL Proc
	push cx ; Se hace push a los registers que se modifican para guardar sus estados antes de cambiarlos.
	push ax
	push dx
	push di
	cmp letra,'L' ; Si no se escribio L se devuelve.
	jne retornearFinal
	
	mov di,86h ; Se mueve el caracter donde empieza el string al destiny index.
	
	sub cx,cx ; Se pone 0 en cx y luego se le hace not para que quede en el maximo posible para poder sacar el largo.
	not cx
	sub al,al ; Se pone el caracter null en al para usar scasb para encontrar el caracter null al final del string.
	
	cld ; Se hace clear al direction flag para usar scasb y sacar el largo.
	repne scasb ; Se hace scasb y se repite hasta que se encuentre el caracter null en el string.
	not cx ; Se termina de sacar el largo y queda en el cx.
	dec cx
	
	cmp cx,9 ; Si el largo es 9 o menos es solo 1 digito y solo se le suma el caracer 0 para que sea ASCII.
	jle nueveOMenos
	cmp cx,9 ; Si es mayor a 9 es de dos digitos y se tienen que sacar ambos caracteres en ASCII.
	jg mayorQueNueve
	jmp volverLargoString
nueveOMenos:
	add cx,'0' ; Se convierte el largo de 1 digito a ascii y se despliega.
	mov largo,cx
	lea dx,largo
	mov ah,9h
	int 21h
	jmp terminar
mayorQueNueve:
	mov ax,cx ; Si es de dos digitos, se hace division del largo para que quede el digito 1 en el cociente y el digito 2 en el residuo. Luego se convierten a ASCII por separado y se despliegan por separado.
	mov bx,10
	xor dx,dx
	div bx
	push dx
	add al,'0'
	mov dl,al
	mov ah,2
	int 21h
	pop dx
	add dl,'0'
	mov ah,2
	int 21h
terminar:
	mov ah,4ch
	int 21h
volverLargoString: ; Se devuelven los registers a sus estados antes de sacar el largo con pop.
	pop cx
	pop ax
	pop dx
	pop di
terminarLargoString:
	ret
largoStringL endP

insertarStringI Proc
	cmp letra,'I' ; Si la letra no es I entonces se devuelve.
	jne volverInsertarString
conseguirNumero:
	mov si,85h ; Se mueve la posicion del numero al source index para luego moverlo al cl.
	mov cl,byte ptr es:[si]
	mov numero,cl
	cmp numero,'0' ; Si no se escribio un numero entonces da error.
	jl errorNumeroI
	cmp numero,'9'
	jg errorNumeroI
	sub numero,'0'
	mov cl,byte ptr es:[si+1]
	mov numero2,cl
	cmp numero2,'#' ; Si el caracter luego del primer numero no es un # entonces es un numero y se ocupan sacar ambos digitos.
	jne conseguirNumero2Digitos
	mov si,87h ; Si el numero es de solo un digito, se mueve la posicion donde inicia el string al source index.
	mov bx,0
	cmp numero,0 ; Si el numero es 0 entonces se printea el string1 primero y luego el string2.
	je numEs0PrintearString1
	jmp conseguirString1
conseguirNumero2Digitos:
	mov dl,10 ; Se divide el numero entre 10 para obtener el cociente y residuo. El cociente se multiplica por 10 y luego se le suma el residuo para obtener el numero de dos digitos.
	mov al,numero
	mul dl
	mov cl,al
	mov al,numero2
	sub al,'0'
	add cl,al
	mov numero,cl
	mov si,88h
	mov bx,0
	jmp conseguirString1
	
numEs0PrintearString1:
	mov cl,byte ptr es:[si+bx] ; Si el numero escrito era 0 se printea el string1 hasta encontrar el gato, luego se printea el string2.
	cmp cl,'#'
	je numEs0PrintearString2
	mov dl,cl
	mov ah,2
	int 21h
	inc bx
	jmp numEs0PrintearString1
numEs0PrintearString2:
	inc bx
	mov cl,byte ptr es:[si+bx]
	cmp cl,20h
	jl volverInsertarString
	mov dl,cl
	mov ah,2
	int 21h
	jmp numEs0PrintearString2
conseguirString1:
	mov cl,byte ptr es:[si+bx] ; Se recorre el string1 hasta obtener el string2.
	cmp cl,'#'
	je conseguirString2
	inc bx
	jmp conseguirString1
errorNumeroI:
	lea dx,errornum ; Despliega un error si el numero escrito no era un numero.
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h
conseguirString2:
	inc bx ; Se printea el string2 hasta que encontro el caracter null.
	cmp cl,20h
	jl printearString1Prep
	mov cl,byte ptr es:[si+bx]
	mov dl,cl
	mov ah,2
	int 21h
	dec numero
	cmp numero,0
	je printearString1Prep
	jmp conseguirString2
printearString1Prep:
	cmp numero,9 ; Se mueve la posicion de incio del string al source index, si el numero era de dos digitos se mueve una posicion mas para adelante para compensar.
	jg mover88h
	jmp mover87h
mover88h:
	mov si,88h
	jmp pushear
mover87h:
	mov si,87h
	jmp pushear
pushear:
	push bx ; Se guarda el registro bx y luego se le mueve 0 para luego printear el string1.
	mov bx,0
printearString1:
	mov cl,byte ptr es:[si+bx] ; Se printean los caracteres del string1 hasta encontrar el #.
	cmp cl,'#'
	je terminarPrintear
	mov dl,cl
	mov ah,2
	int 21h
	inc bx
	jmp printearString1
terminarPrintear:
	pop bx ; Se retorna el bx a como estaba antes y luego se incrementa 1 para saltarse el gato.
	inc bx
loopear:
	mov cl,byte ptr es:[si+bx] ; Se printea el string2 hasta encontrar el caracter null.
	cmp cl,20h
	jl volverInsertarString
	mov dl,cl
	mov ah,2
	int 21h
	inc bx
	jmp loopear
	
sacarLargo:
	mov bx,0 ; Se usa el procedimiento que ya se explico en el proc largoStringL para sacar el largo del string2.
	cmp numero,9
	jg sacarLargoNumeroDosDigitos
	mov si,87h
	jmp sacarLargoConseguirString1
sacarLargoNumeroDosDigitos:
	mov si,88h
sacarLargoConseguirString1:
	mov cl,byte ptr es:[si+bx]
	cmp cl,'#'
	je sacarLargoConseguirString2
	inc bx
	jmp sacarLargoConseguirString1
sacarLargoConseguirString2:
	inc bx
	cmp numero,9
	jg sacarLargoConseguirString2DosDigitos
	mov di,87h
	add di,bx
	jmp seguirLargo
sacarLargoConseguirString2DosDigitos:
	mov di,88h
	add di,bx
	jmp seguirLargo
	
seguirLargo:
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	
	cmp cx,9
	jle esNueveOMenos
	cmp cx,9
	jg esMayorQueNueve
esNueveOMenos:
	mov largo,cx
	mov dx,0
	mov cl,numero
	jmp terminarLargo
esMayorQueNueve:
	mov ax,cx
	mov bx,10
	xor dx,dx
	div bx
	mov largo,ax
	add largo,dx
	mov dx,0
	mov cl,numero
	jmp terminarLargo
terminarLargo:
	inc dx ; dx = numero ; Cuando ya se saco el largo, se pone el mismo valor del numero al registro dx para luego poder comparar el registro dx con el largo del string2.
	dec cl
	cmp cl,0
	je retornear
	jmp terminarLargo
volverInsertarString:
	jmp sacarLargo
	
retornear:
	cmp dx,largo ; numero > largo ; Se compara el largo del string2 con el numero dado en los parametros. Si el numero es mas grande que el largo del string2. entonces el string1 se printea al final.
	jle printearString1AlFinal
	jmp retornearFinal
printearString1AlFinal:
	cmp numero,9 ; Si el numero es de dos digitos se le suma 1 a la posicion que se movera al si, si no entonces se mueve la 87h que es donde empieza el string1.
	jg mover88hAlFinal
	jmp mover87hAlFinal
mover88hAlFinal:
	mov si,88h
	jmp moverCeroBX
mover87hAlFinal:
	mov si,87h
	jmp moverCeroBX
moverCeroBX:
	mov bx,0 ; Se mueve 0 a bx para usarlo con si.
desplegarString1:
	mov cl,byte ptr es:[si+bx] ; Se despliegan los caracteres del string1 hasta que encuentra el gato y luego termina.
	cmp cl,'#'
	je retornearFinal
	mov dl,cl
	mov ah,2
	int 21h
	inc bx
	jmp desplegarString1
retornearFinal:
	ret
insertarStringI endP

remplazarStringY Proc
	cmp letra,'Y' ; Si la letra no es Y, vuelve.
	jne retornearFinalRemplazar
conseguirNumeroRemplazar:
	mov si,85h  ; Se mueve la posicion inicial del numero al source index y si el numero no es menor a 0 o mayor a 9 se convierte a ASCII. Si si lo es, da error.
	mov cl,byte ptr es:[si]
	mov numero,cl
	cmp numero,'0'
	jl errorNumeroY
	cmp numero,'9'
	jg errorNumeroY
	sub numero,'0'
	mov cl,byte ptr es:[si+1]
	mov numero2,cl
	cmp numero2,'#'
	jne conseguirNumero2DigitosRemplazar
	mov si,87h
	mov bx,0
	cmp numero,0
	je numEs0PrintearString1Remplazar
	jmp conseguirString1Remplazar
errorNumeroY:
	lea dx,errornum ; Da un error de numero invalido.
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h
conseguirNumero2DigitosRemplazar:
	mov dl,10 ; Se convierte el numero de dos digitos dado a entero y eso se mueve a la variable de largo.
	mov al,numero
	mul dl
	mov cl,al
	mov al,numero2
	sub al,'0'
	add cl,al
	mov numero,cl
	mov si,88h
	mov bx,0
	mov largo2,0
	jmp conseguirString1Remplazar
numEs0PrintearString1Remplazar:
	mov cl,byte ptr es:[si+bx] ; Si el numero dado era 0, printea la string1 hasta que encuentra el gato.
	cmp cl,'#'
	je numEs0PrintearString2RemplazarPrep
	mov dl,cl
	mov ah,2
	int 21h
	inc bx
	jmp numEs0PrintearString1Remplazar
numEs0PrintearString2RemplazarPrep:
	inc bx ; Se salta el caracter del gato.
numEs0PrintearString2Remplazar:
	inc bx ; Si el numero dado era 0, printea el string2 hasta que encuentra el caracter null y luego para.
	mov cl,byte ptr es:[si+bx]
	cmp cl,20h
	jl volverRemplazarString
	mov dl,cl
	mov ah,2
	int 21h
	jmp numEs0PrintearString2Remplazar
conseguirString1Remplazar:
	inc largo2 ; Si el numero no era 0, consigue el largo de la string1 para usarlo luego.
	mov cl,byte ptr es:[si+bx]
	cmp cl,'#'
	je conseguirString2Remplazar
	inc bx
	jmp conseguirString1Remplazar
conseguirString2Remplazar:
	inc bx ; Printea el string1 hasta que se encuentra el caracter null.
	mov cl,byte ptr es:[si+bx]
	cmp cl,20h
	jl volverRemplazarString
	mov dl,cl
	mov ah,2
	int 21h
	dec numero
	cmp numero,0
	je printearString1PrepRemplazar
	jmp conseguirString2Remplazar
printearString1PrepRemplazar:
	cmp numero,9 ; Si el numero es de 2 digitos mueve la posicion 88h al source index, si es de 1 digito mueve la posicion 87h.
	jg mover88hRemplazar
	jmp mover87hRemplazar
mover88hRemplazar:
	mov si,88h
	jmp pushearRemplazar
mover87hRemplazar:
	mov si,87h
	jmp pushearRemplazar
pushearRemplazar:
	push bx ; Se guarda el estado del bx y luego se le mueve 0.
	mov bx,0
printearString1Remplazar:
	mov cl,byte ptr es:[si+bx] ; Se printea la string1 hasta que encuentra el gato.
	cmp cl,'#'
	je terminarPrintearRemplazar
	mov dl,cl
	mov ah,2
	int 21h
	inc bx
	jmp printearString1Remplazar
terminarPrintearRemplazar:
	dec largo2 ; Se le quita 1 al largo2 por el gato y restaura el registor bx con pop.
	pop bx
	inc bx
	add bx,largo2
loopearRemplazar:
	mov cl,byte ptr es:[si+bx] ; Printea lo que faltaba del string2 hasta que encuentra el caracter null. Luego termina.
	cmp cl,20h
	jl volverRemplazarString
	mov dl,cl
	mov ah,2
	int 21h
	inc bx
	jmp loopearRemplazar
	
sacarLargoRemplazar:
	mov bx,0
	cmp numero,9
	jg sacarLargoNumeroDosDigitosRemplazar
	mov si,87h
	jmp sacarLargoConseguirString1Remplazar
sacarLargoNumeroDosDigitosRemplazar:
	mov si,88h
sacarLargoConseguirString1Remplazar:
	mov cl,byte ptr es:[si+bx]
	cmp cl,'#'
	je sacarLargoConseguirString2Remplazar
	inc bx
	jmp sacarLargoConseguirString1Remplazar
sacarLargoConseguirString2Remplazar:
	inc bx
	cmp numero,9
	jg sacarLargoConseguirString2DosDigitosRemplazar
	mov di,87h
	add di,bx
	jmp seguirLargoRemplazar
sacarLargoConseguirString2DosDigitosRemplazar:
	mov di,88h
	add di,bx
	jmp seguirLargoRemplazar
	
seguirLargoRemplazar:
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	
	cmp cx,9
	jle esNueveOMenosRemplazar
	cmp cx,9
	jg esMayorQueNueveRemplazar
esNueveOMenosRemplazar:
	mov largo,cx
	mov dx,0
	mov cl,numero
	jmp terminarLargoRemplazar
esMayorQueNueveRemplazar:
	mov ax,cx
	mov bx,10
	xor dx,dx
	div bx
	mov largo,ax
	add largo,dx
	mov dx,0
	mov cl,numero
	jmp terminarLargoRemplazar
terminarLargoRemplazar:
	inc dx ; dx = numero
	dec cl
	cmp cl,0
	je retornearRemplazar
	jmp terminarLargoRemplazar
volverRemplazarString:
	jmp sacarLargoRemplazar ; Se saca el largo del string2 para saber si el numero dado era mayor que el largo del string2.
	
retornearRemplazar:
	cmp dx,largo ; numero > largo ; Como en insertarStringI, si el numero dado es mayor que el largo, se printea el string1 al final.
	jle printearString1AlFinalRemplazar
	jmp retornearFinalRemplazar
printearString1AlFinalRemplazar:
	cmp numero,9
	jg mover88hAlFinalRemplazar
	jmp mover87hAlFinalRemplazar
mover88hAlFinalRemplazar:
	mov si,88h
	jmp moverCeroBXRemplazar
mover87hAlFinalRemplazar:
	mov si,87h
	jmp moverCeroBXRemplazar
moverCeroBXRemplazar:
	mov bx,0
desplegarString1Remplazar:
	mov cl,byte ptr es:[si+bx]
	cmp cl,'#'
	je retornearFinalRemplazar
	mov dl,cl
	mov ah,2
	int 21h
	inc bx
	jmp desplegarString1Remplazar
retornearFinalRemplazar:
	ret
remplazarStringY endP

remplazarCharQ Proc
	cmp letra,'Q'
	jne terminarRemplazarChar
conseguirChar1:
	mov si,85h
	mov bl,byte ptr es:[si] ; Muevo la letra que escribio el usuario a bl para luego moverla a la variable letra
	mov char1,bl
	cmp char1,'A'
	jl errorCharQ
	cmp char1,'z'
	jg errorCharQ
conseguirChar2:
	mov si,87h
	mov bl,byte ptr es:[si] ; Muevo la letra que escribio el usuario a bl para luego moverla a la variable letra
	mov char2,bl
	cmp char2,'A'
	jl errorCharQ
	cmp char2,'z'
	jg errorCharQ
	jmp conseguirLargoRemplazarChar
errorCharQ:
	lea dx,errorchar ; Despliega un error si el char no era un caracter valido.
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h
conseguirLargoRemplazarChar:
	push cx ; Usando el procedimiento ya explicado multiples veces, se saca el largo del string para usarlo luego como contador.
	push ax
	push dx
	push di
	
	mov di,89h ; Se mueve la posicion 89h al destination index porque ahi empieza el string.
	
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	dec cx
	
	cmp cx,9
	jle nueveOMenosRemplazarChar
	cmp cx,9
	jg mayorQueNueveRemplazarChar
	jmp volverRemplazarChar
nueveOMenosRemplazarChar:
	mov largo2,cx
	jmp volverRemplazarChar
mayorQueNueveRemplazarChar:
	mov ax,cx
	mov bx,10
	xor dx,dx
	div bx
	mov div1,ax
	mov div2,dx
	mov cx,10
	mul cx
	mov largo2,ax
	add ax,div2
	mov largo2,ax
	jmp volverRemplazarChar
volverRemplazarChar:
	pop cx
	pop ax
	pop dx
	pop di
	mov si,89h ; Luego de ya sacar el largo, se mueve la posicion donde empieza el string al source index para ir printeandolo, y se mueve 0 al bx para usarlo como contador.
	mov bx,0
printearChars:
	cmp largo2,0 ; Usa el largo como contador, mientras el largo no es 0 entonces printea el string. Si es 0 entonces se detiene.
	je terminarRemplazarChar
	mov dl,byte ptr es:[si+bx]
	cmp dl,char1
	je printearOtroChar ; Si encuentra el caracter1 en el string, entonces salta al procedimiento para remplazarlo.
	mov ah,2
	int 21h
	inc bx
	dec largo2
	jmp printearChars
printearOtroChar:
	mov dl,char2 ; Printea el caracter2 para remplazarlo, luego incrementa el bx y decrementa el contador para saltarse el caracter que se queria remplazar.
	mov ah,2
	int 21h
	inc bx
	dec largo2
	jmp printearChars ; Vuelve al procedimiento donde se printea el string.
terminarRemplazarChar:
	ret
remplazarCharQ endP

cortarSubstringX Proc
	cmp letra,'X' ; Si no se escribio X de letra, se devuelve.
	jne terminarCortarSubstring
conseguirNum1:
	mov si,85h
	mov bl,byte ptr es:[si] ; Muevo el numero1 que se escribio a bl. Si es menor que el caracter 0 o mayor que el caracter 9 entonces no es valido y da error porque no es un numero.
	cmp bl,'0'
	jl errorNumeroX
	cmp bl,'9'
	jg errorNumeroX
	sub bl,'0' ; Si es valido, entonces lo convierto a entero y lo muevo a la variable numero.
	mov numero,bl
conseguirNum2:
	mov si,87h
	mov bl,byte ptr es:[si] ; Muevo el numero2 que se escribio a bl. Si es menor que el caracter 0 o mayor que el caracter 9 entonces no es valido y da error porque no es un numero.
	cmp bl,'0'
	jl errorNumeroX
	cmp bl,'9'
	jg errorNumeroX
	sub bl,'0'
	mov numero2,bl ; Si es valido, entonces lo convierto a entero y lo muevo a la variable numero2.
	jmp conseguirLargoCortarSubstring ; Procedo a conseguir el largo del string.
errorNumeroX:
	lea dx,errornum ; Despliega el error si el numero no era valido.
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h
conseguirLargoCortarSubstring:
	push cx ; Usando el procedimiento ya explicado, saco el largo del string para usarlo como contador luego.
	push ax
	push dx
	push di
	
	mov di,89h ; muevo la posicion 89h al destination index porque esa posicion es donde empieza la string.
	
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	dec cx
	
	cmp cx,9
	jle nueveOMenosCortarSubstring
	cmp cx,9
	jg mayorQueNueveCortarSubstring
	jmp volverCortarSubstring ; Si no es mayor a 9, no ocupo hacer divison ni multiplicacion y me salto el procedimiento de mayor que nueve
nueveOMenosCortarSubstring:
	mov largo2,cx ; El cx tiene el largo porque se uso scasb entonces se mueve a la variable largo2
	jmp volverCortarSubstring
mayorQueNueveCortarSubstring:
	mov ax,cx
	mov bx,10
	xor dx,dx
	div bx
	mov div1,ax
	mov div2,dx
	mov cx,10
	mul cx
	mov largo2,ax
	add ax,div2
	mov largo2,ax ; El cx tiene el largo porque se uso scasb entonces se mueve a la variable largo
	jmp volverCortarSubstring
volverCortarSubstring:
	pop cx
	pop ax
	pop dx
	pop di
	mov si,89h ; Se retornan los registros a sus estados originales y se mueve la posicion del string al source index para poder printearlo, por eso tambien se mueve 0 a bx
	mov bx,0
recorrerSubstring:
	cmp largo2,0 ; Se recorre el string sin printearlo para poder llegar al substring, esto usando al largo como contador
	je terminarCortarSubstring
	cmp numero,0 ; Si el numero dado es 0 entonces se llego a la posicion indicada donde se quiere sacar el substring entonces se salta a extrar esta
	je printearSubstring
	mov dl,byte ptr es:[si+bx]
	inc bx
	dec largo2
	dec numero
	jmp recorrerSubstring
printearSubstring:
	cmp numero2,0 ; Se usa la longitud de la substring como contador
	je recorrerSubstring2
	mov dl,byte ptr es:[si+bx] ; Se van printeando los caracteres del substring en un ciclo
	mov ah,2
	int 21h
	inc bx
	dec largo2
	dec numero2
	jmp printearSubstring
recorrerSubstring2:
	cmp largo2,0 ; Se termina de recorrer lo que queda del string y luego se termina el programa
	je terminarCortarSubstring
	mov dl,byte ptr es:[si+bx]
	inc bx
	dec largo2
	jmp recorrerSubstring2
terminarCortarSubstring:
	ret
cortarSubstringX endP

recortarSubstringR Proc
	cmp letra,'R' ; Si la letra no es R, se termina el programa
	jne terminarRecortarSubstring
conseguirNum1RecortarSubstring:
	mov si,85h
	mov bl,byte ptr es:[si] ; Muevo el numero de la posicion a la variable numero, pero si es menor que el caracter 0 o mayor que el caracter 9 entonces no es valido y da error
	cmp bl,'0'
	jl errorNumeroR
	cmp bl,'9'
	jg errorNumeroR
	sub bl,'0'
	mov numero,bl
conseguirNum2RecortarSubstring:
	mov si,87h
	mov bl,byte ptr es:[si] ; Muevo el numero de la longitud a la variable numero, pero si es menor que el caracter 0 o mayor que el caracter 9 entonces no es valido y da error
	cmp bl,'0'
	jl errorNumeroR
	cmp bl,'9'
	jg errorNumeroR
	sub bl,'0'
	mov numero2,bl
	jmp conseguirLargoRecortarSubstring
errorNumeroR:
	lea dx,errornum ; Despliega un error si un numero dado es invalido
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h
conseguirLargoRecortarSubstring:
	push cx ; Se usa el mismo procedimiento usando scasb que en las otras rutinas para sacar el largo del string que esta en la posicion 89h, esta la muevo al di
	push ax
	push dx
	push di
	
	mov di,89h
	
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	dec cx
	
	cmp cx,9
	jle nueveOMenosRecortarSubstring
	cmp cx,9
	jg mayorQueNueveRecortarSubstring
	jmp volverRecortarSubstring
nueveOMenosRecortarSubstring:
	mov largo2,cx ; Muevo el largo que se guarda en el cx a largo2
	jmp volverRecortarSubstring
mayorQueNueveRecortarSubstring:
	mov ax,cx ; Si el largo es mayor que 9 entonces uso division y multiplicacion para calcularlo usando el cociente y residuo y luego lo muevo a la variable largo2
	mov bx,10
	xor dx,dx
	div bx
	mov div1,ax
	mov div2,dx
	mov cx,10
	mul cx
	mov largo2,ax
	add ax,div2
	mov largo2,ax
	jmp volverRecortarSubstring
volverRecortarSubstring:
	pop cx
	pop ax
	pop dx
	pop di
	mov si,89h ; Restauro los registros usados y muevo el inicio del string a 89h
	mov bx,0
recorrerRecortarSubstring:
	cmp largo2,0 ; Uso el largo2 como contador y voy printeando los caracteres del string hasta que el contador numero es 0, eso significa que ya llegue a la posicion del caracter donde empieza el substring
	je terminarRecortarSubstring
	cmp numero,0
	je printearRecortarSubstring ; Salto al procedimiento de recortar el substring
	mov dl,byte ptr es:[si+bx]
	mov ah,2
	int 21h
	inc bx
	dec largo2
	dec numero
	jmp recorrerRecortarSubstring
printearRecortarSubstring:
	cmp numero2,0 ; Usando la longitud de la substring como contador, recorro la substring sin printearla para quitarla del string
	je recorrerRecortarSubstring2 ; Vuelvo a ir a printear lo que queda del string cuando el contador es 0
	mov dl,byte ptr es:[si+bx]
	inc bx
	dec largo2
	dec numero2
	jmp printearRecortarSubstring
recorrerRecortarSubstring2:
	cmp largo2,0 ; Printeo lo que queda del string hasta que se acaba el largo del string y luego termina
	je terminarRecortarSubstring
	mov dl,byte ptr es:[si+bx]
	mov ah,2
	int 21h
	inc bx
	dec largo2
	jmp recorrerRecortarSubstring2
terminarRecortarSubstring:
	ret
recortarSubstringR endP

eliminarCharE Proc
	cmp letra,'E' ; Si la letra no es E, termina de una vez
	jne terminarEliminarChar
getCharEliminar:
	mov si,85h
	mov bl,byte ptr es:[si] ; Muevo el char que se dio a char1 a menos que no sea un char, lo que se valida comparando si es menor a A o mayor a Z, si esto se cumple entonces es invalido y da error
	mov char1,bl
	cmp char1,'A'
	jl errorCharE
	cmp char1,'z'
	jg errorCharE
	jmp getLargoStringEliminar
errorCharE:
	lea dx,errorchar ; Despliega el error
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h
getLargoStringEliminar:
	push cx ; Se usa el procedimiento usado en las otras rutinas para sacar el largo de la string para luego usarla como contador. La posicion donde empieza el string es 87h
	push ax
	push dx
	push di
	
	mov di,87h
	
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	dec cx
	
	cmp cx,9
	jle nueveOMenosEliminarChar
	cmp cx,9
	jg mayorQueNueveEliminarChar
	jmp volverEliminarChar
nueveOMenosEliminarChar:
	mov largo2,cx
	jmp volverEliminarChar
mayorQueNueveEliminarChar:
	mov ax,cx
	mov bx,10
	xor dx,dx
	div bx
	mov div1,ax
	mov div2,dx
	mov cx,10
	mul cx
	mov largo2,ax
	add ax,div2
	mov largo2,ax
	jmp volverEliminarChar
volverEliminarChar:
	pop cx
	pop ax
	pop dx
	pop di
	mov si,87h ; Ya se saco el largo y se guardo en largo2 entonces se restauran los registros y se mueve el inicio de la string al source index para printear
	mov bx,0
printearStringEliminar:
	cmp largo2,0 ; Se usa el largo del string como contador
	je terminarEliminarChar
	mov dl,byte ptr es:[si+bx]
	cmp dl,char1 ; Si el caracter sacado del string es igual al char1, se salta al procedimiento para quitarlo del string
	je quitarChar
	mov ah,2
	int 21h
	inc bx
	dec largo2 ; Se decrementa el contador largo2
	jmp printearStringEliminar ; Se loopea
quitarChar:
	inc bx ; Para quitar el char del string, solo se incrementa el bx y se decrementa el contador, asi ya el char no se printea y se quito del string correctamente
	dec largo2
	jmp printearStringEliminar
terminarEliminarChar:
	ret
eliminarCharE endP

clonarCharC Proc
	cmp letra,'C' ; Si la letra escrita no es C, se termina el programa
	jne terminarClonarChar
getCharClonar:
	mov si,85h ; Se mueve el char al source index, el cual esta en la posicion 85h
	mov bl,byte ptr es:[si] ; Muevo el char que se escribio al bl. Si es menor al caracter A o mayor a z entonces es invalido porque no es un caracter valido
	mov char1,bl
	cmp char1,'A'
	jl errorCharC
	cmp char1,'z'
	jg errorCharC
getNumClonar:
	mov si,87h ; Se mueve el numero de veces que se quiere clonar el char al source index. Este esta en la posicion 87h entonces se mueve eso al si.
	mov bl,byte ptr es:[si]
	cmp bl,'0' ; Si el numero es menor al caracter 0 o mayor al caracter 9 entonces es un numero invalido y da error.
	jl errorNumC
	cmp bl,'9'
	jg errorNumC
	mov numero,bl
	sub numero,'0' ; Si es valido entonces se hace entero y se procede a conseguir el largo del string.
	jmp getLargoStringClonar
errorCharC:
	lea dx,errorchar ; Despliega el error de char invalido.
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h
errorNumC:
	lea dx,errornum ; Despliega el error de numero invalido.
	mov ah,9h
	int 21h
	mov ah,4ch
	int 21h
getLargoStringClonar:
	push cx ; Usando el mismo procedimiento ya expliado, se consigue el largo del string dado. El string empieza en 89h entonces se mueve 89h al destination index ya que scasb usa el destination index.
	push ax
	push dx
	push di
	
	mov di,89h
	
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	dec cx
	
	cmp cx,9
	jle nueveOMenosClonarChar
	cmp cx,9
	jg mayorQueNueveClonarChar
	jmp volverClonarChar
nueveOMenosClonarChar:
	mov largo2,cx ; Se guarda el largo en la variable largo2
	jmp volverClonarChar
mayorQueNueveClonarChar:
	mov ax,cx
	mov bx,10
	xor dx,dx
	div bx
	mov div1,ax
	mov div2,dx
	mov cx,10
	mul cx
	mov largo2,ax
	add ax,div2
	mov largo2,ax ; Se guarda el largo en la variable largo2
	jmp volverClonarChar
volverClonarChar:
	pop cx
	pop ax
	pop dx
	pop di
	mov si,89h ; Se restauran los registros con pop y se mueve el incio del string (que esta en 89) al source index para printear el string
	mov bx,0
	mov cl,numero
printearStringClonar:
	cmp largo2,0 ; Usa el largo del string como contador. Mientras no es 0, printea los chars del string, y si encuentra uno igual al char1, va al procedimiento de clonar.
	je terminarClonarChar ; Si el contador es 0 entonces se termina.
	mov dl,byte ptr es:[si+bx]
	cmp dl,char1 ; Si el caracter del string es igual al char1 dado por el usuario, salta al procedimiento de clonar.
	je repetirChar
	mov ah,2 ; Se printean los chars del string.
	int 21h
	inc bx
	dec largo2
	jmp printearStringClonar
repetirChar:
	cmp numero,0 ; Usa el num que se dio como contador, mientras no es 0 printea el caracter que se desea clonar esa cantidad de veces.
	je printearStringClonarPrep ; Cuando el numero se hace 0, va al procedimiento donde se prepara para seguir printeando el string.
	mov ah,2
	int 21h
	dec numero
	jmp repetirChar
printearStringClonarPrep:
	inc bx ; Se incrementa el bx y se decrementa el contador de largo, ademas se vuelve a mover el num dado por el usuario a la variable numero para poder volver a usarlo como contador. Luego se vuelve a ir a printear el string.
	dec largo2
	mov numero,cl
	jmp printearStringClonar
terminarClonarChar:
	ret
clonarCharC endP

anagramasA Proc
	cmp letra,'A' ; Si la letra dada no es A entonces termina.
	jne terminarAnagramas
largoAnagramas:
	push cx ; Usando el procedimiento usado en las otras rutinas, se saca el largo del string.
	push ax
	push dx
	push di
	
	mov di,85h ; Se guardan los registros y se mueve el inicio del string al destination index. Como el inicio del string es 85h, se mueve eso al di.
	
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	dec cx
	
	cmp cx,9
	jle nueveOMenosAnagramas
	cmp cx,9
	jg mayorQueNueveAnagramas
	jmp volverAnagramas
nueveOMenosAnagramas:
	mov largo2,cx ; Luego de usar scasb el largo se guarda en cx y eso se guarda en largo2
	jmp volverAnagramas
mayorQueNueveAnagramas:
	mov ax,cx
	mov bx,10
	xor dx,dx
	div bx
	mov div1,ax
	mov div2,dx
	mov cx,10
	mul cx
	mov largo2,ax
	add ax,div2
	mov largo2,ax ; Luego de usar scasb el largo se guarda en cx y eso se guarda en largo2
	jmp volverAnagramas
volverAnagramas:
	pop cx
	pop ax
	pop dx
	pop di ; Se restauran los registros y luego se mueve el inicio del string en 85h al source index
	mov si,85h
	mov bx,0 ; Se mueve 0 a bx para usarlo como contador
printearStringAnagramas:
	cmp largo2,0 ; Se usa el largo del string como contador. Cuando se hace 0, se termina.
	je terminarAnagramas
	mov dl,byte ptr es:[si+bx] ; Se van moviendo los caracteres del string al dl y luego se les hace print.
	mov ah,2
	int 21h
	inc bx
	lea dx,espacio ; Se despliega un espacio para separar los caracteres. Esto permite hacer que despliege todos los caracteres de la palabra por separado.
	mov ah,9h
	int 21h
	dec largo2
	jmp printearStringAnagramas ; Se decrementa el largo cada loop y se loopea con un jump.
terminarAnagramas:
	ret
anagramasA endP

buscarposicionF Proc
	cmp letra,'F' ; Si la letra que se escribio no es F entonces termina
	jne terminarBuscarPosicion
getChar1String1BuscarPosicion:
	mov si,85h ; Muevo el inicio del string1 que es en 85h al source index 
	mov dl,byte ptr es:[si] ; Muevo el char1 que escribio el usuario a dl para luego moverla a la variable letra
	mov char1,dl 
	mov bx,0
getChar1String2BuscarPosicion:
	cmp dl,'#' ; Recorro el string hasta encontrar el simbolo de gato y al sumarle uno a esa posicion, ese es el inicio del string2
	je InicioString2
	mov dl,byte ptr es:[si+bx]
	inc bx
	jmp getLargoString2BuscarPosicion
getLargoString2BuscarPosicion:
	push cx ; Uso el procedimiento que uso en las otras rutinas para conseguir el largo del string2
	push ax
	push dx
	push di
	push bx
	
	mov di,85h
	add di,bx
	
	sub cx,cx
	not cx
	sub al,al
	
	cld
	repne scasb
	not cx
	dec cx
	dec cx
	
	cmp cx,9
	jle nueveOMenosBuscarPosicion
	cmp cx,9
	jg mayorQueNueveBuscarPosicion
	jmp volverBuscarPosicion
nueveOMenosBuscarPosicion:
	mov largo2,cx
	jmp volverBuscarPosicion
mayorQueNueveBuscarPosicion:
	mov ax,cx
	mov bx,10
	xor dx,dx
	div bx
	mov div1,ax
	mov div2,dx
	mov cx,10
	mul cx
	mov largo2,ax
	add ax,div2
	mov largo2,ax
	jmp volverBuscarPosicion
volverBuscarPosicion:
	pop cx
	pop ax
	pop dx
	pop di
	pop bx
	mov si,85h ; Ahora que ya tengo el largo, muevo el inicio del string1 al si y le sumo bx porque bx tiene la cantidad de caracteres que toma para llegar al inicio del string2.
	add si,bx
	mov bx,0
	mov cl,numero
	xor dl,dl
InicioString2:
	cmp largo2,0 ; Uso el largo como contador hasta que sea 0, en cuyo caso no se encontro
	je noEncontrado
	cmp dl,char1 ; Si el caracter que se consiguio del si es igual al char1, entonces si se encontro
	je encontrado

	mov dl,byte ptr es:[si+bx] ; Cada loop consigo un caracter del string y lo voy comparando con el char1
	inc bx
	dec largo2
	jmp InicioString2
encontrado:
	lea dx,found ; Despliego que si lo encontre
	mov ah,9h
	int 21h
	jmp terminarBuscarPosicion
noEncontrado:
	lea dx,notfound ; Despliego que no lo encontre
	mov ah,9h
	int 21h
terminarBuscarPosicion:
	ret
buscarposicionF endP

findReplaceK Proc
	cmp letra,'K' ; Si la letra no es K, termino
	jne terminarFindReplace
getChar1String1FindReplace:
	mov si,85h
	mov dl,byte ptr es:[si] ; Muevo el primer caracter del string1 que escribio el usuario a dl para luego moverla a la variable char1
	mov char1,dl
	mov bx,0 ; Muevo 0 al bx para usarlo con el si
getChar1String2FindReplace:
	cmp dl,'#' ; Recorro el string2 y cuando encuentro el caracter de gato salto a conseguir el string2
	je char1String2Es
	mov dl,byte ptr es:[si+bx]
	inc bx
	jmp getChar1String2FindReplace
char1String2Es:
	mov dl,byte ptr es:[si+bx] ; Agarro el primer caracter del string2 y lo pongo en char2
	mov char2,dl
getChar1String3:
	cmp dl,'#' ; Recorro lo escrito por el usuario en el si hasta encontrar el gato y le sumo uno al bx, ese es el inicio del string3
	je inicioString3
	mov dl,byte ptr es:[si+bx]
	inc bx
	jmp getChar1String3
inicioString3:
	cmp dl,20h ; Printeo el string3 hasta que ya se encontro el caracter null, y luego termino
	jl terminarFindReplace
	cmp dl,char1 ; Si el caracter es igual al primer caracter del string1, lo remplazo
	je remplazarFindReplace
	mov dl,byte ptr es:[si+bx]
	mov ah,2 ; Voy printeando el string3
	int 21h
	inc bx
	mov dl,byte ptr es:[si+bx]
	jmp inicioString3
remplazarFindReplace:
	mov dl,char2 ; Remplazo el primer caracter de1 string1 con el segundo caracter del string2
	mov ah,2
	int 21h
	inc bx
	jmp inicioString3 ; Sigo printeando lo que queda del string3
terminarFindReplace:
	ret
findReplaceK endP

main:

	mov ax,ds ; Se mueve ds a es
	mov es,ax

	mov ax,data ; Inicializa el data segment mandandolo al ds register
	mov ds,ax

	mov ax,pila ; Inicializa la pila mandandola al ss register
	mov ss,ax
	
	lea dx,acercade ; Despliega el acerca de
	mov ah,9h
	int 21h
	
	mov si,82h
	mov bl,byte ptr es:[si+1] ; Muevo la letra que escribio el usuario a bl para luego moverla a la variable letra
	mov letra,bl
	
	cmp letra,'H' ; Si la letra que se escribio es H, o no se escribio nada, entonces muestra la ayuda
	je mostrarAyuda
	cmp letra,20h
	jl mostrarAyuda
	
	cmp letra,'L' ; Si se escribio L, hace call a largoStringL
	je largoString
	
	cmp letra,'I' ; Si se escribio I, hace call a insertarStringI
	je insertarString
	
	cmp letra,'Y' ; Si se escribio Y, hace call a remplazarStringY
	je remplazarString
	
	cmp letra,'Q' ; Si se escribio Q, hace call a remplazarCharQ
	je remplazarChar
	
	cmp letra,'X' ; Si se escribio X, hace call a cortarSubstringX
	je cortarSubstring
	
	cmp letra,'R' ;  Si se escribio R, hace call a recortarSubstringR
	je recortarSubstring
	
	cmp letra,'E' ; Si se escribio E, hace call a eliminarCharE
	je eliminarChar
	
	cmp letra,'C' ; Si se escribio C, hace call a clonarCharC
	je clonarChar
	
	cmp letra,'A' ; Si se escribio A, hace call a anagramasA
	je anagramas
	
	cmp letra,'F' ; Si se escribio F, hace call a buscarPosicionF
	je buscarPosicion
	
	cmp letra,'K' ; Si se escribio K, hace call a findReplaceK
	je findReplace
	
	jmp darError ; Si no se escribio una opcion valida, va al procedimiento de desplegar un error de opcion invalida

mostrarAyuda:                  ; Todos estos procedimientos simplemente llaman a la rutina que se escogio dependiendo de la letra escrita, y luego del return saltan al procedimiento de terminar el programa
	call mostrarAyudaH
	jmp terminarMain
largoString:
	call largoStringL
	jmp terminarMain
insertarString:
	call insertarStringI
	jmp terminarMain
remplazarString:
	call remplazarStringY
	jmp terminarMain
remplazarChar:
	call remplazarCharQ
	jmp terminarMain
cortarSubstring:
	call cortarSubstringX
	jmp terminarMain
recortarSubstring:
	call recortarSubstringR
	jmp terminarMain
eliminarChar:
	call eliminarCharE
	jmp terminarMain
clonarChar:
	call clonarCharC
	jmp terminarMain
anagramas:
	call anagramasA
	jmp terminarMain
buscarPosicion:
	call buscarposicionF
	jmp terminarMain
findReplace:
	call findReplaceK
	jmp terminarMain

darError:
	lea dx,errorletra ; Si no se escogio ninguna letra de opcion valida, se despliega un error diciendo eso y luego termina
	mov ah,9h
	int 21h
	
terminarMain:
	mov ah,4ch ; Hace interrupt para hacer exit hacia DOS para terminar el programa
	int 21h

code ends

end main
org 100h

jmp code
w equ 200 ; dimensiune dreptunghi
h equ 20                    
m equ 60
code: mov ah, 0
mov al, 13h ; trecere in mod grafic 320x200
int 10h

; afisare latura superioara
mov cx, 75+w ; coloana
mov dx, 40+h ; rand
mov al, 15 ; alb
u1: mov ah, 0ch ; afisare pixel
int 10h
dec cx
cmp cx, 50
jae u1                     


; afisare latura inferioare
mov cx, 50+w
mov dx, 140+h
mov al, 15
u2: mov ah, 0ch
int 10h
dec cx
cmp cx, 75
ja u2


; latura din stanga
mov cx, 75
mov dx, 140+h
mov al, 15
u3: mov ah, 0ch
int 10h
dec dx
cmp dx, 40+h
ja u3


; latura din dreapta
mov cx,  50+w
mov dx, 140+h
mov al, 15

u4: mov ah, 0ch
int 10h
dec dx
cmp dx, 40+h
ja u4                              

; latura din stanga usa
mov cx, 140
mov dx, 160
mov al, 15
u5: mov ah, 0ch
int 10h
dec dx
cmp dx, 100
ja u5                   

; afisare latura superioara usa
mov cx, 140
mov dx, 100
mov al, 15
u6: mov ah, 0ch
int 10h
inc cx
cmp cx, 170 
jb u6
        
; afisare latura dreapta usa
mov cx, 170
mov dx, 100
mov al, 15
u7: mov ah, 0ch
int 10h
inc dx
cmp dx, 160 
jb u7       



; afisare fereastra stanga    
; afisare latura superioara geam1
mov cx, 50+m ; coloana
mov dx, 20+m ; rand
mov al, 15 ; alb
u8: mov ah, 0ch ; afisare pixel
int 10h
dec cx
cmp cx, 25+m
jae u8                     


; afisare latura inferioare geam 1
mov cx, 50+m
mov dx, 45+m
mov al, 15
u9: mov ah, 0ch
int 10h
dec cx
cmp cx, 25+m
ja u9


; latura din stanga  geam1
mov cx, 25+m
mov dx, 45+m
mov al, 15
u10: mov ah, 0ch
int 10h
dec dx
cmp dx, 20+m
ja u10


; latura din dreapta   geam1
mov cx,  50+m
mov dx,  45+m
mov al, 15

u11: mov ah, 0ch
int 10h
dec dx
cmp dx, 20+m
ja u11                   
                            
                            
                            
                            
; afisare fereastra dreapta
; afisare latura superioara geam2
mov cx, 170+m ; coloana
mov dx, 20+m ; rand
mov al, 15 ; alb
u12: mov ah, 0ch ; afisare pixel
int 10h
dec cx
cmp cx, 145+m
jae u12                     


; afisare latura inferioare    geam2
mov cx, 170+m
mov dx, 45+m
mov al, 15
u13: mov ah, 0ch
int 10h
dec cx
cmp cx, 145+m
ja u13


; latura din stanga         geam2
mov cx, 145+m
mov dx, 45+m
mov al, 15
u14: mov ah, 0ch
int 10h
dec dx
cmp dx, 20+m
ja u14


; latura din dreapta       geam2
mov cx,  170+m
mov dx,  45+m
mov al, 15
u15: mov ah, 0ch
int 10h
dec dx
cmp dx, 20+m
ja u15                        

; I geam 1

mov cx,98
mov dx, 105
mov al, 15
u16: mov ah, 0ch
int 10h
dec dx
cmp dx, 80
ja u16                       
           
           
; -- geam 1

mov cx,110
mov dx, 93
mov al, 15
u17: mov ah, 0ch
int 10h
dec cx
cmp cx, 85      
ja u17          


; acoperis    stanga-dreapta
mov cx, 50
mov dx, 60
mov al, 15
a:   	mov ah, 0ch
    	int 10h
        dec dx
        inc cx
        mov ah, 0ch
        int 10h
        inc cx
        cmp dx, 4
        jne a      
        
; acoperis dreapta-stanga
mov cx, 273
mov dx, 60
mov al, 15
b:   	mov ah, 0ch
    	int 10h
        dec dx
        dec cx
        mov ah, 0ch
        int 10h
        dec cx
        cmp dx, 4
        ja b  
        
        
;alerta terminare desen bloc
mov ah, 02
mov dx, 07h
int 21h    
mov ah, 02
mov dx, 07h
int 21h       
mov ah, 02
mov dx, 07h
int 21h             

jmp puncte
        
        
        

;desen puncte cu mouse 

oldX dw -1
oldY dw 0
puncte: mov AH, 0
      mov AL, 13h ; afisarea in mod grafic 320x200
      int 10h 
mov ax, 0 ; initializarea mouese -ului
int 33h
cmp ax, 0

verificare_mouse:
mov ax, 3
int 33h ; preluarea pozitiei
shr cx, 1 
cmp bx, 1
jne xor_cursor:
mov al, 02h ; culoarea verde
jmp draw_pixel
xor_cursor:
cmp oldX, -1
je not_required
push cx
push dx
mov cx, oldX
mov dx, oldY
mov ah, 0dh
int 10h
xor al, 1111b
mov ah, 0ch
int 10h
pop dx
pop cx
not_required:
mov ah, 0dh
int 10h
xor al, 1111b
mov oldX, cx
mov oldY, dx
draw_pixel:
mov ah, 0ch
int 10h
check_esc_key:
mov dl, 255
mov ah, 6
int 21h
cmp al, 27 ; 
jne verificare_mouse  

stop:

mov ax, 3 
int 10h
mov ah, 1
mov ch, 0
mov cl, 8
int 10h
mov dx, offset msg
mov ah, 9
int 21h
mov ah, 0
int 16h
msg db " press any key.... $"        
 
; asteptare apasare tasta
mov ah,00
int 16h

ret
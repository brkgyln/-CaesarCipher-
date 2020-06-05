;;;;;;;;;;;;; CaesarCipher.asm ;;;;;;;;;;;;;;;
;;; Sezar Sifreleme 
;;; shift =3 
;;; abcdefghiklmnopqrstuwxyz 
;;; defghijklnopqrstuvwxzabc
.model small

.data
yaz1 db "5 harf giriniz: $"  
yaz2 db 10,13,"Sifrelenmis metin: $"                      
dizi1 db 5 dup (00)    ; dizi1 icin 5byte ayir        
dizi2 db 5 dup(00),'$' ; dizi2 icin 5byte ayir. 

.code

sezar macro al
   cmp al,'z' ; AL > 'z' ?
   ja cik     ; evet ise harf degil cik                         
   cmp al,'A' ; AL < 'A' ?  
   jb cik     ; evet ise harf degil cik    
   CMP AL,'Z' ; al = "Z" ?
   je azalt   ; esitse azalta git Z'yi C yap(al-23)
   cmp al,'z' ; al = 'z' ?
   je azalt   ; esitse azalta git z'yi c  yap
   cmp al,'Y' ; al = "Y" ?
   je azalt   ; esitse azalta git
   cmp al,'y' ; al= "y"?
   je azalt   ; esitse azalta git
   cmp al,'X' ; al = "X" ?
   je azalt   ; esitse azalta git
   cmp al,'x' ; al = "x" ?
   je azalt   ; esitse azalta git
   
; girilen harf xyzZYX degilse 3 ekle(shift miktari)
   add al,3 ;  
   jmp cik
; girilen harf ZYXxyz ise alden asci olarak 23 cikarilirsa z>c y>b x>a olur
   azalt:
   sub al,23 
   jmp cik
   cik:
   endm           

   
   mov ax,@data  
   mov ds,ax      ; ds data segmenti gosterdi.
   lea si,dizi1   ; mov si, ofset dizi1
   lea di,dizi2   ; mov dii ofset dizi2

;ekrana 5 harf giriniz yazdir   
   mov ah,09h
   lea dx,yaz1
   int 21h
   
   mov cx,0005  ; sayac ayarlaniyor

; klavye girisi 

   giris: 
   mov ah,01h
   int 21h                                                                                                                                                         
   mov [si], al      ; b)> girilen her harfin data segmentteki dizi1'e aktarimi 
   inc si 
   loop giris                      
   
   mov dx,0000
   mov cx,0005  ; sayac tekrar ayarlaniyor
   lea si,dizi1
   

; Sezar sifrelemesinin kodlanmasi ve datasegmentte ayri diziye aktarimi
;dizi1deki her elemani sezar macrosuna gonder
;sifrelenmis her harfi yeni diziye ata   
   cev: mov al, [si] 
   sezar al      
   mov [di],al
   inc si  
   inc di
   loop cev     
   
;ekrana yaz2 icerigini("sifrelenmis metin") yazdirma
   mov ah,09h 
   lea dx,yaz2 
   
   int 21h 
    
; Sifrelenmis icerigin ekrana yazilmasi
;ekrana sifrelenmis metnimizi(dizi2) yazdirma
   mov ah,09h
   lea dx,dizi2
   int 21h   
       
;cikis
   mov ah, 4ch
   int 21h
   end

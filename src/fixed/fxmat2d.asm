;****************************************************************************
;*
;*                High Speed Fixed/Floating Point Library
;*
;*  ========================================================================
;*
;*   Copyright (C) 1991-2004 SciTech Software, Inc. All rights reserved.
;*
;*   This file may be distributed and/or modified under the terms of the
;*   GNU General Public License version 2.0 as published by the Free
;*   Software Foundation and appearing in the file LICENSE.GPL included
;*   in the packaging of this file.
;*
;*   Licensees holding a valid Commercial License for this product from
;*   SciTech Software, Inc. may use this file in accordance with the
;*   Commercial License Agreement provided with the Software.
;*
;*   This file is provided AS IS with NO WARRANTY OF ANY KIND, INCLUDING
;*   THE WARRANTY OF DESIGN, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
;*   PURPOSE.
;*
;*   See http://www.scitechsoft.com/license/ for information about
;*   the licensing options available and how to purchase a Commercial
;*   License Agreement.
;*
;*   Contact license@scitechsoft.com if any conditions of this licensing
;*   are not clear to you, or you have questions about licensing options.
;*
;*  ========================================================================
;*
;* Language:    NASM
;* Environment: IBM PC (MS DOS)
;*
;* Description: This module contains routines for high performance 16.16
;*              fixed point 2D transformation matrix manipulation routines:
;*
;*                  F386_scale2D        - Concat a 2D scale matrix
;*                  F386_scaleAbout2D   - Concat a 2D scale about matrix
;*                  F386_rotate2D       - Concat a 2D rotate matrix
;*                  F386_rotateAbout2D  - Concat a 2D rotate about matrix
;*                  F386_concat3x3      - Concat two 3x3 matrices
;*
;****************************************************************************

%include "scitech.mac"          ; Memory model macros
%include "fxmacs.mac"

header  fxmat2d                 ; Set up memory model

section .text

;----------------------------------------------------------------------------
; void F386_scale2D(long *m,long xscale,long yscale)
;----------------------------------------------------------------------------
; Concatenate a scale transformation efficiently to the current
; transformation matrix. The bottom row is assumed to be <0,0,1>.
;----------------------------------------------------------------------------
cprocstart  F386_scale2D

        %arg     m:DPTR, xscale:ULONG, yscale:ULONG

        enter_c

        mov     esi,[m]         ; esi -> xform matrix
        mov     ebx,[xscale]    ; EBX := x scale factor

%assign off 0
%rep 3
        mov     eax,[esi+off]
        imul    ebx             ; EDX:EAX := mat[0][off] * xscale
        ROUNDIT
        mov     [esi+off],eax   ; Store result
%assign off off+4
%endrep

        mov     ebx,[yscale]    ; EBX := y scale factor

%rep 3
        mov     eax,[esi+off]
        imul    ebx             ; EDX:EAX := mat[1][off] * yscale
        ROUNDIT
        mov     [esi+off],eax   ; Store result
%assign off off+4
%endrep

        leave_c
        ret

cprocend

;----------------------------------------------------------------------------
; void F386_scaleAbout2D(long *m,long xscale,long yscale,long x,long y)
;----------------------------------------------------------------------------
; Concatenate a scale transformation efficiently to the current
; transformation matrix. The bottom row is assumed to be <0,0,1>.
;----------------------------------------------------------------------------
cprocstart  F386_scaleAbout2D

        %arg     m:DPTR, xscale:ULONG, yscale:ULONG, x:ULONG, y:ULONG

        enter_c

        mov     esi,[m]         ; esi -> xform matrix
        mov     ebx,[xscale]    ; EBX := x scale factor

        mov     eax,[esi]
        imul    ebx             ; EDX:EAX := mat[0][0] * xscale
        ROUNDIT
        mov     [esi],eax       ; Store result
        mov     eax,[esi+4]
        imul    ebx             ; EDX:EAX := mat[0][1] * xscale
        ROUNDIT
        mov     [esi+4],eax     ; Store result
        mov     eax,[esi+8]
        imul    ebx             ; EDX:EAX := mat[0][1] * xscale
        ROUNDIT
        sub     ebx,10000h
        neg     ebx             ; EBX := 1 - xscale
        xchg    eax,ebx         ; EBX := mat[0][1] * xscale
        imul    dword [x]       ; EDX:EAX := x * (1 - xscale)
        ROUNDIT
        add     eax,ebx
        mov     [esi+8],eax     ; Store result

        mov     ebx,[yscale]    ; EBX := y scale factor

        mov     eax,[esi+12]
        imul    ebx             ; EDX:EAX := mat[0][0] * xscale
        ROUNDIT
        mov     [esi+12],eax    ; Store result
        mov     eax,[esi+16]
        imul    ebx             ; EDX:EAX := mat[0][1] * xscale
        ROUNDIT
        mov     [esi+16],eax    ; Store result
        mov     eax,[esi+20]
        imul    ebx             ; EDX:EAX := mat[0][1] * xscale
        ROUNDIT
        sub     ebx,10000h
        neg     ebx             ; EBX := 1 - xscale
        xchg    eax,ebx         ; EBX := mat[0][1] * xscale
        imul    dword [y]       ; EDX:EAX := x * (1 - xscale)
        ROUNDIT
        add     eax,ebx
        mov     [esi+20],eax    ; Store result

        leave_c
        ret

cprocend

;----------------------------------------------------------------------------
; void F386_rotate2D(long *T,long *m,long Sin,long Cos)
;----------------------------------------------------------------------------
; Concatenate a rotate transformation efficiently to the current
; transformation matrix. The bottom row is assumed to be <0,0,1>.
;----------------------------------------------------------------------------
cprocstart  F386_rotate2D

        %arg     T:DPTR, m:DPTR, Sin:ULONG, Cos:ULONG

        enter_c

        mov     esi,[m]         ; esi -> xform matrix
        mov     edi,[T]         ; edi -> resultant temporary matrix

%assign off 0
%rep 3
        mov     eax,[esi+off]
        imul    dword [Cos]
        mov     ecx,eax         ; EBX:ECX := mat[0][off] * Cos
        mov     ebx,edx
        mov     eax,[esi+off+12]
        imul    dword [Sin]
        sub     ecx,eax         ; EBX:ECX := mat[0][off] * Cos - mat[1][off] * Sin
        sbb     ebx,edx
        ROUNDIT_EBX_ECX
        mov     [edi+off],eax; Store result
%assign off off+4
%endrep

%assign off 0
%rep 3
        mov     eax,[esi+off]
        imul    dword [Sin]
        mov     ecx,eax         ; EBX:ECX := mat[0][off] * Sin
        mov     ebx,edx
        mov     eax,[esi+off+12]
        imul    dword [Cos]
        add     eax,ecx         ; EDX:EAX := mat[1][off] * Cos + mat[0][off] * Sin
        adc     edx,ebx
        ROUNDIT
        mov     [edi+off+12],eax; Store result
%assign off off+4
%endrep

        leave_c
        ret

cprocend

;----------------------------------------------------------------------------
; void F386_rotateAbout2D(long *T,long *m,long Sin,long Cos,long x,long y)
;----------------------------------------------------------------------------
; Concatenate a rotate transformation efficiently to the current
; transformation matrix. The bottom row is assumed to be <0,0,1>.
;----------------------------------------------------------------------------
cprocstart  F386_rotateAbout2D

        %arg     T:DPTR, m:DPTR, Sin:ULONG, Cos:ULONG, x:ULONG, y:ULONG

        enter_c

        mov     esi,[m]         ; esi -> xform matrix
        mov     edi,[T]         ; edi -> resultant temporary matrix

%assign off 0
        %rep 2
        mov     eax,[esi+off]
        imul    dword [Cos]
        mov     ecx,eax         ; EBX:ECX := mat[0][off] * Cos
        mov     ebx,edx
        mov     eax,[esi+off+12]
        imul    dword [Sin]
        sub     ecx,eax         ; EBX:ECX := mat[0][off] * Cos - mat[1][off] * Sin
        sbb     ebx,edx
        ROUNDIT_EBX_ECX
        mov     [edi+off],eax   ; Store result
%assign off off+4
        %endrep

        mov     eax,[esi+off]
        imul    dword [Cos]
        mov     ecx,eax         ; EBX:ECX := mat[0][off] * Cos
        mov     ebx,edx
        mov     eax,[esi+off+12]
        imul    dword [Sin]
        sub     ecx,eax         ; EBX:ECX := mat[0][off] * Cos - mat[1][off] * Sin
        sbb     ebx,edx
        mov     eax,10000h
        sub     eax,[Cos]       ; EAX := 1 - Cos
        imul    dword [x]       ; EAX := x * (1-Cos)
        add     ecx,eax         ; Add to total
        adc     ebx,edx
        mov     eax,[Sin]
        imul    dword [y]       ; EAX := y * Sin
        add     eax,ecx
        adc     edx,ebx
        ROUNDIT
        mov     [edi+off],eax; Store result

%assign off 0
        %rep 2
        mov     eax,[esi+off]
        imul    dword [Sin]
        mov     ecx,eax         ; EBX:ECX := mat[0][off] * Sin
        mov     ebx,edx
        mov     eax,[esi+off+12]
        imul    dword [Cos]
        add     eax,ecx         ; EDX:EAX := mat[1][off] * Cos + mat[0][off] * Sin
        adc     edx,ebx
        ROUNDIT
        mov     [edi+off+12],eax; Store result
%assign off off+4
        %endrep

        mov     eax,[esi+off]
        imul    dword [Sin]
        mov     ecx,eax         ; EBX:ECX := mat[0][off] * Sin
        mov     ebx,edx
        mov     eax,[esi+off+12]
        imul    dword [Cos]
        add     ecx,eax         ; EBX:ECX := mat[1][off] * Cos + mat[1][off] * Sin
        adc     ebx,edx
        mov     eax,10000h
        sub     eax,[Cos]       ; EAX := 1 - Cos
        imul    dword [y]       ; EAX := y * (1-Cos)
        add     ecx,eax         ; Add to total
        adc     ebx,edx
        mov     eax,[Sin]
        imul    dword [x]       ; EAX := x * Sin
        sub     ecx,eax
        sbb     ebx,edx
        ROUNDIT_EBX_ECX
        mov     [edi+off+12],eax; Store result

        leave_c
        ret

cprocend

;----------------------------------------------------------------------------
; void F386_concat3x3(long *result,long *m1,long *m2);
;----------------------------------------------------------------------------
; Concatenate (multiplies) the two fixed point 3x3 matrices together. We dont
; both to work out the bottom row of the matrix as it is always implicitly
; set to <0,0,1>.
;
; Note that we compute the result of each element in the matrix with 64 bit
; precision, and round the result once at the end (faster and more accurate).
;----------------------------------------------------------------------------
cprocstart  F386_concat3x3

        %arg     result:DPTR, m1:DPTR, m2:DPTR

        enter_c

        mov     esi,[m1]        ; esi -> matrix m1
        mov     edi,[m2]        ; edi -> matrix m2

; Set up two imbedded macros to code the unrolled loops to multiply the
; matrices.

%assign roff 0                  ; Row offset starts at zero
        %rep 2                  ; Repeat once for each row

%assign coff 0                  ; Column offset starts at zero
        %rep 2                  ; Do once for each of the first 2 columns

        mov     eax,[esi+roff]  ; EAX := m1.mat[roff][0]
        imul    dword [edi+coff]; EDX:EAX := m1.mat[roff][0] * m2.mat[0][coff]
        mov     ecx,eax
        mov     ebx,edx         ; EBX:ECX := running total

        mov     eax,[esi+roff+4]; EAX := m1.mat[roff][1]
        imul    dword [edi+12+coff]; EDX:EAX := m1.mat[roff][1] * m2.mat[1][coff]
        add     eax,ecx         ; Update running total
        adc     edx,ebx
        ROUNDIT

        mov     ebx,[result]
        mov     [ebx+roff+coff],eax ; result.mat[roff][coff] := EAX

%assign coff coff+4             ; Point to next column offset

        %endrep                 ; End of inner column loop

; Now do the third column by assuming that the all entries at [2][2] are
; set to 1.

        mov     eax,[esi+roff]  ; EAX := m1.mat[roff][0]
        imul    dword [edi+coff]; EDX:EAX := m1.mat[roff][0] * m2.mat[0][coff]
        mov     ecx,eax
        mov     ebx,edx         ; EBX:ECX := running total

        mov     eax,[esi+roff+4]; EAX := m1.mat[roff][1]
        imul    dword [edi+12+coff]; EDX:EAX := m1.mat[roff][1] * m2.mat[1][coff]
        add     eax,ecx         ; Update running total
        adc     edx,ebx
        ROUNDIT                 ; EAX := rounded result
        add     eax,[esi+roff+8]; Add in the translation

        mov     ebx,[result]
        mov     [ebx+roff+coff],eax ; result.mat[roff][coff] := EAX

%assign coff coff+4             ; Point to next column

%assign roff roff+12            ; Point to next row

        %endrep                 ; End of outer row loop

        leave_c
        ret

cprocend

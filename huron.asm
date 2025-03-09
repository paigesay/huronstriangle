; Program name: "Huron’s Triangles". A short description of the purpose of the program
; Copyright (C) 2025  Paige Saychareun

; This file is part of the software program "Program Name".

; "Program Name" is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; "Program Name" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>. 

; Author information
;   Author name : Paige Saychareun
;   Author email: psaychareun@csu.fullerton.edu
;   Author section: 240-9
;   Author CWID :

extern printf

global huron

section .data
    half dq 0.5    ; Constant 0.5 for semi-perimeter calculation (double precision)

section .text

huron:
    ; Function prologue
    push rbp
    mov rbp, rsp

    ; Inputs: xmm0 = side1, xmm1 = side2, xmm2 = side3
    ; Output: xmm0 = computed area

    ; Compute semi-perimeter: s = (side1 + side2 + side3) / 2
    movsd xmm3, xmm0        ; xmm3 = side1
    addsd xmm3, xmm1        ; xmm3 += side2
    addsd xmm3, xmm2        ; xmm3 += side3
    mulsd xmm3, qword [half] ; s = (side1 + side2 + side3) * 0.5

    ; Compute (s - side1), (s - side2), (s - side3)
    movsd xmm4, xmm3        ; xmm4 = s
    subsd xmm4, xmm0        ; xmm4 = (s - side1)

    movsd xmm5, xmm3        ; xmm5 = s
    subsd xmm5, xmm1        ; xmm5 = (s - side2)

    movsd xmm6, xmm3        ; xmm6 = s
    subsd xmm6, xmm2        ; xmm6 = (s - side3)

    ; Compute Heron's formula: sqrt(s * (s-a) * (s-b) * (s-c))
    mulsd xmm3, xmm4        ; s * (s - side1)
    mulsd xmm3, xmm5        ; * (s - side2)
    mulsd xmm3, xmm6        ; * (s - side3)

    sqrtsd xmm0, xmm3       ; sqrt(result), store final area in xmm0

    ; Function epilogue
    pop rbp
    ret                     ; Return area in xmm0

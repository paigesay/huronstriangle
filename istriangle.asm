; Program name: "Huron’s Triangles". Determines if the provided sides form a triangle.
; Copyright (C) 2025  Paige Saychareun

; This file is part of the software program "Huron's Triangle".

; "Huron’s Triangles" is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; "Huron’s Triangles" is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>. 

; Author information
;   Author name : Paige Saychareun
;   Author email: psaychareun@csu.fullerton.edu
;   Author section: 240-9
;   Author CWID : 884902354


extern printf

global istriangle

section .data
    invalid_msg db "Invalid triangle detected!", 10, 0
    valid_msg db "Valid triangle!", 10, 0

section .text

istriangle:
    push rbp
    mov rbp, rsp

    ; Check triangle inequality conditions
    movsd xmm3, xmm0
    addsd xmm3, xmm1
    comisd xmm3, xmm2
    jbe not_a_triangle  ; (side1 + side2 <= side3)

    addsd xmm3, xmm2  ; Now xmm3 = side1 + side2 + side3
    subsd xmm3, xmm0  ; Now xmm3 = (side2 + side3)
    comisd xmm3, xmm0
    jbe not_a_triangle  ; (side2 + side3 <= side1)

    subsd xmm3, xmm1  ; Now xmm3 = (side3)
    comisd xmm3, xmm1
    jbe not_a_triangle  ; (side3 + side1 <= side2)

    ; checks for negative/zero side lengths
    xorpd xmm6, xmm6
    comisd xmm0, xmm6
    jbe not_a_triangle
    comisd xmm1, xmm6
    jbe not_a_triangle
    comisd xmm2, xmm6
    jbe not_a_triangle

    mov rax, 1                 ; return 1 / true
    mov rdi, valid_msg
    jmp print_and_exit

not_a_triangle:
    mov rax, 0                 ; return 0 / false
    mov rdi, invalid_msg

print_and_exit:
    xor rax, rax
    call printf

    mov rsp, rbp
    pop rbp
    ret

; Program name: "Huron’s Triangles". Sends prompts to user.
; Copyright (C) 2025  Paige Saychareun

; This file is part of the software program "Huron's Triangle".

; "Huron's Triangle" is free software: you can redistribute it and/or modify
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
;   Author CWID : 884902354

extern printf
extern scanf
extern istriangle
extern huron

global manager

section .data
    prompt1 db "Please enter the lengths of three sides of a triangle:", 10, 0
    prompt2 db "Side 1: ", 0
    prompt3 db "Side 2: ", 0
    prompt4 db "Side 3: ", 0
    valid_msg db "These inputs have been tested and they are sides of a valid triangle.", 10, 0
    invalid_msg db "These inputs have been tested and they are not sides of a valid triangle. Please enter new values.", 10, 0
    error_msg db "Invalid input detected! Please enter valid floating-point numbers.", 10, 0
    area_msg db "The Heron formula will be applied to find the area.", 10, 0
    result_msg db "The area is %.4f square units. This number will be returned to the caller module.", 10, 0
    thank_you_msg db "Thank you %s. Your patronage is appreciated.", 10, 0
    return_msg db "A zero will now be returned to the operating system.", 10, 0
    stringformat db "%s", 0
    float_format db "%lf", 0

section .bss
    nameInput resb 32
    side1 resq 1
    side2 resq 1
    side3 resq 1
    area  resq 1  ; stores computed area before returning

%include "triangle.inc"  ; includes macro definitions

section .text
manager:

    backup_gprs

    ; receives user input
    mov rdi, stringformat
    lea rsi, [nameInput]
    call scanf

    display_contact_info   ; calls the macro to print author information

input_loop:
    ; prompts for sides
    mov rdi, prompt1
    call printf

    ; get valids side1
get_side1:
    mov rdi, prompt2
    call printf
    mov rdi, float_format
    lea rsi, [side1]
    call scanf
    cmp rax, 1
    jne invalid_input    ; If input is not valid, restart input process

    ; gets valid side2
get_side2:
    mov rdi, prompt3
    call printf
    mov rdi, float_format
    lea rsi, [side2]
    call scanf
    cmp rax, 1
    jne invalid_input    ; If input is not valid, restart input process

    ; gets valid side3
get_side3:
    mov rdi, prompt4
    call printf
    mov rdi, float_format
    lea rsi, [side3]
    call scanf
    cmp rax, 1
    jne invalid_input    ; If input is not valid, restart input process

    ; makes sure that all sides are positive (> 0)
    movsd xmm0, qword [side1]
    xorpd xmm6, xmm6
    comisd xmm0, xmm6
    jbe invalid_input  ; for side 1

    movsd xmm1, qword [side2]
    comisd xmm1, xmm6
    jbe invalid_input  ; for side 2

    movsd xmm2, qword [side3]
    comisd xmm2, xmm6
    jbe invalid_input  ; for side 3

    ; calls istriangle function to check validity
    call istriangle

    cmp rax, 0
    je invalid_triangle  ; if it’s not a valid triangle, ask for new inputs

    ; prints valid message
    mov rdi, valid_msg
    xor rax, rax
    call printf

    mov rdi, area_msg
    xor rax, rax
    call printf

    ; computes area
    movsd xmm0, qword [side1]
    movsd xmm1, qword [side2]
    movsd xmm2, qword [side3]
    call huron  ; Area is returned in xmm0

    ; saves result to memory
    movsd qword [area], xmm0

    ; prints area
    mov rdi, result_msg
    mov rax, 1
    movq rsi, xmm0
    call printf

    ; thank u message
    mov rdi, thank_you_msg
    lea rsi, [nameInput] ; users name
    xor rax, rax
    call printf

    ; final return message
    mov rdi, return_msg
    xor rax, rax
    call printf

    ; restores computed value before returning
    movsd xmm0, qword [area]

    jmp exit_manager

invalid_input:
    mov rdi, error_msg
    xor rax, rax
    call printf

    ; clears input buffer to avoid infinite loop
clear_buffer:
    mov rdi, stringformat  ; reads a single character
    lea rsi, [nameInput]   ; uses nameInput as temporary buffer
    call scanf
    cmp rax, 1
    jne clear_buffer       ; continues clearing until input is discarded

    jmp input_loop    ; restarts the input process


invalid_triangle:
    mov rdi, invalid_msg
    xor rax, rax
    call printf
    jmp input_loop    ; also restarts input process

exit_manager:
    restore_gprs
    ret  ; returns xmm0 to main()

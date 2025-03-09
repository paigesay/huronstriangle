; Program name: "Huron’s Triangles". Contains macros and shared defs. for the Huron's Triangles.
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

%macro backup_gprs 0
    push rbp        ; saves old base pointer
    mov rbp, rsp    ; sets up new base pointer
    sub rsp, 32     ; allocates stack space (adjust as needed)
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
%endmacro


%macro restore_gprs 0
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
    mov rsp, rbp    ; restores stack pointer
    pop rbp         ; restores old base pointer
%endmacro

%macro backup_other_regs 0
    pushf
%endmacro

%macro restore_other_regs 0
    popf
%endmacro

%macro display_contact_info 0
    mov rdi, contact_msg_1
    xor rax, rax   ; ensure printf knows there aren;t floating-point arguments
    call printf

    mov rdi, contact_msg_2
    xor rax, rax
    call printf

    mov rdi, contact_msg_3
    xor rax, rax
    call printf

    mov rdi, contact_msg_4
    xor rax, rax
    call printf
%endmacro

section .data
contact_msg_1 db "This program is brought to you as a courtesy of", 10, 0
contact_msg_2 db "Author: Paige Saychareun", 10, 0
contact_msg_3 db "Cwid: ", 10, 0
contact_msg_4 db "Email: psaychareun@csu.fullerton.edu", 10, 0

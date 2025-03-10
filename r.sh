#!/bin/bash

# Program name: "Huron’s Triangles". Bash file.
# Copyright (C) 2025  Paige Saychareun

# This file is part of the software program "Huron's Triangle".

# "Huron's Triangle" is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# "Huron's Triangle" is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>. 

# Author information
#   Author name : Paige Saychareun
#   Author email: psaychareun@csu.fullerton.edu
#   Author section: 240-9
#   Author CWID : 884902354

echo "Cleaning up previous build files..."
rm -f triangle

echo "Compiling C/C++ main file..."
gcc -c -m64 -no-pie -o triangle.o triangle.c

echo "Assembling manager.asm..."
nasm -f elf64 -o manager.o manager.asm

echo "Assembling istriangle.asm..."
nasm -f elf64 -o istriangle.o istriangle.asm

echo "Assembling huron.asm..."
nasm -f elf64 -o huron.o huron.asm

echo "Linking all object files..."
gcc -m64 -no-pie -o triangle triangle.o manager.o istriangle.o huron.o -lm

echo "Build successful! Running the program..."
./triangle

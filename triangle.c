// Program name: "Huron’s Triangles". Sends prompts to user, the driver file.
// Copyright (C) 2025  Paige Saychareun

// This file is part of the software program "Huron's Triangle".

// "Huron's Trigangles" is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// "Huron's Triangles" is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Author information
//   Author name : Paige Saychareun
//   Author email: psaychareun@csu.fullerton.edu
//   Author section: 240-9
//   Author CWID : 884902354

#include <stdio.h>

// Function prototype for manager
extern double manager();

int           main()
{
  printf( "Welcome to Huron’s Triangles. We take care of all your triangle needs.\n" );
  printf( "Please Enter Your Name: \n" );

  double area = manager();    // calls the manager function in ASM

  printf( "The main function has received this number %.4f, and will keep it for a while.\n", area );
  printf( "Thank you. Your patronage is appreciated.\n" );
  printf( "A zero will now be returned to the operating system.\n" );

  return 0;
}

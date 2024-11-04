//=================================================================
// Copyright 2024 Georgia Tech.  All rights reserved.
// The materials provided by the instructor in this course are for
// the use of the students currently enrolled in the course.
// Copyrighted course materials may not be further disseminated.
// This file must not be made publicly available anywhere.
//=================================================================

#include <stdio.h>
#include <stdlib.h>

/* 
 Student Name:
 Date:

ECE 2035 Homework 1-2

This is the only file that should be modified for the C implementation
of Homework 1.

Do not include any additional libraries.

This program computes the Intersection over Union of two rectangles
as an integer representing a percent:
                 Area(Intersection of R1 and R2) * 100
  IoU =    -----------------------------------------------------
           Area(R1) + Area(R2) - Area(Intersection of R1 and R2)

Assumptions for this homework:	
  1. R1 and R2 do overlap (Area of intersection of R1 and R2 != 0)
  2. only R1's bottom left corner is inside R2, and only R2's top
     right corner is inside R1.	

Input: two bounding boxes, each specified as {Tx, Ty, Bx, By), where
	 (Tx, Ty) is the upper left corner point and
	 (Bx, By) is the lower right corner point.
       These are given in two global arrays R1 and R2.
Output: IoU (an integer, 1 <= IoU <= 99).

IoU should be specified as an integer (only the whole part of the division),
i.e., round down to the nearest whole number between 1 and 100 inclusive.

FOR FULL CREDIT (on all assignments in this class), BE SURE TO TRY
MULTIPLE TEST CASES and DOCUMENT YOUR CODE.
*/

//DO NOT change the following declaration (you may change the initial value).
// Bounding box: {Tx, Ty, Bx, By}
int R1[] = {64, 51, 205, 210};
int R2[] = {19, 65, 190, 326};
int IoU;

/*
For the grading scripts to run correctly, the above declarations
must be the first lines of code in this file (for this homework
assignment only).  Under penalty of grade point loss, do not change
these lines, except to replace the initial values while you are testing
your code.  

Also, do not include any additional libraries.
 */

int main() {

  // insert your code here

  IoU = -999;  // Remove this line. (It's only provided so that shell code compiles w/out warnings.)

  printf("Intersection over Union: %d%%\n", IoU);
  return 0;
}




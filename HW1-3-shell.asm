#=================================================================
# Copyright 2024 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================

# HW1-3
# Student Name:
# Date:
#
# This program computes the Intersection over Union of two rectangles
# as an integer representing a percent:
#                 Area(Intersection of R1 and R2) * 100
#  IoU =    -----------------------------------------------------
#           Area(R1) + Area(R2) - Area(Intersection of R1 and R2)
#
# Assumptions for this homework:	
#  1. R1 and R2 do overlap (Area of intersection of R1 and R2 != 0)
#  2. only R1's bottom left corner is inside R2, and only R2's top
#     right corner is inside R1.	
#
# Input: two bounding boxes, each specified as (Tx, Ty, Bx, By), where
#	 (Tx, Ty) is the upper left corner point and
#	 (Bx, By) is the lower right corner point.
# Output: IoU (an integer, 1 <= IoU <= 99).
#
# IoU should be specified as an integer (only the whole part of the division),
# i.e., round down to the nearest whole number between 1 and 99 inclusive.
#
# Also, for HW1 (only), do not write values to registers $0, $29, $30, or $31
# and do NOT use helper functions or function calls (JAL).
#
# FOR FULL CREDIT (on all assignments in this class), BE SURE TO TRY
# MULTIPLE TEST CASES and DOCUMENT YOUR CODE.

.data
# DO NOT change the following three labels (you may change the initial values):
#               Tx, Ty,  Bx, By	
R1:	.word	64, 51, 205, 210
R2:	.word	19, 65, 190, 326
IoU:	.alloc  1
	
.text
	# write your code here...
	
End:	jr $31	     			# return to OS

